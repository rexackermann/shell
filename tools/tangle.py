#!/usr/bin/env python3
"""Minimal, dependency-free Org tangler for zshrc.org (no Emacs needed).

Usage: tangle.py [--check] ORGFILE OUTDIR

Honours #+PROPERTY header-args (:tangle, :shebang), per-block :tangle, :shebang,
and ':tangle no'. Targets under ~/.config/zsh/ are written to OUTDIR/<name>;
~/.zshenv -> OUTDIR/home.zshenv, ~/.p10k.zsh -> OUTDIR/.p10k.zsh.
With --check, every generated file is syntax-checked with `zsh -n`.
"""
import re, sys, os, subprocess, shlex

MAP = {'~/.zshenv': 'home.zshenv', '~/.p10k.zsh': '.p10k.zsh', '~/.profile': '.profile'}

def parse_args(s):
    """Parse org header args; a value runs until the next ' :keyword'."""
    out = {}
    for m in re.finditer(r':(\w+)\s+(.*?)(?=\s+:\w+(?:\s|$)|$)', s):
        v = m.group(2).strip()
        if len(v) >= 2 and v[0] == v[-1] == '"': v = v[1:-1]
        out[m.group(1)] = v
    return out

def main():
    a = [x for x in sys.argv[1:] if x != '--check']
    check = '--check' in sys.argv
    org, outdir = a
    text = open(org, encoding='utf-8').read().split('\n')
    prop = {}
    for l in text:
        m = re.match(r'#\+PROPERTY:\s+header-args\s+(.*)', l, re.I)
        if m: prop.update(parse_args(m.group(1)))
    files, order, cur = {}, [], None
    for l in text:
        m = re.match(r'#\+begin_src\s+(\S+)(.*)$', l, re.I)
        if m and cur is None:
            h = dict(prop); h.update(parse_args(m.group(2)))
            cur = (h, []); continue
        if re.match(r'#\+end_src', l, re.I) and cur is not None:
            h, body = cur; cur = None
            t = h.get('tangle', 'no')
            if t == 'no': continue
            if t not in files: files[t] = (h.get('shebang', ''), []); order.append(t)
            files[t][1].append('\n'.join(body).strip('\n'))
            continue
        if cur is not None: cur[1].append(l)
    os.makedirs(outdir, exist_ok=True)
    written = []
    for t in order:
        sb, blocks = files[t]
        if t in MAP: name = MAP[t]
        elif t.startswith('~/.config/zsh/'): name = t[len('~/.config/zsh/'):]
        else: print(f'skip (outside repo layout): {t}'); continue
        path = os.path.join(outdir, name)
        os.makedirs(os.path.dirname(path) or '.', exist_ok=True)
        body = '\n\n'.join(blocks) + '\n'
        if sb: body = sb + '\n' + body
        open(path, 'w', encoding='utf-8').write(body)
        written.append(path); print('wrote', path)
    if check:
        bad = 0
        for p in written:
            r = subprocess.run(['zsh', '-n', p], capture_output=True, text=True)
            if r.returncode: bad += 1; print('SYNTAX ERROR', p, r.stderr[:300])
        if bad: sys.exit(1)
        print('zsh -n: all generated files OK')

if __name__ == '__main__':
    main()
