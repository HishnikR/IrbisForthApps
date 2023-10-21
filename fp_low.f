

: low-precision // a --
  dup 0 swap c!
  dup 1 + 0 swap c!
  dup 2 + 0 swap c!
  dup 3 + 0 swap c!
  dup 4 + 0 swap c!
;

float x
1.2345 x f!
x f@ f.
x low-precision
x f@ f.

