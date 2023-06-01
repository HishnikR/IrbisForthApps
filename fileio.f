string s

"data.txt" 0 FILE.TEXT.OPEN drop
: refill
  begin
    0 FILE.TEXT.EOF NOT
  WHILE
   s 0 FILE.TEXT.READLINE
   s print
  REPEAT
  0 FILE.TEXT.CLOSE drop
;

REFILL

"write.txt"  0 FILE.TEXT.OPENW drop
"demo" s s!

s 0 file.text.writeline

0 FILE.TEXT.CLOSE  drop

