" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" --- custom settings ---
set showcmd			" show Vim command in status line
set showmatch			" highlight matching brackets
set ignorecase			" ignore case sensitivity in search etc.
set smartcase			" but respect case if pattern has uppercase parts
set incsearch			" search as i enter the pattern
"set autowrite			" automatically save before commands like :make etc.
"set hidden			" when abandoned, hide buffer instead of unloading
set mouse=a			" enable mouse usage
set modeline			" enable vim:set ... : config lines
set modelines=5			" inspect 5 lines at top/bottom for modeline

set backspace=indent,eol,start	" allow backspacing over everything in Insert mode
set history=100			" keep cmdline history
set ruler			" show cursor position and scroll % bottom right
set hlsearch			" highlight search pattern
set scrolloff=3        		" show lines above/below search
set wildmode=longest,list	" filename completion, longest match, then list of choices

if has("gui_running")
  set lines=28 columns=100
endif

set expandtab			" no tab characters but spaces
set autoindent			" start of line indentation
"set ts=4 sts=2 sw=4		" tab is 4 wide, softtabstop is 2 wide, shifts by 4
set ts=2 sts=2 sw=2

" --- mswin behaviour ---
behave mswin			" sets 'selection 'selectmode 'mousemodel 'keymodel
set keymodel=			" now cursor keys don't end Visual mode

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" map <Down> gj			" move to wrapped line as if it was a normal line
" map <Up> gk			" move to wrapped line as if it was a normal line

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X is Cut
vnoremap <C-X> "+x
 
" CTRL-C is Copy
vnoremap <C-C> "+y

" CTRL-V is Paste
map <C-V>	"+gP
cmap <C-V>	<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" toggle to paste mode (no autoindent etc.) when pasting
"set pastetoggle=<C-V>
"imap <C-V> <ESC><C-V>i

" For CTRL-V to work autoselect must be off.
set guioptions-=a

" use CTRL-Q to do what CTRL-V used to do (enter Visual mode)
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" change appearance
if has("gui_running")
  set guifont=Courier\ 10\ Pitch\ 10
  set guioptions-=T	" no toolbar
  set guioptions-=t	" no tearoff menuitems
  set guioptions-=m	" no menu
  set guioptions+=l	" left scrollbar
  set guioptions-=r	" no right scrollbar
endif

set winaltkeys=no	" Alt+? not used for the menu

" --- switching Home-Key like in "UltraEdit" ---
map <silent> <HOME> :call <SID>SwitchingHomeKey()<CR>
imap <silent> <HOME> <C-O>:call <SID>SwitchingHomeKey()<CR>

function! s:SwitchingHomeKey()
    let l:c = col(".")
    " move to outermost indent level
    normal ^
    if (col(".") == l:c)
        " we did not move, so we are at outermost indent. move to col 0
        normal 0
    endif
endfunction

" --- highlight tabs and trailing spaces ---
:syn match TAB_CHAR "\t"
:syn match TRAIL_SPACE " *$"
:hi link TAB_CHAR Visual
:hi link TRAIL_SPACE Visual

" --- customize tabs ---
" tab keys like firefox
:nmap <C-tab>      :tabnext<cr>
:map  <C-tab>      :tabnext<cr>
:imap <C-tab> <ESC>:tabnext<cr>i

:nmap <C-S-tab>      :tabprevious<cr>
:map  <C-S-tab>      :tabprevious<cr>
:imap <C-S-tab> <ESC>:tabprevious<cr>i

:nmap <C-t>      :tabnew<cr>
:imap <C-t> <ESC>:tabnew<cr> 

" change to directory of current file
"if has("autocmd")
"	autocmd BufEnter * :cd %:p:h
"endif

" change label of tabs
function! GuiTabLabel()
	" add the tab number
	let l:label = '['.tabpagenr()

	" add * if one buf in tab is modifed
	let l:buflist = tabpagebuflist(v:lnum)
	for l:bufnr in l:buflist
		if getbufvar(l:bufnr, '&modified')
			let l:label .= '*'
			break
		endif
	endfor

	let l:label .= '] '

	" add scp:// if via netw -- FIXME improve check!
	let l:n = bufname(buflist[tabpagewinnr(v:lnum) - 1])
	if 0 == stridx(fnamemodify(l:n,':h'), 'scp://')
		let l:label .= 'scp://'
	endif

	" add filename
	let l:label .= fnamemodify(l:n,':t')

	return l:label
endfunction
set guitablabel=%{GuiTabLabel()}

" vim: noexpandtab nowrap ts=8 sts=8:
