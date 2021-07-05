# nvim

My neovim settings

![image](https://user-images.githubusercontent.com/48394190/120484401-ff21c200-c3ed-11eb-9036-cf03a0aa1335.png)

#### Sample source code by [Peyang](https://github.com/peyang-Celeron)

[Project board](https://github.com/Potato1682/nvim/projects/1)

## Requirements

-   **Neovim nightly build**
-   Pipenv
-   Git
-   GCC
-   Go
-   Node.js and NPM
-   Yarn
-   `jq`
-   Java >= 11
-   Docker Engine
-   Ruby and [Bundler](https://bundler.io)
-   [nonicons](https://github.com/yamatsum/nonicons) patched font

## Features

-   Plugin Manager
-   Automatic plugin manager setup
-   Beautiful color schemes
-   Treesitter-based code highlighting
-   Super useful bufferline
-   Super functional statusline
-   Supercharged file explorer
-   Fuzzy search with floating window
-   Nerd fonts support
-   **L**anguage **S**erver **P**rotocol support
    -   Code folding
    -   Renaming
    -   Completion
    -   Database support
    -   Diagnostics
        -   Diagnostics report will shown on statusline, bufferline, editor and explorer
    -   Show lightbulb when code action is available
    -   Show signature and document on hover
    -   Automatic formatting
-   Rainbow brackets
-   Toggle comments
-   Show git status on editor
-   Wakatime support
-   Document generation
-   Indent line
-   Automatic pair insert
-   Git integrations
-   Leader key menu
-   **D**ebug **A**dapter **P**rotocol support
    -   Toggle Breakpoint
    -   Search Breakpoint
    -   Debug Control
    -   Automatic DAP Installation
-   Automatic root setting
-   Increase number on editor
-   Show current context on bracket ending
-   Online collaboration
-   Zen mode
-   Colorbuddy support
-   Show TODO List
-   Global settings
-   Errors List
-   Markdown preview
-   [Template generation](docs/TEMPLATE-FILE.md)
-   Automatic license file generation
-   Redmine integration
-   Custom color highlighting
-   Spell-check
-   Right mouse drag gestures
-   Discord Rich Presence support
-   Under cursor increment and decrement
-   Editorconfig support

## Trouble Shooting

### Can't install java test runner with node-sass error

It may be because your Node.js version is too high.  
May succeed by running these commands and temporarily lowering your Node.js version.

```bash
$ sudo npm i -g n
$ cd ~/.local/share/nvim/dapinstall/java/java-test
$ PATH="/usr/local/bin/node:$PATH" bash
$ npm i --cache $(mktemp -d)
$ npm run build-plugin
```

### Some servers stopped working by exit code 125 or 126

If you're using `podman`, you may not be using unqualified search registries. ( code 125 )  
Comment-out / Add the property to `/etc/containers/registries.conf` like this:

```tst
unqualified-search-registries = ["docker.io"]
```

If it doesn't work, you may not installed OCI runtime. ( code 126 )  
These are runtime binaries:

-   For cgroups v1 : `runc`
-   For cgroups v2 : `crun`

### Discord Rich Presence is not working

nvim is using [presence.nvim](https://github.com/andweeb/presence.nvim) to show Rich Presence.  
If there is a Failed to get Discord IPC socket error, your particular OS may not yet be supported, check [Projects card](https://github.com/andweeb/presence.nvim/projects/1#column-14183588).
Or if you're using Flatpak'ed discord, [this link](https://github.com/flathub/com.discordapp.Discord/wiki/Rich-Precense-(discord-rpc) might useful.
