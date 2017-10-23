" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=80 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"   This is the personal .vimrc file of Florian Heidenreich.
"
" }

" Plugin Environment {
	set nocompatible
	set rtp+=~/.vim/bundle/Vundle.vim

	call vundle#begin()
	
	Plugin 'VundleVim/Vundle.vim'           " Plugin manager
	Plugin 'w0rp/ale'                       " Syntax checker
	Plugin 'tpope/vim-fugitive'             " Git wrapper
	Plugin 'vim-airline/vim-airline'        " Status line
	Plugin 'morhetz/gruvbox'                " Color scheme
	Plugin 'tpope/vim-surround'             " Quoting and parenthesizing

	Plugin 'Valloric/YouCompleteMe'         " Code completion
	Plugin 'ludovicchabant/vim-gutentags'   " Ctags generation
    Plugin 'scrooloose/nerdcommenter'       " Commenting
	Plugin 'fatih/vim-go'			        " Go
    Plugin 'vim-scripts/Conque-GDB'         " GDB

	call vundle#end()
" }

" General {
    set clipboard=unnamed                   " Use macOS clipboard
	filetype plugin indent on               " Automatically detect file types.

	" Color scheme {
		set background=dark
		let g:gruvbox_invert_selection=0
		let g:gruvbox_contrast_dark="hard"
		colorscheme gruvbox
	" }	

	syntax on                               " Syntax highlighting
	set laststatus=2                        " Always show status line
	set number                              " Always show line numbers
    set noswapfile                          " Do not use swap files
    set incsearch                           " Always show search matches while typing
    set hlsearch                            " Highlight search matches
" }

" Formatting {
    set backspace=indent,eol,start          " Allow backspace to do its work
    set nowrap                              " Do not wrap long lines
    set autoindent                          " Indent at the same level of the previous line
    set shiftwidth=4                        " Use indents of 4 spaces
    set expandtab                           " Tabs are spaces
    set tabstop=4                           " An indentation every four columns
    set softtabstop=4                       " Let backspace delete indent
    set lazyredraw                          " No redraw while executing macros
" }

" Plugin Settings { 

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gu :Git pull<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    " }

	" vim-go {
		let g:syntastic_go_checkers = ['metalinter']
		let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
		let g:go_list_type = "quickfix"
		let g:go_fmt_command = "goimports"

		let g:go_highlight_functions = 1
		let g:go_highlight_methods = 1
		let g:go_highlight_fields = 1
		let g:go_highlight_types = 1
		let g:go_highlight_operators = 1
		let g:go_highlight_build_constraints = 1

		au FileType go nmap <Leader>god <Plug>(go-def-vertical)
		au FileType go nmap <Leader>godv <Plug>(go-doc-vertical)
		au FileType go nmap <Leader>goi <Plug>(go-info)
		au FileType go nmap <leader>gor <Plug>(go-run)
        au FileType go nmap <Leader>goe <Plug>(go-rename)
		au FileType go nmap <leader>gob <Plug>(go-build)
		au FileType go nmap <leader>got <Plug>(go-test)
		au FileType go nmap <leader>goc <Plug>(go-coverage)
	" }
	
    " YouCompleteMe  {
		let g:ycm_autoclose_preview_window_after_insertion = 1
		let g:ycm_collect_identifiers_from_tags_files = 1
	" }

    " GDB {
        let g:ConqueTerm_Color = 2                                                            
        let g:ConqueTerm_CloseOnEnd = 1                                                       
        let g:ConqueTerm_StartMessages = 0                                                    
                                                                                              
        function DebugSession()                                                               
            silent make -o vimgdb -gcflags "-N -l"                                            
            redraw!                                                                           
            if (filereadable("vimgdb"))                                                       
                ConqueGdb vimgdb                                                              
            else                                                                              
                echom "Couldn't find debug file"                                              
            endif                                                                             
        endfunction                                                                           
        function DebugSessionCleanup(term)                                                    
            if (filereadable("vimgdb"))                                                       
                let ds=delete("vimgdb")                                                       
            endif                                                                             
        endfunction                                                                           
        call conque_term#register_function("after_close", "DebugSessionCleanup")              
        nmap <leader>d :call DebugSession()<CR>;
    " }

" }
