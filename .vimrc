filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/Desktop/vimPlugins')

Plugin 'vundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'
Plugin 'vimwiki/vimwiki'
Plugin 'mhinz/vim-startify'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'

call vundle#end()

colorscheme molokai

set nocompatible
filetype plugin on
syntax on

set clipboard=unnamed

" vimwiki를 위한 설정들
let maplocalleader = "\\"

" 1번 위키는 공개용, 2번 위키는 개인용
let g:vimwiki_list = [
    \{
    \   'path': '~/Desktop/git/aegis1920.github.io/_wiki',
    \   'ext' : '.md',
    \   'diary_rel_path': '.',
    \}
\]

" 이렇게 해줘야 편하다고 한다.
let g:vimwiki_conceallevel = 0

" wiki를 열기위한 map 지정
command! WikiIndex :VimwikiIndex
nmap <LocalLeader>ww <Plug>VimwikiIndex

function! LastModified()
    if &modified
        let save_cursor = getpos(".")
        let n = min([10, line("$")])
        keepjumps exe '1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
              \ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
        call histdel('search', -1)
        call setpos('.', save_cursor)
    endif
endfun

autocmd BufWritePre *.md call LastModified()

" 새로운 파일을 만들 때 메타 데이터를 입력해주는 함수
function! NewTemplate()
    
    " 만약 줄 개수가 1개 이상이라면 return
    if line("$") > 1
        return
    endif

 let l:template = []
    call add(l:template, '---')
    call add(l:template, 'layout  : wiki')
    call add(l:template, 'title   : ')
    call add(l:template, 'summary : ')
    call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
    call add(l:template, 'tags    : ')
    call add(l:template, 'toc     : true')
    call add(l:template, 'public  : true')
    call add(l:template, 'parent  : ')
    call add(l:template, 'latex   : false')
    call add(l:template, '---')
    call add(l:template, '* TOC')
    call add(l:template, '{:toc}')
    call add(l:template, '')
    call add(l:template, '# ')
    call setline(1, l:template)
    execute 'normal! G'
    execute 'normal! $'

    echom 'new wiki page has created'
endfunction

autocmd BufRead,BufNewFile *.md :call NewTemplate()

" 새로운 라인을 시작할 때, smart하게 auto indent를 해준다.
set smartindent

" tab을 눌렀을 때 인식하는 칸 수 
set tabstop=4

" tab을 space로 설정
set expandtab

" >> << 키로 들여, 내어 쓰기할 때 스페이스 개수
set shiftwidth=4

"<leader>키를 ,로 바꾸어주는 역할.
let mapleader=","

"$MYVIMRC를 map키로 지정한다. rightbelow vnew는 vertical하게 오른쪽 아래에 추가. 즉 ,rc를 누르면 _vimrc가 켜진다. 
nnoremap <Leader>rc :rightbelow vnew $MYVIMRC<CR>

"창 옮기는 걸 쉽게 옮기게 해줄려고 ctrl + 방향키
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"nerdtree로 빠르게 가려고 해준 것. ,n을 누르면 왼쪽에 nerdtree가 생긴다. 
nnoremap <C-F> :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTreeToggle<CR> 

let g:NERDTreeCopyCmd='cp-r'

" 라인 수를 표시해준다
set nu

"자동 들여쓰기
set autoindent
set smartindent

"검색/치환할 때 대소문자 구별x
set ignorecase

"괄호 입력시 자동으로 대응되는 괄호를 표시해줌
set showmatch

"검색한 단어를 하이라이팅해준다.
set hlsearch

set backspace=eol,start,indent " 줄의 끝, 시작, 들여쓰기에서 백스페이스 시 이전 줄로"
set nowrapscan " 검색할 때 문서의 끝에서 처음으로 안 돌아감."
