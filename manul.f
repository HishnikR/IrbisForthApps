
FORTH DEFINITIONS


65536 CONSTANT MAXCODE
16384 CONSTANT MAXDATA

CREATE CODE[] MAXCODE ALLOT
CREATE DATA[] MAXDATA CELLS ALLOT
int CODE^
int DATA^

: null 0 ;

: ZC,
  CODE[] CODE^ + C!
  CODE^ 1 + TO CODE^
;

: ZA,
  CODE[] CODE^ + !
  CODE^ 4 + TO CODE^
;

: reserve32
  CODE^ 4 + TO CODE^
;

0 CONSTANT cmdNOP

: CMD CREATE , DOES> @ ZC, ;
: CMD2 CREATE , DOES> cmdNOP ZC, @ ZC, ;

proc reset-number
  0 to <number>
endproc

100 CONSTANT FLOW-SIZE
CREATE CF-ADDR[] FLOW-SIZE CELLS ALLOT
CREATE CF-ID[] FLOW-SIZE CELLS ALLOT
int CFDEPTH

: PUSH-CF // ID --
  CF-ID[] CFDEPTH -TH !
  CODE^ CF-ADDR[] CFDEPTH -TH !
  CFDEPTH 1 + TO CFDEPTH
;

1 CONSTANT cfIF
2 CONSTANT cfBEGIN
3 CONSTANT cfDO

: LIT32! // N --
  DUP 0xFF AND ZC,
  DUP 256 / 0xFF AND ZC,
  DUP 65536 / 0xFF AND ZC,
  256 / 65536 / 0xFF AND ZC,
;

: LIT16! // N --
  DUP 0xFF AND ZC,
  256 / 0xFF AND ZC,
;


: MANUL-LIT // N --
  use 0 to <number>
  40 ZC, // code for LIT32
  LIT32!
  use MANUL-LIT TO <number>
;

: TEST-LIT CODE^ . ZC, ;

: D! // d, a --
  OVER 0xFF AND OVER C!
  OVER 256 / 0xFF AND OVER 1 + C!
  OVER 65536 / 0xFF AND OVER 2 + C!
  256 / 65536 / 0xFF AND SWAP 3 + C!
;

VOCABULARY MANUL

: MAIN:
  use MANUL-LIT TO <number>

  CODE^
  0 TO CODE^
  8 ZC, // JMP32
  DUP LIT32!
  TO CODE^
  MANUL
;

: START:
  0 TO CODE^
  0 ZC, 0 ZC, 0 ZC, 0 ZC, 23 ZC,
  0x11 TO DATA^
  use MANUL-LIT TO <number>
  MANUL
;

: END
  0 TO <number>
  FORTH
;


MANUL DEFINITIONS

0  CMD NOP

12 CMD cmdJMP16
13 CMD LOOP
17 CMD NOT
16 CMD @
18 CMD NEGATE
19 CMD SHL
20 CMD SHR
21 CMD SHRA
22 CMD INPORT
3 CMD SWAP
32 CMD DUP
33 CMD OVER
// 10 CMD R>
34 CMD DEPTH
35 CMD RDEPTH
36 CMD I
64 CMD +
65 CMD -
66 CMD AND
67 CMD OR
68 CMD XOR
69 CMD =
70 CMD <
71 CMD >
72 CMD *
80 CMD DROP
23 CMD cmdJMP
24 CMD cmdCALL
25 CMD cmdRJMP
26 CMD >R
96 CMD !
97 CMD OUTPORT
86 CMD cmdIF
87 CMD cmdUNTIL
90 CMD cmdIF16

101 CMD DO
1 CMD RET

PROC IF
  [ FORTH ]
  reset-number
  cfIF PUSH-CF
  [ MANUL ]
  cmdIF
  null ZA,
  use MANUL-LIT TO <number>
ENDPROC

PROC ELSE
  [ FORTH ]
  reset-number
  CF-ID[] CFDEPTH 1 - -TH @ cfIF = [IF]
    23 ZC,
    reserve32


  [THEN]

  use MANUL-LIT TO <number>
  [ MANUL ]
