function! ToggleSlash()
py3 << EOF
import vim

buffer = vim.current.buffer

start, _ = buffer.mark('<')
end, _ = buffer.mark('>')

cnt = 0
for i in range(start - 1, end):
  cnt += buffer[i].rstrip().endswith('\\')

for i in range(start - 1, end):
  buffer[i] = buffer[i].rstrip('\\ ')

if cnt < (end - start + 1) / 2:
  maxLen = max(map(len, buffer[start-1:end]) or [0]) + 1
  if maxLen < 79:
    maxLen = 79

  for i in range(start - 1, end):
    buffer[i] += ' ' * (maxLen - len(buffer[i])) + '\\'

EOF
endfunction

vnoremap <C-\> :<c-u>call ToggleSlash()<cr>
