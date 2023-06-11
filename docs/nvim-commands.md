# Neo-Vim Commands
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