ENDPROC

PROC THEN
  [ FORTH ]
  reset-number
  CF-ID[] CFDEPTH 1 - -TH @ cfIF = [IF]
    CODE^
    CF-ADDR[] CFDEPTH 1 - -TH @ CODE[] + 1 + D!
    CFDEPTH 1 - TO CFDEPTH
  [THEN]
  use MANUL-LIT TO <number>
  [ MANUL ]
ENDPROC


PROC BEGIN
  [ FORTH ]
  cfBEGIN PUSH-CF
  [ MANUL ]
ENDPROC

PROC UNTIL
  [ FORTH ]
  reset-number
  CF-ID[] CFDEPTH 1 - -TH @ cfBEGIN = [IF]
    87 ZC,
    CF-ADDR[] CFDEPTH 1 - -TH @ LIT32!
    CFDEPTH 1 - TO CFDEPTH
  [THEN]
  use MANUL-LIT TO <number>
  [ MANUL ]
ENDPROC

PROC [DO]
  [ FORTH ]
  reset-number
    0x90 ZC, 0 ZC, 2 ZC, 0x81 ZC, 0x10 ZC, 0x90 ZC, 0x30 ZC,
    0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0x30 ZC,
    0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0x81 ZC, 0x10 ZC, 0x30 ZC,

    cfDO PUSH-CF
    use MANUL-LIT TO <number>
  [ MANUL ]
ENDPROC

PROC [LOOP]
    [ FORTH ]
    reset-number
    CF-ID[] CFDEPTH 1 - -TH @ cfDO = [IF]

    0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0 ZC, 2 ZC, 0x81 ZC, 0x10 ZC, 0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0x30 ZC,
    0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0 ZC, 2 ZC,
    0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0x81 ZC,
    0x10 ZC, 0 ZC, 2 ZC, 0x15 ZC,
    CF-ADDR[] CFDEPTH 1 - -TH @ MANUL-LIT
    0x32 ZC,
    0x90 ZC, 0 ZC, 2 ZC, 0x81 ZC, 0x11 ZC, 0x90 ZC, 0x30 ZC,

    CFDEPTH -1 + TO CFDEPTH
  [THEN]
  use MANUL-LIT TO <number>
  [ MANUL ]
ENDPROC

PROC [I]
    [ FORTH ]
    reset-number

    0x90 ZC, 0 ZC, 2 ZC, 3 ZC, 0 ZC, 2 ZC,

    use MANUL-LIT TO <number>
  [ MANUL ]
ENDPROC

PROC VARIABLE
  [ FORTH ]
  CREATE DATA^ , DOES> @ MANUL-LIT
  DATA^ 1 + TO DATA^
  [ MANUL ]
ENDPROC

PROC :
  [ FORTH ]
  CREATE CODE^ , DOES> 9 ZC, @ LIT16! // LIT32!
  [ MANUL ]
ENDPROC

PROC ;
  [ FORTH ]
  1 zc,
  [ MANUL ]
ENDPROC

PROC ::
  [ FORTH ]
  CREATE CODE^ , DOES> 9 ZC, @ LIT32!
  [ MANUL ]
ENDPROC

PROC ;;
  [ FORTH ]
  1 zc,
  [ MANUL ]
ENDPROC

FORTH DEFINITIONS

33 constant DUMPROWS

: dump
  0 stringgrid.show
  0 50 1120 600 0 stringgrid.rect
  17 0 stringgrid.cols
  DUMPROWS 1 + 0 stringgrid.rows
  1 0 stringgrid.cols.fixed
  1 0 stringgrid.rows.fixed

  DUMPROWS 1 do
   i 1 - 16 *
   0 i 0 stringgrid.int
  loop

  16 0 do
    i
    i 1 + 0 0 stringgrid.int
  loop

  // X row col index --
  DUMPROWS 0 do
    16 0 do
      code[] j 16 * i + + c@
      i 1 + j 1 + 0 stringgrid.int
    loop
  loop
