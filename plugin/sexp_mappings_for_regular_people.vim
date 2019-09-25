" after/plugin/sexp.vim - Sexp mappings for regular people
" Maintainer:   Tim Pope <code@tpope.net>

if exists("g:loaded_sexp_mappings_for_regular_people") || &cp
  finish
endif
let g:loaded_sexp_mappings_for_regular_people = 1

function! s:map_sexp_wrap(type, target, left, right, pos)
  execute (a:type ==# 'v' ? 'x' : 'n').'noremap'
        \ '<buffer><silent>' a:target ':<C-U>let b:sexp_count = v:count<Bar>exe "normal! m`"<Bar>'
        \ . 'call sexp#wrap("'.a:type.'", "'.a:left.'", "'.a:right.'", '.a:pos.', 0)'
        \ . '<Bar>silent! call repeat#set("'.a:target.'", v:count)<CR>'
endfunction

function! s:sexp_mappings() abort
  if !exists('g:sexp_loaded')
    return
  endif
  " FIXME: check what this does.
  call s:map_sexp_wrap('e', 'cseb', '(', ')', 0)
  call s:map_sexp_wrap('e', 'cse(', '(', ')', 0)
  call s:map_sexp_wrap('e', 'cse)', '(', ')', 1)
  call s:map_sexp_wrap('e', 'cse[', '[', ']', 0)
  call s:map_sexp_wrap('e', 'cse]', '[', ']', 1)
  call s:map_sexp_wrap('e', 'cse{', '{', '}', 0)
  call s:map_sexp_wrap('e', 'cse}', '{', '}', 1)

  " overwritten by paredit:
  nmap <buffer> dsf <Plug>(sexp_splice_list)

  "nmap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  "nmap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  "nmap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  "nmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  "xmap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  "xmap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  "xmap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  "xmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  "omap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  "omap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  "omap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  "omap <buffer> E   <Plug>(sexp_move_to_next_element_tail)

  nmap <buffer> <leader>S  :call PareditJoin()<cr>
  nmap <buffer> <leader>o  :call PareditSplit()<cr>
  nmap <buffer> <leader>s  <Plug>(sexp_splice_list)

  nmap <buffer> <leader>R  <Plug>(sexp_raise_list)
  nmap <buffer> <leader>r  <Plug>(sexp_raise_element)

  nmap <buffer> <leader>gi <Plug>(sexp_insert_at_list_head)
  nmap <buffer> <leader>ge <Plug>(sexp_insert_at_list_tail)
  nmap <buffer> <leader><  <Plug>(sexp_swap_list_backward)
  nmap <buffer> <leader>>  <Plug>(sexp_swap_list_forward)
  nmap <buffer> <          <Plug>(sexp_swap_element_backward)
  nmap <buffer> >          <Plug>(sexp_swap_element_forward)
  nmap <buffer> <leader>L  <Plug>(sexp_emit_head_element)
  nmap <buffer> <leader>H  <Plug>(sexp_emit_tail_element)
  nmap <buffer> <leader>h  <Plug>(sexp_capture_prev_element)
  nmap <buffer> <leader>l  <Plug>(sexp_capture_next_element)

  nmap <buffer> <leader>== <Plug>(sexp_indent_top)
  nmap <buffer> <leader>=- <Plug>(sexp_indent)

  nmap <buffer> <leader>i  <Plug>(sexp_round_head_wrap_element)
  nmap <buffer> <leader>a  <Plug>(sexp_round_tail_wrap_element)

  nmap <buffer> <M-S>  :call PareditJoin()<cr>
  nmap <buffer> <M-o>  :call PareditSplit()<cr>
  nmap <buffer> <M-s>  <Plug>(sexp_splice_list)
  nmap <buffer> <M-R>  <Plug>(sexp_raise_list)
  nmap <buffer> <M-r>  <Plug>(sexp_raise_element)
  nmap <buffer> <M-e> <Plug>(sexp_insert_at_list_tail)
  " nmap <buffer> <M-<>  <Plug>(sexp_swap_list_backward)
  " <buffer> <M->>  <Plug>(sexp_swap_list_forward)
  nmap <buffer> <M-L>  <Plug>(sexp_emit_head_element)
  nmap <buffer> <M-H>  <Plug>(sexp_emit_tail_element)
  nmap <buffer> <M-h>  <Plug>(sexp_capture_prev_element)
  nmap <buffer> <M-l>  <Plug>(sexp_capture_next_element)

  nmap <buffer> <M-i>  <Plug>(sexp_round_head_wrap_element)
  nmap <buffer> <M-a>  <Plug>(sexp_round_tail_wrap_element)

  nmap <buffer> == <Plug>(sexp_indent_top)
  nmap <buffer> =- <Plug>(sexp_indent)


endfunction





" keeping as is:
"
" 'sexp_square_head_wrap_list':     '<LocalLeader>#[',
" 'sexp_square_tail_wrap_list':     '<LocalLeader>#]',
" 'sexp_curly_head_wrap_list':      '<LocalLeader>#{',
" 'sexp_curly_tail_wrap_list':      '<LocalLeader>#}',
" 'sexp_square_head_wrap_element':  '<LocalLeader>[',
" 'sexp_square_tail_wrap_element':  '<LocalLeader>]',
" 'sexp_curly_head_wrap_element':   '<LocalLeader>{',
" 'sexp_curly_tail_wrap_element':   '<LocalLeader>}',

function! s:setup() abort
  augroup sexp_mappings_for_regular_people
    autocmd!
    execute 'autocmd FileType' get(g:, 'sexp_filetypes', 'lisp,scheme,clojure') 'call s:sexp_mappings()'
  augroup END
endfunction

if has('vim_starting') && !exists('g:sexp_loaded')
  au VimEnter * call s:setup()
else
  call s:setup()
endif
