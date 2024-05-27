# Beginners Guide to my Neovim Configuration
[Neovim](https://neovim.io/) can be at the beginnig a bit overwhelming. I hope 
with this configuration you can dive in faster.  
Sure, you have to learn commands but I have reduce them to get you in fast.

Why Neovim? Well, I've tried already [JetBrains IDEs](https://www.jetbrains.com/), 
[Visual Studio Code](https://code.visualstudio.com/), [Visual Studio](https://visualstudio.microsoft.com/), 
[Code::Blocks](https://www.codeblocks.org/), [Brackets](https://brackets.io/) 
and [Atom](https://github.com/atom/atom).  
But none of them are like [Neovim](https://neovim.io/). Some of them cost a lot 
of money, especially for commercial use and for me, all of these have this 
'hmm.., I would like to do..' thing.
All of these take their time to learn too - so why don't thake the time to learn 
[Neovim](https://neovim.io/) and build it up for your needs.  

With Neovim this 'hmm.., I would like to do..' thing nearly doesn't exist. You 
can make it your own with an awesome mouseless use for incredibly higher speed 
on editing.

This guide starts of the very beginnig to start over with [Neovim](https://neovim.io/).

## Configuration
I'm on [Apple macOS](https://www.apple.com/de/macos), so if you would like to 
use this configuration on an other OS, feel free to tweak it for your needs.

Let's get our hands dirty 🧱🔨  

Install [Homebrew package manager](https://brew.sh/):
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install [Neovim](https://neovim.io/):
```shell
brew install neovim
```
Create Neovim directory on your machine if it doesn't exist yet:
```shell
mkdir -p ~/.config/nvim
```
Copy (or clone with Git) the lua directory and the init.lua file from [here](https://github.com/MannyFay/neovim)
into the nvim directory.

Install Node.js:
```shell
brew install node
```

Install [Graphviz](https://graphviz.org/):
```shell
brew install graphviz
```
Install [Java](https://en.wikipedia.org/wiki/Java) (do not use [Homebrew](https://brew.sh/)!):
```shell
https://www.oracle.com/java/technologies/downloads/#jdk20-mac
```
Install [ripgrep](https://github.com/BurntSushi/ripgrep):
```shel
brew install ripgrep
```
Install Meslo [Nerd Fonts](https://www.nerdfonts.com/):
```shell
brew tap homebrew/cask-fonts &&
brew install --cask font-meslo-nerd-font
```
Select the `MesloLGMDZ Nerd Font Propo` as your terminal/Neovim font.

Check out, if you have [Clang](http://clang.org/) C/C++ compiler installed:
```shell
clang --version
```
...if not, install it:
```shell
xcode-select --install
```
Install [Cmake](https://cmake.org/):
```
brew install make
```
Install Deno JavaScript runtime:
```shell
brew install deno
```
Open [Neovim](https://neovim.io/) (at this point, maybe it seems like there will go on lots of weird things - don't worry!):
```shell
nvim
```
Update [Packer package manager](https://github.com/wbthomason/packer.nvim). Press `:` then run:
```shell
PackerUpdate
```
Quit the popup with `q`.

Sync [Packer](https://github.com/wbthomason/packer.nvim) packages. Press `:` then run:
```shell
PackerSync
```
Quit the popup with `q`.

Close Neovim by pressing `ZZ` till you arrive into your terminal.  

Start [Neovim](https://neovim.io/) again:
```shell
nvim
```
Now it should look a little better. Maybe you see some installation progress in
the [Neovim](https://neovim.io/) command line. Just let it do it's thing.  

To get arround in your [Neovim](https://neovim.io/), I've written a [documentation about the commands](nvim-commands.md).
