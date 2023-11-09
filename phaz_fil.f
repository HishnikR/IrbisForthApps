create xy[] 10000 allot
int size

"phaz_fil.xy" 0 file.text.open drop
0 xy[] file.text.fxy to size

0 file.text.close drop

size .


0 CHART.SHOW
0 CHART.ALIGN.CLIENT

0 0 CHART.ADDSERIES
0xFF00FF 0 SERIES.COLOR
3 0 SERIES.LINEWIDTH

proc add-all
  0 series.clear
  size 0 do
     xy[] i 2 * 8 * + f@
     xy[] i 2 * 1 + 8 * + f@
     0 series.fxy
  loop
endproc

add-all


