# Neo-Vim Commands
Yes, that seems like a lot of commands, but trust me, it's all about muscle 
memory ;) Use it - and you will learn it.  

For me it was way easier to write the commands on Post-Its and place them on the
lower side of my screen, so I seen them all the time.

I use one of these configurable split keyboards, but my layout is very near to 
the US ANSI layout.

If something doesn't work, check if your caps lock is activated or not :)

## Neovim Modes
Neovim has different modes to get your actions done.  
The mode where you start is called `Normal Mode`.  
* Normal Mode
    * Used to navigate around, copy and paste (yank and put in Neovim language) things, etc.
* Insert Mode
    * Used to write like in every other text editor.
* Visual Mode
    * Used to mark text. It is divided by three different use cases:
        * Visual Mode (for marking characters)
        * Visual Line Mode (for marking whole lines)
        * Visual Block Mode (for marking blocks of characters)
* Command Line Mode
    * Write Neovim and terminal commands

Entry point for all modes is always `Normal Mode`.

## Explanation
If you see something like `<Leader>`, that's a special key in Neovim. Regularly 
it is the `\` key. In this configuration it is mapped to the `space` key.

In the column `Location` you will somethimes see `regular Neovim`. This means, 
I doesn't have created a special key mapping. Neovim provides this function by
default.  
For all other contents of this column, I provide the file where I've defined 
the key mapping. Feel free to change them if you like.

The most of the commands you can type numbers before, to run the command n times.

---

## Commands
### Enter Modes
|Action|Command|Location|
|:-----|:-----:|:-------|
|Enter normal mode:|`esc`|Regular Neovim|
|Enter insert mode:|`i`|Regular Neovim|
|Enter visual mode:|`v`|Regular Neovim|
|Enter visual line mode:|`V`|Regular Neovim|
|Enter visual block mode:|`v` `b`|keymaps.lua|
|Enter command line mode:|`:`|Regular Neovim|

### Navigate Around
To navigate around, enter `Normal Mode`.
|Action|Command|Location|
|:-----|:-----:|:-------|
|Down:|`j`|Regular Neovim|
|Up:|`k`|Regular Neovim|
|Left:|`h`|Regualr Neovim|
|Right:|`l`|Regular Neovim|
|Go to character:|`<Leader>` `c`|hop.lua|
|Go to word:|`<Leader>` `w`|hop.lua|
|Go to pattern:|`<Leader` `p`|hop.lua|
|Go to line (visible part of file):|`<Leader>` `l`|hop.lua|
|Next word:|`w`|Regular Neovim|
|Previous word:|`b`|Regular Neovim|
|End of line:|`$`|Regular Neovim|
|Start of line:|`0`|Regular Neovim|
|Top of file:|`gg`|Regualar Neovim, telescope.lua|
|Bottom of file:|`G`|Regular Neovim, telescope.lua|
|Go to line (whole file):|`:` `<line number>`|Regular Neovim|
|Go to split below:|`J`|keymaps.lua|
|Go to split above:|`K`|keymaps.lua|
|Go to left split:|`H`|keymaps.lua|
|Go to right split:|`L`|keymaps.lua|
|Go to project tree (explore tree):|`<Leader>` `e` `t`|nvim-tree.lua|
|Go to actual file in project tree:|`<Leader>` `s` `f` `t`|nvim-tree.lua|
|Scroll actual line to top:|`T`|keymaps.lua|
|Scroll actual line to center:|`C`|keymaps.lua|
|Scroll actual line to bottom:|`B`|keymaps.lua|
|Scroll down:|`ctrl` `j`|keymaps.lua, lspsaga.lua, nvim-cmp.lua, telescope.lua|
|Scroll up:|`ctrl` `k`|keymaps.lua, lspsaga.lua, nvim-cmp.lua, telescope.lua|
|Scroll one page up:|`ctrl` `p` `u`|keymaps.lua|
|Scroll one page down:|`ctrl` `p` `d`|keymaps.lua|
|Enter insert mode at start of line:|`I`|Regular Neovim|
|Enter insert mode at end of line:|`A`|Regular Neovim|

### Searching
|Action|Command|Location|
|:-----|:-----:|:-------|
|Search:|`/` `<search pattern>`|Regular Neovim|
|Next occurance:|`n`|Regular Neovim|
|Previous occurance:|`N`|Regular Neovim|
|Quit highlighting of search:|`<Leader>` `q` `h`|keymaps.lua|
|Find file:|`<Leader>` `f` `f`|telescope.lua|
|Find text in files:|`<Leader>` `f` `t`|telescope.lua|
|Show recent files:|`<Leader>` `r` `f`|telescope.lua|
|Find word/marked pattern under cursor:|`*`|Regular Neovim|

### Editing
|Action|Command|Location|
|:-----|:-----:|:-------|
|Delete character:|`x`|Regular Neovim|
|Delete word:|`d` `i` `w`|Regular Neovim|
|Delete line:|`d` `d`|Regular Neovim|
|Delete marked:|`d`|Regular Neovim|
|Undo last action:|`u`|Regular Neovim|
|Redo last action:|`U`|keymaps.lua|
|Save file (auto save is active too):|`:` `w`|Regular Neovim|
|Force save file|`:` `w` `!`|Regular Neovim|
|Save and close file:|`Z` `Z`|Regular Neovim|
|Quit file:|`:` `q`|Regular Neovim|
|Force quit file:|`:` `q` `!`|Regular Neovim|
|Open Markdown preview:|`<Leader>` `m` `d` `o`|peek.lua|
|Quit Markdown preview:|`<Leader>` `m` `d` `q`|peek.lua|
|Open PlantUML preview:|`<Leader>` `u` `m` `l` `o`|plantuml-previewer.lua|
|Save PlantUML as .png:|`<Leader>` `u` `m` `l` `s`|plantuml-previewer.lua|
|Add ; at end of line:|`;` `;`|keymaps.lua|
|Add , at end of line:|`,` `,`|keymaps.lua|
|Join next line:|`<Leader>` `j` `l`|keymaps.lua|
|Join object:|`<Leader>` `j` `o`|splitjoin.lua|
|Split object:|`<Leader>` `s` `o`|splitjoin.lua|
|Repeat last command:|`.`|Regular Neovim|
|Surround with ( ):|`(` `(`|nvim-surround.lua|
|Surround with { }:|`{` `{`|nvim-surround.lua|
|Surround with [ ]:|`[` `[`|nvim-surround.lua|
|Surround with " ":|`"` `"`|nvim-surround.lua|
|Surround with ' ':|`'` `'`|nvim-surround.lua|
|Surround with ``:|\` `|nvim-surround.lua|
|Surround with < >:|`<` `>`|nvim-surround.lua|
|Surround with HTML tag:|`s` `w` `t`|nvim-surround.lua|
|Change surrounding HTML tag:|`c` `s` `t`|nvim-surround.lua|
|Delete surrounding HTML tag:|`d` `s` `t`|nvim-surround.lua|
|Delete surroundings:|`d` `s` `<closing-sign>`|nvim-surround.lua|
|Change surroundings:|`c` `s` `<old>` `<new>`|nvim-surround.lua|
|Yank:|`y`|Regular Neovim|
|Yank line:|`y` `y`|Regular Neovim|
|Put:|`p`|Regular Neovim|
|Insert new line below:|`o`|Regular Neovim|
|Move (selected) part up:|`shift` `tab`|keymaps.lua|
|Move (selected) part down:|`tab`|keymaps.lua|

#### Project Tree
|Action|Command|Location|
|:-----|:-----:|:-------|
|Close node:|`c` `n`|nvim-tree.lua|
|Rename:|`r`|nvim-tree.lua|
|File information:|`i`|nvim-tree.lua|
|Open:|`enter`|nvim-tree.lua|
|Open file in vertical split:|`v`|nvim-tree.lua|
|Open file in horizontal split:|`h`|nvim-tree.lua|
|Yank name:|`y`|nvim-tree.lua|
|Yank relative path:|`Y`|nvim-tree.lua|
|Copy:|`c`|nvim-tree.lua|
|Cut:|`x`|nvim-tree.lua|
|Paste:|`p`|nvim-tree.lua|
|To parent node:|`P`|nvim-tree.lua|
|New:|`n`|nvim-tree.lua|
|Delete:|`d`|nvim-tree.lua|
|Move to bin:|`B`|nvim-tree.lua|
|Collapse all:|`C`|nvim-tree.lua|
|Expand all:|`E`|nvim-tree.lua|
|To top sibling:|`T` `S`|nvim-tree.lua|
|To bottom sibling:|`T` `B`|nvim-tree.lua|
|To previous sibling:|`K`|nvim-tree.lua|
|To next sibling:|`J`|nvim-tree.lua|









---
OLD STUFF

|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||
|:|`` ``||




These are my keyboard commands for Neo-Vim.
`<L>` is the abbrevation for `<Leader>`.


|Action|Command|Location|
|:-----|:-----:|:-------|
|Comment in/out:|`<Leader>` `/`|comment.lua|
|Quit highlighting of search:|`<Leader>` `q` `h`|keymaps.lua|
|Character hopping:|`<Leader>` `c`|hop.lua|
|Word hopping:|`<Leader>` `w`|hop.lua|
|Pattern hopping:|`<Leader>` `p`|hop.lua|
|Line hopping:|`<Leader>` `l`|hop.lua|
|Join line below:|`<Leader>` `j` `l`|keymaps.lua|
|Align left of character:|`<Leader>` `a` `l`|lion.lua|
|Align right of character:|`<Leader>` `a` `r`|lion.lua|
|Scroll down:|`ctrl` `j`|lspsaga.lua, keymaps.lua, nvim-cmp.lua, telescope.lua|
|Scroll up:|`ctrl` `k`|lspsaga.lua, keymaps.lua, nvim-cmp.lua, telescope.lua|
|Go to definition:|`<Leader>` `g` `d`|lspsaga.lua|
|Show completion suggestions:|`ctrl` `c`|nvim-cmp.lua|
|Confirm completion:|`ctrl` `<Leader>`|keymaps.lua, nvim-cmp.lua|
|Quit completion:|`ctrl` `q`|keymaps.lua, nvim-cmp.lua|
|Next completion entry:|`tab`|keymaps.lua, nvim-cmp.lua|
|Previous completion entry:|`shift` `tab`|keymaps.lua, nvim-cmp.lua|
|Move down:|`j`|regular vim, telescope.lua|
|Move up:|`k`|regular vim, telescope.lua|
|Move left:|`h`|regular vim,|
|Move right:|`l`|regular vim,|
|To split below:|`J`|keymaps.lua|
|To split above:|`K`|keymaps.lua|
|To left split:|`H`|keymaps.lua|
|To right split:|`L`|keymaps.lua|
|New horizontal split:|`<Leader>` `h`|keymaps.lua|
|New vertical split:|`<Leader>` `v`|keymaps.lua|
|Equalize splits:|`<Leader>` `e` `s`|keymaps.lua|
|Grow split vertically:|`<Leader>` `g` `v`|keymaps.lua|
|Shrink split vertically:|`<Leader>` `s` `v`|keymaps.lua|
|Grow split horizontally:|`<Leader>` `g` `h`|keymaps.lua|
|Shrink split horizontally:|`<Leader>` `s` `h`|keymaps.lua|
|New terminal in horizontal split:|`<Leader>` `t` `h`|keymaps.lua|
|New terminal in vertical split:|`<Leader>` `t` `v`|keymaps.lua|
|New tab:|`<Leader>` `n` `t`|keymaps.lua|
|Quit tab:|`<Leader>` `q` `t`|keymaps.lua|
|To right tab:|`<Leader>` `r` `t`|keymaps.lua|
|To left tab:|`<Leader>` `l` `t`|keymaps.lua|
|Undo last action:|`u`|regular vim|
|Redo last action:|`U`|keymaps.lua|
|Change surrounding:|`c` `s` `<old>` `<new>`|nvim-surround.lua|
|Surround witn ( ):|`(` `(`|nvim-surround.lua|
|Surround with { }:|`{` `{`|nvim-surround.lua|
|Surround with [ ]:|`[` `[`|nvim-surround.lua|
|Surround with " ":|`"` `"`|nvim-surround.lua|
|Surround with ' ':|`'` `'`|nvim-surround.lua|
|Surround with \` `:|\` `|nvim-surround.lua|
|Surround with < >:|`<` `>`|nvim-surround.lua|
|Surround with HTML tag:|`s` `w` `t`|nvim-surround.lua|
|Change surrounding HTML tag:|`c` `s` `t`|nvim-surround.lua|
|Delete surrounding:|`d` `s` `<closing-sign>`|nvim-surround.lua|
|Delete surrounding HTML tag:|`d` `s` `t`|nvim-surround.lua|
|Open Markdown preview:|`<Leader>` `m` `d` `o`|peek.lua|
|Quit Markdown preview:|`<Leader>` `m` `d` `q`|peek.lua|
|Open PlantUML preview:|`<Leader>` `u` `m` `l` `o`|plantuml-previewer.lua|
|Save PlantUML as .png:|`<Leader>` `u` `m` `l` `s`|plantuml-previewer.lua|
|Join object:|`<Leader>` `j` `o`|splitjoin.lua|
|Split object:|`<Leader>` `s` `o`|splitjoin.lua|
|Max-/minimize buffer:|`<Leader>` `m`|windows.lua|
|Add ; at end of line:|`;` `;`|keymaps.lua|
|Add , at end of line:|`,` `,`|keymaps.lua|
|Enter visual block mode:|`v` `b`|keymaps.lua|
|Scroll actual line to top:|`T`|keymaps.lua|
|Scroll actual line to center:|`C`|keymaps.lua|
|Scroll actual line to bottom:|`B`|keymaps.lua|
|Find file:|`<Leader>` `f` `f`|telescope.lua|
|Find text:|`<Leader>` `f` `t`|telescope.lua|
|Show recent files:|`<Leader>` `r` `f`|telescope.lua|
|Quit Telescope:|`ctrl` `q`|telescope.lua|
|Enter normal mode:|`esc`|regular vim|
|Open:|`enter`|nvim-tree.lua, telescope.lua|
|Open file in horizontal split:|`h`|nvim-tree.lua, telescope.lua|
|Open file in vertical split:|`v`|nvim-tree.lua, telescope.lua|
|Jump to middle of list:|`M`|telescope.lua|
|Jump to top:|`g` `g`|regular vim, telescope.lua|
|Jump to bottom:|`G`|regular vim, telescope.lua|
|Scroll up in preview:|`ctrl` `p` `u`|keymaps.lua, telescope.lua|
|Scroll down in preview:|`ctrl` `p` `d`|keymaps.lua, telescope.lua|
|Toggle tree:|`<Leader>` `t` `t`|nvim-tree.lua|
|Explore tree:|`<Leader>` `e` `t`|nvim-tree.lua|
|Show file in tree:|`<Leader>` `s` `f` `t`|nvim-tree.lua|
|Close node:|`c` `n`|nvim-tree.lua|
|Rename:|`r`|nvim-tree.lua|
|Show information:|`i`|nvim-tree.lua|
|Yank name of file:|`y`|nvim-tree.lua|
|Yank relative path:|`Y`|nvim-tree.lua|
|Copy:|`c`|nvim-tree.lua|
|Cut:|`x`|nvim-tree.lua|
|Paste:|`p`|nvim-tree.lua|
|To parent node:|`P`|nvim-tree.lua|
|New:|`n`|nvim-tree.lua|
|Delete:|`d`|nvim-tree.lua|
|Move to bin:|`B`|nvim-tree.lua|
|Collapse all:|`C`|nvim-tree.lua|
|Expand all:|`E`|nvim-tree.lua|
|To top sibling:|`TS`|nvim-tree.lua|
|To bottom sibling:|`BS`|nvim-tree.lua|
|To previous sibling:|`K`|nvim-tree.lua|
|To next sibling:|`J`|nvim-tree.lua|
|Move line/selection up:|`shift` `tab`|keymaps.lua|
|Move line/selection down:|`tab`|keymaps.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|
|:|``|.lua|






## Nvim-Tree
|Action|Command|
|:-----|:------|
|Toggle tree|`<l>tt`|
|Close tree|`q`|
|Explore tree|`<l>ee`|
|Show actual file in tree|`<l>ft`|
|Open in vertical split|`s`|
|Open in horizontal split|`i`|
|Navigate up|`k`|
|Navigate down|`j`|
|Open/close|`o`|
|Refresh tree|`R`|
|Open a file, stay in the tree||
|Delete|`d`|
|Move to trash|`D`|
|Rename file|`r`|
|Yank file name|`y`|
|Yank relative path|`Y`|
|Cut|`x`|
|Copy|`c`|
|Paste|`p`|
|Collapse all nodes|`W`|
|Expand all nodes|`E`|
|Open file preview|`Tab`|
|New file/directory|`a`|

## Splits
|Action|Command|
|:-----|:------|
|Split x-axis|`<l>x`|
|Split y-axis|`<l>y`|
|Go to right split|`L`|
|Go to left split|`H`|
|Go to split below|`J`|
|Go to split above|`K`|
|Equalize width and height of all splits|`<l>es`|
|Grow split vertically|`<l>gv`|
|Shrink split vertically|`<l>sv`|
|Grow split horizontally|`<l>gh`|
|Shrink split horizontally|`<l>sh`|
|Minimize/maximize current split|`<l><l>m`|

## Tabs
|Action|Command|
|:-----|:------|
|Open new tab|`<l>ot`|
|Exit current tab|`<l>et`|
|Go to next tab|`<l>nt`|
|Go to previous tab|`<l>pt`|

## Visual Mode
|Action|Command|
|:-----|:------|
|Visual mode|`v`|
|Visual line|`V`|
|Visual block|`vb`|
|To start/end of block|`o`|
|Indent|`>`|
|Deindent|`<`|
|Mark previous section again|`gv`|
|To start/end of line|`O`|
|Push block down|`J`|
|Push block up|`K`|

## Search
|Action|Command|
|:-----|:------|
|Forward search|`/`|
|Backward search|`?`|
|Next occurance|`n`|
|Previous occurance|`N`|
|Clear search highlights|`<l>nh`|
|Search everywhere|`<l>se`|
|Search in lines||
|Show git index||
|Show git status||
|Show recent files||
|Open in horizontal split|`^x`|
|Open in vertical split|`^v`|
|Move up in list|`^k`|
|Move down in list|`^j`|

## Edit
|Action|Command|
|:-----|:------|
|Undo|`u`|
|Redo|`U`|
|Comment line in/out|`<l>/`|
|Comment block in/out|`<l>bb`|
|Indent|`>>`|
|Deindent|`<<`|
|Autoindent|`==`|
|Append line below|`<l>a`|
### Auto-Completion
|Enter auto-completion menu|`tab`|
|Go list item up|`k`|
|Go list item down|`j`|
|Insert selection|`enter`|
|Scroll implementation menu up|`K`|
|Scroll implementation menu down|`J`|
||``|
||``|
||``|
||``|

## Moving
|Action|Command|
|:-----|:------|
|Hop to a charakter|`<l><l>c`|
|Hop to a word|`<l><l>w`|
|Hop to a pattern|`<l><l>p`|
|Hop to a line|`<l><l>l`|
|Hop to word in current line|`<l><l>r`|
||``|














