
// solid ExampleObject
//   facet normal 0.0 0.0 -1.0
//     outer loop
//       vertex 0.0 0.0 0.0
//       vertex 1.0 0.0 0.0
//       vertex 0.0 1.0 0.0
//     endloop
//   endfacet
// endsolid ExampleObject

create $ModelName 256 allot
"Stl2Model" $ModelName S!

1000000 constant maxtriangles
int triangles

create vertex[] maxtriangles 9 * floats allot

proc set-vertex // index, vertexnum, f: x, y. z --
   over 9 * over 3 * + 2 + vertex[] swap -th f!
   over 9 * over 3 * + 1 + vertex[] swap -th f!
   3 * swap 9 * + vertex[] swap -th f!
endproc


proc get-normal // index -- f: z, y, x
  local[
    int index
    float nx
    float ny
    float nz
    float nn
  ]local
  to index
  // aby * acz - abz * acy
  vertex[] index 9 * 4 + -th f@
  vertex[] index 9 * 1 + -th f@ f-
  vertex[] index 9 * 8 + -th f@
  vertex[] index 9 * 2 + -th f@ f- f*

  vertex[] index 9 * 5 + -th f@
  vertex[] index 9 * 2 + -th f@ f-
  vertex[] index 9 * 7 + -th f@
  vertex[] index 9 * 1 + -th f@ f- f*
  f- nx f!


  // abz * acx - abx * acz
  vertex[] index 9 * 5 + -th f@
  vertex[] index 9 * 2 + -th f@ f-
  vertex[] index 9 * 6 + -th f@
  vertex[] index 9 * 0 + -th f@ f- f*

  vertex[] index 9 * 3 + -th f@
  vertex[] index 9 * 0 + -th f@ f-
  vertex[] index 9 * 8 + -th f@
  vertex[] index 9 * 2 + -th f@ f- f*
  f- ny f!

  // abx * acy - aby * acx
  vertex[] index 9 * 3 + -th f@
  vertex[] index 9 * 0 + -th f@ f-
  vertex[] index 9 * 7 + -th f@
  vertex[] index 9 * 1 + -th f@ f- f*

  vertex[] index 9 * 4 + -th f@
  vertex[] index 9 * 1 + -th f@ f-
  vertex[] index 9 * 6 + -th f@
  vertex[] index 9 * 0 + -th f@ f- f*
  f- nz f!

  nx f@ fdup f*
  ny f@ fdup f* f+
  nz f@ fdup f* f+ fsqrt nn f!

  nz f@ nn f@ f/
  ny f@ nn f@ f/
  nx f@ nn f@ f/

endproc

proc save-stl
  triangles if
  "solid " print $ModelName print cr
    triangles 0 do
      "facet normal " print i get-normal f. f. f. cr
        "outer loop" print cr
        "vertex " print
          3 0 do
            vertex[] j 9 * i + -th f@ f.
          loop cr
        "vertex " print
          3 0 do
            vertex[] j 9 * 3 + i + -th f@ f.
          loop cr
        "vertex " print
          3 0 do
            vertex[] j 9 * 6 + i + -th f@ f.
          loop cr

        "endloop" print cr
      "endfacet" print cr
    loop
  "endsolid " print $ModelName print cr
  then
endproc


0 0 0.0 0.0 0.0 set-vertex
0 1 1.0 0.0 0.0 set-vertex
0 2 1.0 0.0 1.0 set-vertex


1 0 0.0 0.0 0.0 set-vertex
1 1 1.0 0.0 0.0 set-vertex
1 2 1.0 0.0 1.0 set-vertex


2 0 1.0 0.0 0.0 set-vertex
2 1 1.0 1.0 0.0 set-vertex
2 2 1.0 0.0 1.0 set-vertex


3 0 0.0 0.0 0.0 set-vertex
3 1 1.0 0.0 1.0 set-vertex
3 2 1.0 1.0 0.0 set-vertex

4 to triangles

save-stl


