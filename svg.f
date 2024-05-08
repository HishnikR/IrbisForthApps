// SVG

// <?xml version="1.0" standalone="no"?>
// <svg width="200" height="250" version="1.1" xmlns="http://www.w3.org/2000/svg">

// <line x1="10" x2="50" y1="110" y2="150"/>
// <polyline points="60 110, 65 120, 70 115, 75 130, 80 125, 85 140, 90 135, 95 150, 100 145"/>

// </svg>


int fsvg

string s


"demo.svg"  0 FILE.TEXT.OPENW drop
"demo" s s!

:" <?xml version="1.0" standalone="no"?>
0 file.text.writeline

:" <svg width="200" height="250" version="1.1" xmlns="http://www.w3.org/2000/svg">
0 file.text.writeline

:" <line x1="10" x2="50" y1="110" y2="150"/>
0 file.text.writeline


:" <rect x="10" y="10" width="30" height="30"/>
0 file.text.writeline

:" </svg>
0 file.text.writeline

0 FILE.TEXT.CLOSE  drop