;

create str 256 allot
create sbuf

: >hexdigit // x -- ascii
  48 +
  dup 57 > if 7 + then
;

: add-byte // byte -
  dup 16 / 15 and >hexdigit
  0 str strlen 1 + str + c!
  str strlen str + c!

  15 and >hexdigit
  0 str strlen 1 + str + c!
  str strlen str + c!

;

create strx
" => x" strx s!

: make-vhdl
//  0 edit.show
//  0 500 500 300 0 edit.rect
  CODE^ 1 + 4 / 2 + 0 DO
    "  " str s!
    str i %D
    str strx s+
      0 str strlen 1 + str + c!
      34 str strlen str + c!
    code[] i 4 * + 3 + c@ add-byte
    code[] i 4 * + 2 + c@ add-byte
    code[] i 4 * + 1 + c@ add-byte
    code[] i 4 * + 0 + c@ add-byte
      0 str strlen 1 + str + c!
      34 str strlen str + c!
      0 str strlen 1 + str + c!
      44 str strlen str + c!
    str print
  LOOP
;

int #UART
6 to #UART

: send-word32 // word32 --
  dup           0x0f and         0 UART.WRITE
  dup  4 rshift 0x0f and 0x10 or 0 UART.WRITE
  dup  8 rshift 0x0f and 0x20 or 0 UART.WRITE
  dup 12 rshift 0x0f and 0x30 or 0 UART.WRITE
  dup 16 rshift 0x0f and 0x40 or 0 UART.WRITE
  dup 20 rshift 0x0f and 0x50 or 0 UART.WRITE
  dup 24 rshift 0x0f and 0x60 or 0 UART.WRITE
  dup 28 rshift 0x0f and 0x70 or 0 UART.WRITE
  drop
  241 0 UART.WRITE  // we = 1
  242 0 UART.WRITE  // we = 0
;

: run

  #UART 0 UART.SETPORT
  115200 0 UART.BAUDRATE
  0 UART.OPEN
  1 = if "UART opening: ok" PRINT then

  240 0 UART.WRITE // loadaddr = 0
  243 0 UART.WRITE // reset = 1
  247 0 UART.WRITE // ext program = 1

  " Bytes to write:" PRINT
  CODE^ .

  CODE^ 4 /  3 + 0 DO
    CODE[] i 4 * + @ 0xffffffff and
    send-word32
  LOOP

  246 0 UART.WRITE // ext program = 0
  244 0 UART.WRITE // reset = 0

  0 0 UART.WRITE

  0 UART.CLOSE
  "Starting." PRINT
;

: UART! // x --
  0 UART.OPEN
  1 = if "UART opening: ok" PRINT then
    0 UART.WRITE
  0 UART.CLOSE
;


: SCAN
  0 LISTBOX.SHOW
  200 0 100 50 0 listbox.rect
  0 LISTBOX.CLEAR
  10 1 DO
    I 0 UART.SETPORT
    0 UART.OPEN IF I 0 LISTBOX.ADD.INT 0 UART.CLOSE THEN
  LOOP
;

START:

: del
  10000000 0 do
  loop
;

: TEST
  IF 1 THEN
;

: DELAY
  5000000
  begin
    1 -
    DUP 0 =
  until
  DROP
;

MAIN:


begin
  20000 INPORT 0 = IF
    1 20000 OUTPORT
    0 17000 outport
    DELAY
  THEN
  20000 INPORT 1 = IF
    3 20000 OUTPORT
    250 17000 outport
    DELAY
  THEN
  20000 INPORT 2 = IF
    7 20000 OUTPORT
    500 17000 outport
    DELAY
  THEN
0 until

END

FORTH

dump
make-vhdl

0 button.show
0 0 90 30 0 button.rect
"run" 0 button.text
"run" 0 button.action

1 button.show
100 0 90 30 1 button.rect
"scan" 1 button.text
"scan" 1 button.action
