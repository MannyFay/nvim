# Neovim Configuration
# Project Status: Rebuilding
This project is currently in the rebuilding phase. Be careful if you want to use it.  

---
<br>

# Old Part of README
My system: macOS  
This is a beginner friendly entry point to Neovim.  
All files are well documentated, so you can dive easily in and understand what is happening.

## Recommendation
I highly recommend to learn blind typing if you would like to use Neovim.  
A good place to start is the [Tipp10 page](https://www.tipp10.com/en/).  
Personally I like a keyboard with US ANSI layout the best.

## Requirements
To use this Neovim configuration you have to set up a few things.  
If you are very new on this topic, pleace read the [beginners-guide](./docs/beginners-guide.md).
* Neovim
* Java
* Graphviz
* Ripgrep
* Nerd Font (I use Meslo Nerd Font)
* CMake, make, Clang
* Deno


## Quick Start
Open your terminal, make shure you are in your home directory:
```shel
cd ~
```
Create directory structure for Neovim:
```shell
mkdir -p ~/.config/nvim
```
Now copy the lua directory and the init.lua file in your nvim directory.  
Open Neovim:
```shell
nvim
```
Normally, Neovim looks now not how you hope. Press `:` and do:
```shell
PackerUpdate
```
Discard after finishing the popup with `q`, then do `:` and:
```shell
PackerSync
```
Close the popup again with `q` and close Neovim with pressing `ZZ` till you are in your terminal again.  
If you open Neovim again, it should look a little better.

## Further Documentation
* [Beginners Guide](./docs/beginners-guide.md)
* [Neovim Commands](./docs/nvim-commands.md)
* [Neovim Commands as Post-Its](./docs/post-its.md)

## Like?
If you like that repo, you can sponsor it on my [Patreon account](https://www.patreon.com/Manny556).
