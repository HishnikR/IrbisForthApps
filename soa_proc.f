
8 constant #TABLES


create match[] #TABLES 256 * allot


proc ClearTables()
  #TABLES 256 * 0 do
    0 match[] i + c!
  loop
endproc

ClearTables()

int TableIndex

proc [0-9] // index --
  to TableIndex
  10 0 do
     1
     match[] TableIndex 256 * + i + 48 +
     c!
  loop
endproc

proc [A-Z] // index --
  to TableIndex
  91 65 do
     1
     match[] TableIndex 256 * + i +
     c!
  loop
endproc

50 constant TXLeft
50 constant TYLeft
4 constant SqSize

int Sqx
int Sqy
int Sqcolor


proc DrawSq() // x, y, color --
  to Sqcolor
  to Sqy
  to Sqx
  SqSize 0 do
    SqSize 0 do
      i Sqx +
      j Sqy +
      Sqcolor 0 image.pixel
    loop
  loop
endproc

proc ClearImage()
  1000 0 do
    0xFFFFFF 0 image.pen.color
    0 i 2000 i 0 image.line
  loop
endproc

proc ShowTable() // i --
   to TableIndex
   16 0 do
     16 0 do
       TXLeft i SqSize * +
       SqSize 16 * 20 + TableIndex * TYLeft +
       j SqSize * +
       match[] TableIndex 256 * + j 16 * i + + c@
       if  0x00FF00 else 0xFFFFFF then
       DrawSq()
     loop
   loop

   0 0 image.pen.color
   17 0 do
     TXLeft i SqSize * +
     SqSize 16 * 20 + TableIndex * TYLeft +

     TXLeft i SqSize * +
     SqSize 16 * 20 + TableIndex * TYLeft +
     SqSize 16 * +
     0 image.line
   loop

   17 0 do
     TXLeft
     SqSize 16 * 20 + TableIndex * TYLeft +
     i SqSize * +

     TXLeft 16 SqSize * +
     SqSize 16 * 20 + TableIndex * TYLeft +
     i SqSize * +
     0 image.line
   loop

endproc

proc ShowTables()
  #TABLES 0 do
    i ShowTable()
  loop
endproc

0 image.show
0 0 800 800 0 image.rect

ClearImage()

0 [0-9]
1 [A-Z]
2 [0-9]
2 [A-Z]


ShowTables()

