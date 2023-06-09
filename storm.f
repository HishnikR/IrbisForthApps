create str 256 allot

PROC INIT_GRID
  0 STRINGGRID.SHOW
  10 30 1000 900 0 STRINGGRID.RECT
  5 0 STRINGGRID.COLS
  33 0 STRINGGRID.ROWS
  1 0 STRINGGRID.COLS.FIXED
  1 0 STRINGGRID.ROWS.FIXED
  0 0 STRINGGRID.EDIT

  5 1 do
    200 i 0 STRINGGRID.COL.WIDTH  // width, col, index --
  loop

  33 1 do
    i 1 - str >str
    str 0 i 0 stringgrid.text // s col row index --
  loop

  // STRINGGRID.ROW.HEIGHT  // height, row, index --

ENDPROC

INIT_GRID

create regs[] 4 cells allot
create new_reg[] 4 cells allot

: reg0 regs[] ;
: reg1 regs[] 1 -th ;
: reg2 regs[] 2 -th ;
: reg3 regs[] 3 -th ;

create const_data 1 cells allot
create step 1 cells allot


create atan[]
421657428.26631309245621820777800806608639118081525 f>s ,
248918914.69088218834712573038626526864459533836038 f>s ,
131521918.29346033015047452662712050928901609579732 f>s ,
66762579.33407483827171222646622987494984320358667  f>s ,
33510843.448484337988326974657479173122463871063629 f>s ,
16771757.864436217876998167865542972791207000620301 f>s ,
8387925.4333158980279697448720022931059406951710076 f>s ,
4194218.6697915304339458035529348884097307294860129 f>s ,
2097141.3334309885189773083430871747430847977241799 f>s ,
1048574.6666697184161638112077170894784269672512944 f>s ,
524287.83333342870070001009925056408168610804226564 f>s ,
262143.97916666964689839790576648849152067648897954 f>s ,
131071.99739583342646558682979913790960776816516342 f>s ,
65535.999674479169577049681362832458856880833734727 f>s ,
32767.999959309895924282803268616744324818262670624 f>s ,
16383.999994913736982008837607816368868542364947476 f>s ,
8191.9999993642171224846511752885747742028804181436 f>s ,
4095.9999999205271403022547242281141589367386393864 f>s ,
2047.9999999900658925375216320071312721327336871764 f>s ,
1023.9999999987582365671820724845978733843507458453 f>s ,
511.99999999984477957089750495069055870834067032599 f>s ,
255.9999999999805974463621801779024393359253311783  f>s ,
127.99999999999757468079527227408362115113274226519 f>s ,
63.999999999999696835099409026505634401207351911927 f>s ,
31.999999999999962104387426128070866230067027237218 f>s ,
15.999999999999995263048428266001285214068256715343 f>s ,
7.9999999999999994078810535332499239934869657860639 f>s ,
3.9999999999999999259851316916562331036148842762738 f>s ,
1.9999999999999999907481414614570289068402672080659 f>s ,
0.99999999999999999884351768268212860613279610955611 f>s ,

proc calc_sum_atan
  0
  30 1 do
    atan[] i -th @ +
  loop
endproc

"sum of atan" print
calc_sum_atan .

proc >> // x, n -- x>>n
 dup if
   0 do
     2 /
   loop
 else
   drop
 then
endproc


proc << // x, n -- x<<n
 dup if
   0 do
     2 *
   loop
 else
   drop
 then
endproc

proc NoAction

endproc


proc update-regs
  4 0 do
    new_reg[] i -th @ regs[] i -th !
  loop
endproc

// ph reg0
// phase reg1
// x reg2
// y reg3

proc CORDIC-STEP

  reg0 @ reg1 @ < if
    reg0 @ const_data @ + new_reg[] !
    reg2 @ reg3 @ step @ >> - new_reg[] 2 -th !
    reg3 @ reg2 @ step @ >> + new_reg[] 3 -th !
  else
    reg0 @ const_data @ - new_reg[] !
    reg2 @ reg3 @ step @ >> + new_reg[] 2 -th !
    reg3 @ reg2 @ step @ >> - new_reg[] 3 -th !
  then
  reg1 @ new_reg[] 1 -th !
  update-regs
endproc

proc cordic
  0 reg0 !
//  0 reg1 !
  0 step !
  1073741824 reg2 !
  0 reg3 !
  31 0 do
    i step !
    atan[] i -th @ const_data !

    4 0 do
      regs[] i -th @
       i 1 +
       j 1 + 0
       STRINGGRID.INT // x, col, row, index
    loop

    cordic-step

  loop

  // no action for 31 stage
    4 0 do
      regs[] i -th @
       i 1 +
       32 0
       STRINGGRID.INT // x, col, row, index
    loop

endproc

proc degree->phase // x -- phase
// 90 == 2^30
  s>f 90.0 f/  421657428.0 f* 2.0 f* f>s
endproc

proc deg->phase
  s>f pi f* 536870912.0 f* 180.0 f/ f>s
endproc

proc set-phase // x --
   reg1 !
endproc


// mult
// 0 - A
// 1 - B
// 2 - mult

proc mult-step
  reg1 @ step @ >> 1 and if
    reg0 @ step @ <<
    reg2 @ + new_reg[] 2 -th !
  else
    reg2 @ new_reg[] 2 -th !
  then
  reg0 @ new_reg[] !
  reg1 @ new_reg[] 1 -th !

  update-regs
endproc

proc mult

  0 reg2 !

  31 0 do
    i step !

    4 0 do
      regs[] i -th @
       i 1 +
       j 1 + 0
       STRINGGRID.INT // x, col, row, index
    loop

    mult-step

  loop
endproc

proc test-cordic
  0 chart.show
  0 950 2000 800 0 chart.rect
  0 0 chart.addseries
  1 0 chart.addseries
  0xFF00FF 0 SERIES.COLOR
  3 0 SERIES.LINEWIDTH
  0x003FFF 1 SERIES.COLOR
  3 1 SERIES.LINEWIDTH

  0 series.clear
  1 series.clear

  91 0 do
    i deg->phase set-phase cordic
    i s>f
    reg2 @ s>f
    0 series.fxy

    i s>f
    reg3 @ s>f
    1 series.fxy
  loop
endproc

