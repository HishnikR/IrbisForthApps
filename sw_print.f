CREATE STR 256 ALLOT

create fname 256 allot



int sw_sym

int swx
int swy

int dx

10 to swx
100 to swy


: sw_print
  str strlen  0 do
    str i +  c@ .
  loop
  str strlen 2 / 0 do
    1000000 to sw_sym
    32 to dx

    str i 2 * + c@ 32 =
    str i 2 * + 1 + c@ 32 = and if
      33 to sw_sym
      "SW_Font\blank.png" fname s!
    then

    str i 2 * + 1 + c@ 176 = if
      0 to sw_sym
      "SW_Font\a.png" fname s!
    then

    str i 2 * + 1 + c@ 177 = if
      1 to sw_sym
      "SW_Font\b.png" fname s!
    then

    str i 2 * + 1 + c@ 178 = if
      2 to sw_sym
      "SW_Font\v.png" fname s!
    then

    str i 2 * + 1 + c@ 179 = if
      3 to sw_sym
      "SW_Font\g.png" fname s!
    then

    str i 2 * + 1 + c@ 180 = if
      4 to sw_sym
      "SW_Font\d.png" fname s!
    then

    str i 2 * + 1 + c@ 181 = if
      5 to sw_sym
      "SW_Font\e.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 145 = and if
      6 to sw_sym
      "SW_Font\ee.png" fname s!
    then

    str i 2 * + 1 + c@ 182 = if
      7 to sw_sym
      64 to dx
      "SW_Font\j.png" fname s!
    then

    str i 2 * + 1 + c@ 183 = if
      8 to sw_sym
      "SW_Font\z.png" fname s!
    then

    str i 2 * + 1 + c@ 184 = if
      9 to sw_sym
      "SW_Font\i.png" fname s!
    then

    str i 2 * + 1 + c@ 185 = if
      10 to sw_sym
      "SW_Font\ioda.png" fname s!
    then

    str i 2 * + 1 + c@ 186 = if
      11 to sw_sym
      "SW_Font\k.png" fname s!
    then

    str i 2 * + 1 + c@ 187 = if
      12 to sw_sym
      "SW_Font\l.png" fname s!
    then

    str i 2 * + 1 + c@ 188 = if
      13 to sw_sym
      "SW_Font\m.png" fname s!
    then

    str i 2 * + 1 + c@ 189 = if
      14 to sw_sym
      "SW_Font\n.png" fname s!
    then

    str i 2 * + c@ 208 =
    str i 2 * + 1 + c@ 190 = and if
      15 to sw_sym
      "SW_Font\o.png" fname s!
    then

    str i 2 * + c@ 208 =
    str i 2 * + 1 + c@ 191 = and if
      16 to sw_sym
      "SW_Font\p.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 128 = and if
      17 to sw_sym
      "SW_Font\r.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 129 = and if
      18 to sw_sym
      "SW_Font\s.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 130 = and if
      19 to sw_sym
      "SW_Font\t.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 131 = and if
      20 to sw_sym
      "SW_Font\u.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 132 = and if
      21 to sw_sym
      "SW_Font\f.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 133 = and if
      22 to sw_sym
      "SW_Font\h.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 134 = and if
      23 to sw_sym
      "SW_Font\tc.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 135 = and if
      24 to sw_sym
      "SW_Font\ch.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 136 = and if
      25 to sw_sym
      40 to dx
      "SW_Font\sh.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 137 = and if
      26 to sw_sym
      72 to dx
      "SW_Font\shh.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 138 = and if
      27 to sw_sym
      "SW_Font\tvz.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 139 = and if
      28 to sw_sym
      "SW_Font\ie.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 140 = and if
      29 to sw_sym
      "SW_Font\myaz.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 141 = and if
     30 to sw_sym
      "SW_Font\eee.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 142 = and if
      31 to sw_sym
      "SW_Font\uy.png" fname s!
    then

    str i 2 * + c@ 209 =
    str i 2 * + 1 + c@ 143 = and if
      32 to sw_sym
      64 to dx
      "SW_Font\ya.png" fname s!
    then

    sw_sym 100000 < if
      fname i image.load
      i image.show
      swx swy dx 32 i image.rect
      swx dx + 3 + to swx
    then
  loop
;

: clear
  100 0 do
    i image.hide
  loop
;

0 to swx
100 to swy

"кот  дионис" STR S!
sw_print


