10 CONSTANT #NEURONS
7 CONSTANT #INPUTS

CREATE X[] #INPUTS CELLS ALLOT

CREATE K[] #INPUTS #NEURONS * CELLS ALLOT
CREATE Y[] #NEURONS CELLS ALLOT

: digit0 1 1 1 1 1 1 -1 ;
: digit1 1 1 -1 -1 -1 -1 -1 ;
: digit2 1 1 -1 1 1 -1 1 ;
: digit3 1 1 1 1 -1 -1 1 ;
: digit4 -1 1 1 -1 -1 1 1 ;
: digit5 1 -1 1 1 -1 1 1 ;
: digit6 1 -1 1 1 1 1 1 ;
: digit7 1 1 1 -1 -1 -1 -1 ;
: digit8 1 1 1 1 1 1 1 ;
: digit9 1 1 1 1 -1 1 1 ;

: set-x
  7 0 do
    x[] 6 i - -th !
  loop
;

int index

: set-k // 7segs, i --
  to index
  7 0 do
    k[] 6 i - index #INPUTS * + -th !
  loop
;

: default_k
  digit0 0 set-k
  digit1 1 set-k
  digit2 2 set-k
  digit3 3 set-k
  digit4 4 set-k
  digit5 5 set-k
  digit6 6 set-k
  digit7 7 set-k
  digit8 8 set-k
  digit9 9 set-k
;


: CALC-Y
  #NEURONS 0 DO
    0
    #INPUTS 0 DO
       X[] I -TH @
       K[] J #INPUTS * I + -th @
       *
       +
    LOOP
    Y[] I -TH !
  LOOP
;

: print-x
  #INPUTS 0 do
    X[] i -th @ .
  loop
;

: print-y
  #NEURONS 0 do
    Y[] i -th @ .
  loop
;

default_k


: SHOW-Y-LABELS
  #NEURONS 0 DO
    I LABEL.SHOW
    500 i 70 * 100 +  200 50 I Label.rect
    Y[] i -th @ I label.int
  LOOP
;

: test
  set-x calc-y print-y
  SHOW-Y-LABELS
;

: b0 digit0 test ;
: b1 digit1 test ;
: b2 digit2 test ;
: b3 digit3 test ;
: b4 digit4 test ;
: b5 digit5 test ;
: b6 digit6 test ;
: b7 digit7 test ;
: b8 digit8 test ;
: b9 digit9 test ;

: create-buttons
  10 0 do
    i button.show
    70 i * 50 + 900 50 30 i button.rect
  loop
;
create-buttons
"0" 0 button.text "b0" 0 button.action
"1" 1 button.text "b1" 1 button.action
"2" 2 button.text "b2" 2 button.action
"3" 3 button.text "b3" 3 button.action
"4" 4 button.text "b4" 4 button.action
"5" 5 button.text "b5" 5 button.action
"6" 6 button.text "b6" 6 button.action
"7" 7 button.text "b7" 7 button.action
"8" 8 button.text "b8" 8 button.action
"9" 9 button.text "b9" 9 button.action

digit5 test
