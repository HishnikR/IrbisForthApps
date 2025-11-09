int hCuda
int hAdd
int hInfo

int hkernel
int htick
"kernel32.dll" loadlibrary to hkernel
hkernel "GetTickCount" getprocaddress to htick

htick invoke
"Ticks " print . cr

"CUDADllStat.dll" loadlibrary to hCuda
hCuda "addVectorsCuda" getprocaddress to hAdd
hCuda "InfoCuda" getprocaddress to hInfo

// addVectorsCuda(int* c, const int* a, const int* b, unsigned int size)

"Dll address " print hCuda . cr
"Function add " print hAdd . cr
"Function info " print hInfo . cr

hInfo invoke . cr

create a[] 1 , 2 , 3 , 4 , 5 ,
create b[] 2 , 4 , 6 , 8 , 10 ,
create c[] 5 cells allot

c[] data[]+ a[] data[]+ b[] data[]+ 5 hAdd invokelong4

proc listc
  5 0 do
    c[] i -th @ . cr
  loop
endproc

listc



