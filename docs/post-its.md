# Neovim Commands as Post-Its
Here you can see a possible structure for Post-Its with Neovim commands.  
I've liked to put them at the bottem frame of my screen to get them into my
brain over time.  
`<L>` means Leader-Key, which is in this Neovim configuration `space`.  
If there are abbreviations you don't understand, look at the
[nvim-commnands](/docs/nvim-commands.md) documentation for the command.

<br>

## Project Tree

|Tree               |   |              |         |   |             |         |   |              |
|:------------------|:-:|:-------------|:--------|:-:|:------------|:--------|:-:|:-------------|
| `<L>` `t` `t`     | = | toggle tree  | `-`     | = | hor. split  | `d`     | = | delete       |
| `<L>` `e` `t`     | = | explore tree | `y`     | = | yank name   | `B`     | = | bin          |
| `<L>` `s` `f` `t` | = | show file    | `Y`     | = | yank path   | `C`     | = | collapse     |
| `q` `n`           | = | close node   | `c`     | = | copy        | `E`     | = | expand       |
| `r`               | = | rename       | `x`     | = | cut         | `T` `S` | = | top sib.     |
| `i`               | = | info         | `p`     | = | paste       | `B` `S` | = | bot. sib.    |
| `enter`           | = | open         | `P`     | = | parent node | `K`     | = | previous sib.|
| `|`               | = | vert. split  | `n` `i` | = | new item    | `J`     | = | next sib.    |

<br>

## Window Management

| Splits        |   |                |              |   |               | Tabs          |   |      |
|:--------------|:-:|:---------------|:-------------|:-:|:--------------|:--------------|:-:|:-----|
| `<L>` `-`     | = | hor. split     | `J`          | = | down          | `<L>` `n` `t` | = | new  |
| `<L>` `|`     | = | vert. split    | `K`          | = | up            | `<L>` `q` `t` | = | quit |
| `<L>` `e` `s` | = | equalize       | `H`          | = | left          | `<L>` `t` `r` | = | right|
| `<L>` `g` `h` | = | grow hor.      | `<L>` `m`    | = | max/min       | `<L>` `t` `l` | = | left |
| `<L>` `s` `h` | = | shrink hor.    | `Z` `Z`      | = | save, close   |
| `<L>` `g` `v` | = | grow vert.     | `:` `q`      | = | close         |
| `<L>` `s` `v` | = | shrink vert    | `:` `q` `!`  | = | force close   |
| `L`           | = | right          | `:` `w`      | = | save          |
| `<L>` `t` `v` | = | terminal vert. | `<L>` `t` `h`| = | terminal hor. |

<br>

## Navigate Arround

| Navigation     |   |                        |                |   |                        |
|:---------------|:-:|:-----------------------|:---------------|:-:|:-----------------------|
| `j`            | = | down                   | `k`            | = | up                     |
| `G`            | = | last line, first char  | `g` `g`        | = | first line, first char |
| `C`            | = | center line on screen  | `C`            | = | center line on screen  |
| `B`            | = | line to botom of screen| `T`            | = | line to top of screen  |
| `:` `<num>`    | = | to line                | `:` `<num>`    | = | to line                |
| `ctrl` `j`     | = | scroll down            | `ctrl` `k`     | = | scroll up              |
| `ctrl` `p` `d` | = | page down              | `ctrl` `p` `u` | = | page up                |
| `h`            | = | left                   | `l`            | = | right                  |
| `b`            | = | prev. word, first char | `w`            | = | next word, first char  |
| `0`            | = | start of line          | `$`            | = | end of line            |
| `%`            | = | to matching bracket    | `%`            | = | to matching bracket    |
| `^`            | = | first char in line     | `g` `_`        | = | last char of line      |
| `<L>` `c`      | = | to char                | `<L>` `w`      | = | to word                |
| `<L>` `p`      | = | to pattern             | `<L>` `l`      | = | to line                |

<br>

## Modes & Searching

| Modes   |   |                      | Search        |   |                   |
|:--------|:-:|----------------------|:--------------|:-:|:------------------|
| `esc`   | = | normal               | `/`           | = | search            |
| `i`     | = | insert before char   | `n`           | = | next              |
| `a`     | = | insert after char    | `N`           | = | previous          |
| `I`     | = | insert start of line | `<L>` `q` `h` | = | quit highlighting |
| `A`     | = | insert end of line   | `<l>` `f` `f` | = | find file         |
| `v`     | = | visual               | `<L>` `f` `t` | = | fint text         |
| `v` `v` | = | visual line          | `<L>` `r` `f` | = | rescent files     |
| `v` `b` | = | visual block         | `*`           | = | find under cursor |
| `:`     | = | command line         |

<br>

## Editing

| Edit           |   |                          |                       |   |                        |
|:---------------|:-:|:-------------------------|:----------------------|:-:|:-----------------------|
| `x`            | = | delete                   | `<L>` `m` `d` `o`     | = | markdown open          |
| `d` `i` `w`    | = | delete word              | `<L>` `m` `d` `q`     | = | markdown quit          |
| `d` `d`        | = | delete line              | `<L>` `u` `m` `l` `o` | = | uml open               |
| `d`            | = | delete marked            | `<L>` `u` `m` `l` `s` | = | uml save .png          |
| `u`            | = | undo                     | `;` `;`               | = | ; end of line          |
| `U`            | = | redo                     | `,` `,`               | = | , end of line          |
| `<L>` `/`      | = | comment in/out           | `:` `:`               | = | : end of line          |
| `<L>` `/` `s`  | = | comment in/out selection | `.`                   | = | repeat command         |
| `<L>` `j` `l`  | = | join line                | `(` `(`               | = | surround with ( )      |
| `<L>` `j` `o`  | = | join object              | `{` `{`               | = | surround with { }      |
| `<L>` `s` `o`  | = | split object             | `[` `[`               | = | surround with [ ]      |
| `<L>` `a` `l`  | = | align left               | `"` `"`               | = | surround with " "      |
| `<L>` `a` `r`  | = | align right              | `'` `'`               | = | surround with ' '      |
| `y`            | = | yank                     | \` `                  | = | surround with \` `     |
| `y` `y`        | = | yank line                | `<` `>`               | = | surround with < >      |
| `D`            | = | delete till end          | `Y`                   | = | yank till end          |
| `p`            | = | put                      | `s` `w` `t`           | = | surround with tag      |
| `o`            | = | new line below           | `c` `s` `t`           | = | change surrounding tag |
| `shift` `tab`  | = | move selected up         | `d` `s` `t`           | = | delete surrounding tag |
| `tab`          | = | move selected down       | `d` `s` `<cl.si.>`    | = | delete surrounding     |
| `ctrl` `p` `u` | = | scroll preview up        | `c` `s` `<o.n.>`      | = | change surrounding     |
| `ctrl` `p` `d` | = | scroll preview down      | `ctrl` `q`            | = | quit completion        |
| `ctrl` `c`     | = | completion suggestions   | `tab`                 | = | next completion item   |
| `ctrl` `<L>`   | = | confirm completion       | `shift` `tab`         | = | prev. completion item  |
| `~`            | = | switch case              |                       |   |                        |