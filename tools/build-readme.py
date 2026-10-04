#!/usr/bin/env python3
"""Build README.md from zshrc.org: hero header + the org file as collapsible sections.

Usage: build-readme.py ORGFILE README.md   (needs pandoc)
Deterministic output (no timestamps) so CI only commits when the org file changes.
"""
import re, subprocess, sys, os

org, out = sys.argv[1:3]
here = os.path.dirname(os.path.abspath(__file__))
src = open(org, encoding='utf-8').read()

# --- stats -----------------------------------------------------------------
title = re.search(r'#\+TITLE:.*?(v\d+)\s*$', src, re.M)
stats = {
    'VERSION': title.group(1) if title else '',
    'LINES': f"{src.count(chr(10)):,}",
    'BLOCKS': str(len(re.findall(r'^#\+begin_src', src, re.M | re.I))),
    'FUNCS': str(len(set(re.findall(r'^\s*(?:function\s+)?([A-Za-z_][\w.-]*)\(\)\s*\{', src, re.M)))),
    'ALIASES': str(len(set(re.findall(r'^\s*alias(?:\s+-\w+)*\s+([\w.-]+)=', src, re.M)))),
}
header = open(os.path.join(here, 'readme-header.md'), encoding='utf-8').read()
for k, v in stats.items():
    header = header.replace('{{%s}}' % k, v)

# --- org -> gfm ------------------------------------------------------------
md = subprocess.run(
    ['pandoc', '-f', 'org', '-t', 'gfm', '--wrap=none', '--shift-heading-level-by=1', org],
    capture_output=True, text=True, check=True).stdout

# --- split on level-2 headings (outside code fences) and make them collapsible
sections, cur, fence = [], None, False
preamble = []
for line in md.split('\n'):
    if re.match(r'^\s*(```|~~~)', line):
        fence = not fence
    if not fence and re.match(r'^## ', line):
        cur = [line]; sections.append(cur)
    elif cur is None:
        preamble.append(line)
    else:
        cur.append(line)

parts = [header.rstrip('\n'), '']
for sec in sections:
    heading = sec[0][3:].strip()
    if heading.lower() == 'install':
        continue  # the hero header already has the install block
    body = '\n'.join(sec[1:]).strip('\n')
    open_attr = ' open' if heading.lower().startswith('install') else ''
    parts.append(f'<details{open_attr}>\n<summary><h3>{heading}</h3></summary>\n\n{body}\n\n</details>\n')
text = '\n'.join(parts).rstrip('\n') + '\n'
open(out, 'w', encoding='utf-8').write(text)
print(f'wrote {out}: {len(text):,} bytes, {len(parts) - 2} sections')
