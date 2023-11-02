
int char1
int char2

int $str

create table[] 256 allot

proc dump_table
  16 0 do
    0
    16 0 do
      1 i lshift
      table[] ij + c@ * +
    loop
    .
  loop
endproc

proc add-interval // str --
  dup to $str
  255 to char1
  0 to char2
   strlen 0 do
     $str i + c@ dup .
     dup char1 < if dup to char1 then
     dup char2 > if dup to char2 then
     drop
   loop
   char2 char1 > if
     char2 1 + char1 do
       1 table[] i + c!
     loop
   then

endproc

"ab" add-interval
dump_table


