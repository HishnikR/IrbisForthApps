
create str 100 allot

int fcore
int baudrate

50000000 to fcore
115200 to baudrate

proc genuartrx
  10 0 do
    str sclear
    str i %d
    str " => " s+
    str
    i 2 * 1 + fcore * baudrate / 2 /
    %d
    i 9 < if
      str "," s+
    then
    str print
  loop
endproc

genuartrx
