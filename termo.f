32 constant xsize
32 constant ysize
32 constant zsize

create t1[] xsize ysize * zsize * floats allot
create t2[] xsize ysize * zsize * floats allot

create kx-[] xsize ysize * zsize * floats allot
create kx+[] xsize ysize * zsize * floats allot
create ky-[] xsize ysize * zsize * floats allot
create ky+[] xsize ysize * zsize * floats allot
create kz-[] xsize ysize * zsize * floats allot
create kz+[] xsize ysize * zsize * floats allot

create mat[] xsize ysize * zsize * cells allot

float dt 1.0e-6 dt f!

int time 0 to time

int ti[]
int ti+1[]

t1[] to ti[]
t2[] to ti+1[]

proc step
  zsize 1 do
    ysize 1 do
      xsize 1 do
        k xsize * ysize *
        j xsize * +
        i +
        ti[] over -th f@
        ti[] over 1 - -th f@ f-
        kx-[] over -th f@ f*

        ti[] over -th f@
        ti[] over 1 + -th f@ f-
        kx+[] over -th f@ f*
        f+

        ti[] over -th f@
        ti[] over xsize - -th f@ f-
        ky-[] over -th f@ f*
        f+

        ti[] over -th f@
        ti[] over xsize + -th f@ f-
        ky+[] over -th f@ f*
        f+

        ti[] over -th f@
        ti[] over xsize ysize * - -th f@ f-
        kz-[] over -th f@ f*
        f+

        ti[] over -th f@
        ti[] over xsize ysize * + -th f@ f-
        kz+[] over -th f@ f*
        f+

        ti+1[] swap -th f!
      loop
    loop
  loop

  ti[] ti+1[]
  to ti[] to ti+1[]

endproc

