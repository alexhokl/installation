# AGENTS.md — Coding Agent Guide

This repository documents machine installation and configuration for macOS,
Arch Linux, and Debian/Ubuntu systems. It is primarily composed of Bash shell
scripts and plain-text package lists. There is no compiled code, no test suite,
and no build system beyond the single `Makefile` target.

---

## Repository Structure

```
installation/
├── Makefile                  # Single target: print-latest-versions
├── functions_common          # Shared Bash functions sourced by all platforms
├── versions-on-github        # Pinned tool versions (KEY=value format)
├── print-latest-versions.sh  # Queries GitHub API to refresh versions-on-github
├── requirements.txt          # Python packages (pip)
├── go_packages               # Go tools (one import path per line)
├── cargo_packages            # Rust crates (one crate name per line)
├── cargo_git_packages        # Rust crates installed via --git (one URL per line)
├── npm-list.txt              # npm global packages (one package per line)
├── pipx_packages             # pipx tools (one package per line)
├── dotnet_tools              # .NET global tools (one tool ID per line)
├── gem-list                  # Ruby gems (one gem per line)
├── opam_packages             # OCaml opam packages (one package per line)
├── krew_list                 # kubectl krew plugins (one plugin per line)
├── gh_extensions             # GitHub CLI extensions (one repo per line)
├── vscode-extensions.txt     # VS Code extensions (one extension ID per line)
├── vscode_settings.json      # VS Code user settings
├── azuredatastudio.extensions # Azure Data Studio extensions
├── repo_list                 # Git repositories to clone into ~/git/
├── apm-list.txt              # Atom package list (legacy)
├── node_setup.sh             # npm global prefix configuration
├── uv_tools_install.sh       # uv tool installations
├── mac/                      # macOS-specific scripts and package lists
│   ├── setup_initial.sh      # First-run: Xcode CLI tools + Homebrew
│   ├── setup.sh              # Full macOS setup
│   ├── functions             # macOS-specific Bash functions
│   ├── brew_list             # Homebrew formulae
│   ├── cask_list             # Homebrew casks
│   └── preferences.scpt      # macOS system preferences via AppleScript
├── archlinux/                # Arch Linux setup scripts and package lists
│   ├── setup.sh              # Disk partitioning + base install (run as root)
│   ├── root_setup.sh         # Post-chroot root configuration
│   ├── user_setup.sh         # User-level setup
│   ├── user_setup_crostini.sh# Crostini (ChromeOS) variant
│   ├── functions             # Arch-specific Bash functions
│   ├── basic_packages        # pacman packages
│   ├── aur_packages          # AUR packages (yay)
│   ├── ui_packages           # GUI/desktop packages
│   └── create_vm.sh          # VM creation helper
└── debian/                   # Debian/Ubuntu setup scripts
    ├── setup.sh              # Full Debian/Ubuntu setup
    ├── functions             # Debian-specific Bash functions
    ├── basic_packages.sh     # Core apt packages
    ├── desktop_packages.sh   # Desktop environment packages
    ├── ui_packages.sh        # UI application packages
    ├── backup.sh             # Backup script
    ├── preseed.cfg           # Debian automated installer config
    └── preseed.no-root.cfg   # Variant without root account
```

---

## Commands

### Update pinned tool versions

```bash
make print-latest-versions
# or directly:
./print-latest-versions.sh
```

This queries the GitHub API for the latest release of every tool pinned in
`versions-on-github` and rewrites that file in-place. Requires `curl` and `jq`.

### macOS setup

```bash
# First run only (Xcode CLI tools + Homebrew):
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/setup_initial.sh | /bin/bash

# Full setup:
curl -sSL https://raw.githubusercontent.com/alexhokl/installation/master/mac/setup.sh | /bin/bash

# Or locally:
bash mac/setup_initial.sh
bash mac/setup.sh
```

### Arch Linux setup

```bash
# Edit setup.sh to match device names, then:
bash archlinux/setup.sh        # partitioning + base install (live USB)
bash archlinux/user_setup.sh   # user packages after first reboot
```

### Debian/Ubuntu setup

```bash
sudo apt update && sudo apt install -y apt-transport-https --no-install-recommends
bash debian/setup.sh
```

### Install / update individual tool categories (after sourcing functions)

```bash
source ~/git/installation/functions_common
source ~/git/installation/mac/functions   # or archlinux/functions, debian/functions

update_all                     # update everything for the platform
install_go_packages            # go install all packages in go_packages
install_cargo_packages         # cargo install all packages in cargo_packages
install_vscode_extensions      # install all VS Code extensions
install_dotnet_tools           # install all .NET global tools
install_gh_extensions          # install all GitHub CLI extensions
install_pipx_packages          # install all pipx tools
update_python_packages         # pip upgrade all packages in requirements.txt
```

