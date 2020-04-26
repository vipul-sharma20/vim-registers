" Copyright © 2020 Vipul Sharma
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the "Software"),
" to deal in the Software without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distribute, sublicense,
" and/or sell copies of the Software, and to permit persons to whom the
" Software is furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included
" in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
" OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
" IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
" TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
" OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" Get plugin directory
let g:plugin_path = expand('<sfile>:p:h')

" Check if plugin properties set by user. Fallback to defaults if not.
let g:vim_registers_window_layout = get(g:, 'vim_registers_window_layout', 'default')

" Get color utility function
function! s:get_color(attr, ...)
    let gui = has('termguicolors') && &termguicolors
    let fam = gui ? 'gui' : 'cterm'
    let pat = gui ? '^#[a-f0-9]\+' : '^[0-9]\+$'
    for group in a:000
        let code = synIDattr(synIDtrans(hlID(group)), a:attr, fam)
        if code =~? pat
            return code
        endif
    endfor
    return ''
endfunction

let s:ansi = {'green': 32, 'yellow': 33, 'cyan': 36}

" Format to colored string
function! s:ansi(str, group, default, ...)
    let fg = s:get_color('fg', a:group)
    let bg = s:get_color('bg', a:group)
    let color = (empty(fg) ? s:ansi[a:default] : s:csi(fg, 1)) .
          \ (empty(bg) ? '' : ';'.s:csi(bg, 0))
    return printf("\x1b[%s%sm%s\x1b[m", color, a:0 ? ';1' : '', a:str)
endfunction

for s:color_name in keys(s:ansi)
  execute "function! s:".s:color_name."(str, ...)\n"
        \ "  return s:ansi(a:str, get(a:, 1, ''), '".s:color_name."')\n"
        \ "endfunction"
endfor

" Fetch all registers
function! Registers()
    redir =>output
    silent exec 'reg'
    redir END
    let split_list = split(string(output), "\n")
    let register_list = []
    for item in split_list[2:]
        let item_split = split(item, " ")

        let item_str = printf('%s %s',
        \ s:yellow(printf('%s', item_split[0]), 'Register'),
        \ s:green(printf('%s', join(item_split[1:], ' '))))
        call add(register_list, item_str)
    endfor
    return register_list
endfunction

" Execute this register and paste content
function! ExecRegister(e)
    let reg = split(a:e, " ")[0] . "p"
    redir =>output
    exec 'normal' . reg
    redir END
endfunction

" Driving FZF function
command! -bang -nargs=* GetRegisters call fzf#run({
        \ 'window': g:vim_registers_window_layout == 'floating' ? 'call CreateCenteredFloatingWindow()' : '',
        \ 'source': extend(['Reg   Content'], Registers()),
        \ 'sink': function('ExecRegister'),
        \ 'options': '-x --preview "' . g:plugin_path . '/preview.sh {}" --preview-window=50% --ansi --tiebreak=begin --header-lines=1',
        \ 'down': '30%'})

