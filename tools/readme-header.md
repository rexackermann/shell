<h1 align="center">🦖 Rex Shell 2026</h1>
<p align="center"><b>Zim + Powerlevel10k, written as one Org file.</b><br>
Neon prompt · distro/CPU-aware segments · incognito history · optional-deps tolerant</p>

<p align="center">
  <a href="https://github.com/rexackermann/shell/actions/workflows/build.yml"><img alt="build" src="https://img.shields.io/github/actions/workflow/status/rexackermann/shell/build.yml?branch=main&style=for-the-badge&logo=githubactions&logoColor=white&label=build"></a>
  <img alt="zsh" src="https://img.shields.io/badge/zsh-5.9%2B-89e051?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="zim" src="https://img.shields.io/badge/framework-Zim-ff69b4?style=for-the-badge">
  <img alt="p10k" src="https://img.shields.io/badge/prompt-Powerlevel10k-00afff?style=for-the-badge">
  <img alt="org" src="https://img.shields.io/badge/source-Org%20Babel-77aa99?style=for-the-badge&logo=gnuemacs&logoColor=white">
  <a href="LICENSE"><img alt="license" src="https://img.shields.io/github/license/rexackermann/shell?style=for-the-badge"></a>
  <img alt="last commit" src="https://img.shields.io/github/last-commit/rexackermann/shell?style=for-the-badge">
</p>

<p align="center"><code>{{VERSION}}</code> · {{LINES}} lines · {{BLOCKS}} code blocks · {{FUNCS}} functions · {{ALIASES}} aliases</p>

> GitHub's Org renderer is down at the moment, so this README is **generated from
> [`zshrc.org`](zshrc.org)** by CI on every push. The sections below are that file, collapsed.

## ⚡ Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/rexackermann/shell/main/setup.sh)"
```

Clones to `~/.config/zsh` and links `~/.zshenv`, `~/.profile` and `~/.p10k.zsh`.
Zim and Powerlevel10k install themselves on first start.

## 🧭 How it fits together

```mermaid
flowchart LR
  A["📄 zshrc.org<br/>(edit this)"] -->|"tools/tangle.py · CI"| B[".zshrc · .zshenv · .profile<br/>zimrc · .p10k.zsh"]
  B --> C["~/.config/zsh"]
  C -->|"setup.sh links"| D["~/.zshenv · ~/.profile · ~/.p10k.zsh"]
```

| Path | Purpose |
|---|---|
| [`zshrc.org`](zshrc.org) | Source of truth. Edit this. |
| `.zshrc` `.zshenv` `.profile` `zimrc` `.p10k.zsh` `home.zshenv` | Generated from the org file |
| [`tools/tangle.py`](tools/tangle.py) | Emacs-free tangler (`--check` runs `zsh -n`) |
| [`bin/`](bin) | Helper scripts, on `PATH` |
| [`setup.sh`](setup.sh) | Installer |
| [`archive/`](archive) | Previous org, installer and sync script |

## 📚 The config

Click a section to expand it.