### No test suite

There are no automated tests in this repository. Validation is done by running
the scripts against a real machine.

---

## Code Style Guidelines

### Shell scripts

- **Shebang**: Use `#!/bin/bash` (not `/bin/sh` or `/usr/bin/env bash`).
  `mac/setup_initial.sh` is the only exception — it uses `#!/bin/zsh` because
  it runs before Bash is installed via Homebrew.
- **Indentation**: 2-space indentation inside function bodies. Use actual spaces
  (not tabs) in functions files. Top-level script statements are not indented.
- **Quoting**: Quote variable expansions whenever the value might contain spaces
  or be empty, e.g. `"$_DIR"`, `"${_REPO_DIRECTORY}"`. Bare expansions are
  acceptable for simple loop variables or well-known paths.
- **Variable naming**:
  - Local/temporary variables use `UPPER_SNAKE_CASE` for directory paths and
    version strings (e.g. `INSTALL_DIR`, `LOCAL_BIN`, `CURRENT_VERSION`).
  - Function-local variables that are more "implementation detail" use a leading
    underscore with either case: `_REPO_DIR`, `_status_code`, `_OS`, `_ARCH`.
  - Avoid `local` except in the Debian `functions` file where it is used
    sparingly.
- **Functions**: Named with `lower_snake_case`. Each install/update function is
  self-contained: it creates its own `INSTALL_DIR=$(mktemp -d)`, downloads
  artefacts there, installs them, and returns. No global side-effects beyond
  placing a binary in `LOCAL_BIN`.
- **Version guards**: Before downloading and installing a tool, check the
  currently installed version and skip if already up to date:
  ```bash
  if [[ -n "$(which tool)" ]]; then
    CURRENT_VERSION=$(tool --version | awk '{ ... }')
  fi
  if [ "$CURRENT_VERSION" == "$VERSION_OWNER_REPO" ]; then
    echo "tool ($CURRENT_VERSION) is up-to-date."
    return
  fi
  ```
- **Directory navigation**: Use `pushd $PWD` / `popd` pairs around blocks that
  change directory (`cd`). Never rely on the working directory being a specific
  location after a function returns.
- **curl flags**: Use `-sSL` for downloads (silent, show errors, follow
  redirects). Use `-fsSL` when a non-zero exit on HTTP error is desired.
- **sudo**: Prefix only the commands that actually require root. Do not run
  entire functions as root.
- **Comments**: Use `#` comments to label logical sections (e.g. `# chrome`,
  `# gcloud`, `# docker`). Comment out code that is temporarily disabled rather
  than deleting it, with a note explaining why.
- **Error handling**: Scripts do not use `set -e` globally. Individual
  operations that must not silently fail use explicit checks or `&&` chaining.
  Disable-and-continue patterns are preferred over aborting the whole setup.

### Package list files

- One entry per line, no trailing whitespace, no blank lines between entries.
- No comments inside list files (they are piped directly to `xargs`).
- `go_packages`: full module import paths including version suffix
  (`@latest`, `@master`, `@vX.Y.Z`).
- `versions-on-github`: `VERSION_OWNER_REPO=x.y.z` format. Owner and repo are
  separated by `_`; a double underscore `__` replaces a hyphen in the owner or
  repo name (e.g. `VERSION_VMWARE__TANZU_OCTANT`).

### Makefile

- Targets are lowercase with hyphens: `print-latest-versions`.
- Tab-indented recipe lines (standard make syntax).

### AppleScript (`mac/preferences.scpt`)

- Used only for macOS system-preference automation; not a general-purpose
  scripting language in this repo.

---

## Conventions When Adding New Tools

1. **Pin the version** in `versions-on-github` using the
   `VERSION_OWNER_REPO=x.y.z` pattern. Run `./print-latest-versions.sh` to
   populate the initial value.
2. **Add an install function** in the appropriate `functions` file
   (`functions_common` for cross-platform, `mac/functions`,
   `archlinux/functions`, or `debian/functions` for platform-specific).
3. **Call the function** from `install_all` and/or `update_all` in the same
   file.
4. **Add to the relevant list file** if the tool is managed via a package
   manager (`go_packages`, `cargo_packages`, `npm-list.txt`, etc.) rather than
   a custom download.
5. **Do not add test scaffolding** — this repo has no test framework.
