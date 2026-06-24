# WezTerm Configuration

Personal [WezTerm](https://wezfurlong.org/wezterm/) configuration with modular Lua structure.

## Features

### Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+q` | Leader key (2 sec timeout) |
| `Leader o` | List active opencode sessions (fzf) |
| `Leader r` / `Leader R` | Split pane right / horizontal |
| `Leader d` / `Leader D` | Split pane down / vertical |
| `Leader x` | Close current pane |
| `Leader ,` | Rename tab |
| `Leader w` | Workspace switcher (InputSelector) |
| `Leader s` | Enter setting mode (pane resize) |
| `Leader k` | Switch Karabiner profile |
| `Leader p` | Select AWS profile |
| `Leader u` | Codex stash (Ctrl+g → `:wq`) |
| `Leader y` | Codex stash pop |
| `Leader z` | Copy last command + output |
| `Leader b` | View buffer in Neovim (WezCapture) |
| `Leader l` | Launch command selector (ghost/lazygit/nvim/yazi) |
| `Leader a` | Quick Select ARN → open AWS Console |
| `Ctrl+Shift+c` | Minimize/restore pane to 1 row |
| `Ctrl+Shift+h/j/k/l` | Navigate panes |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next/prev tab |
| `Super+n` | New window |
| `Super+t` | New tab |
| `Super+w` | Close tab |
| `Super+1-9` | Switch tab |
| `Super+f` | Search mode |
| `Super+r` | Reload config |
| `Ctrl+P` | Command palette |
| `Ctrl+X` | Copy mode (viewport middle) |
| `Ctrl+Z` | Toggle pane zoom |
| `Ctrl+U` | Character select |
| `Ctrl+Shift+R` | Force reload config |
| `Super+Shift+Space` | Quick Select |
| `Alt+Enter` | Toggle fullscreen |
| `Alt+[` / `Alt+]` | Scroll to previous/next prompt |
| `Ctrl+Alt+p` / `Ctrl+Alt+n` | Scroll half page up/down |

### Setting Mode (`Leader s`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Adjust pane size (1 unit) |
| `1-9` | Set pane width to 10-90% |
| `Alt+1-9` | Set pane height to 10-90% |
| `;` | Increase opacity |
| `-` | Decrease opacity |
| `0` | Reset opacity |
| `Esc` / `q` | Exit setting mode |

### Copy Mode (`Ctrl+X`)

Vim-style key bindings: `h/j/k/l`, `w/b/e`, `v/V/Ctrl+v` (select), `y` (copy), `f/t/F/T` (jump), `z` (semantic zone select), `[/]` (input zone jump).

### Tabs

- Icon and color per process type (opencode, neovim, docker, SSH, nb)
- Zoom indicator when a pane is zoomed
- Rounded active tab decoration
- Custom tab rename via `Leader ,`

### Status Bar

- Workspace name display with color coding (yellow = copy mode, green = setting mode)
- Cursor color changes with active key table

### Open Code Integration

- Tab icon detection for opencode sessions
- `Leader o` launches fzf to list and switch between active opencode sessions
- Preview pane shows session details and recent output
- Launch from command palette (`Ctrl+P` → "Launch: Open Code")

### Workspaces

| Key | Action |
|-----|--------|
| `Ctrl+Super+s` | Toggle scratch workspace |
| `Ctrl+Super+a` | Toggle nb workspace |
| `Ctrl+Super+n/p` | Next/prev workspace (skip scratch/nb) |
| `Leader w` | Workspace switcher |
| `Shift+C` (workspace mode) | Create new workspace |

### AWS Profile Selector (`Leader p`)

Lists profiles from `aws configure list-profiles` or `~/.aws/config` and inserts `export AWS_PROFILE=<name>`.

### Karabiner Profile Switcher (`Leader k`)

Reads profiles from `~/.config/karabiner/karabiner.json` and switches via `karabiner_cli`.

### Caffeinate Control

Available from command palette (`Ctrl+P`). Start/stop `caffeinate` to prevent sleep with preset durations (30min, 1hr, 2hr, unlimited).

### Translation (copy mode)

Select text in copy mode and press `Shift+Y` to translate to Japanese via `plamo-translate-cli`.

### Focus-linked Opacity

- Focused: `opacity = 0.9` (blur visible)
- Unfocused: `opacity = 1.0` (blur hidden)

### Quick Select (`Super+Shift+Space`)

Patterns: URLs, AWS ARNs, file paths, git commit hashes, IP addresses, UUIDs.

## Modules

| File | Description |
|------|-------------|
| `wezterm.lua` | Entry point |
| `keymaps.lua` | Key bindings, command palette |
| `appearance.lua` | Colorscheme, window decorations |
| `statusbar.lua` | Workspace display, cursor color |
| `tab.lua` | Tab title formatting, process detection |
| `workspace.lua` | Workspace management |
| `modules/opacity.lua` | Window opacity control |
| `modules/aws_profile.lua` | AWS profile selector |
| `modules/karabiner_profile.lua` | Karabiner profile switcher |
| `modules/caffeinate.lua` | Sleep prevention |
| `modules/opencode_session.lua` | Open code session fzf switcher |
| `modules/translate.lua` | Text translation |
| `scripts/preview_opencode_session.lua` | fzf preview script for opencode sessions |

## Requirements

- [WezTerm](https://wezfurlong.org/wezterm/)
- [fzf](https://github.com/junegunn/fzf) (for `Leader o` session switcher)
- [jq](https://jqlang.github.io/jq/) (for session preview)
- [opencode](https://opencode.ai) (optional, for opencode integration)
- [Karabiner-Elements](https://karabiner-elements.pqrs.org/) (optional, for profile switcher)
- [AWS CLI](https://aws.amazon.com/cli/) (optional, for profile selector)
- [plamo-translate-cli](https://github.com/mozumasu/plamo-translate) (optional, for translation)
