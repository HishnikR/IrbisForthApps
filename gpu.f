
800 constant xsize
600 constant ysize

0 image.show
0 0 xsize ysize 0 image.rect

int zsize
65536 to zsize

create pixels[] xsize ysize * cells allot
create depth[]  xsize ysize * cells allot

proc update
  0 image.hide
    ysize 0 do
      xsize 0 do
        i j
        pixels[] j xsize * i + -th @ 0 image.pixel
      loop
    loop
  0 image.show
endproc

proc cls
    ysize 0 do
      xsize 0 do
        i j
        0 0 image.pixel
      loop
    loop
endproc

float fx
float fy
float fz

int x
int y
int color

proc 3d->2d  // f: x, y, z -- x, y
   fz f!
   fy f!
   fx f!
   fx f@ 1.0 f+ 2.0 f/ xsize s>f f* f>s // x
   fy f@ 1.0 f+ 2.0 f/ ysize s>f f* f>s // x, y
endproc

proc 3dpixel // f: x, y, z, int color --
  to color
  3d->2d
  to y
  to x
  depth[] y xsize * x + cells -th @
  fz f@ zsize s>f f* f>s < if
    color pixels[] y xsize * x + -th !
  then
endproc

proc demo
   10 0 do
     0.5 i s>f 0.01 f* f+ 0.4 0.7 255 3dpixel
   loop
endproc

cls
demo
update

