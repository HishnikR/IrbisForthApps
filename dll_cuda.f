int hCuda
int hAdd
int hInfo
int hWav

int hkernel
int htick
"kernel32.dll" loadlibrary to hkernel
hkernel "GetTickCount" getprocaddress to htick

htick invoke
"Ticks " print . cr

"CUDADllStat.dll" loadlibrary to hCuda
hCuda "addVectorsCuda" getprocaddress to hAdd
hCuda "InfoCuda" getprocaddress to hInfo
hCuda "MacVectorsCuda" getprocaddress to hWav

// addVectorsCuda(int* c, const int* a, const int* b, unsigned int size)

// MacVectorsCuda(const double* data, unsigned long long int datasize, const double* wav, unsigned long long int num_threads, double* w )

"Dll address " print hCuda . cr
"Function add " print hAdd . cr
"Function info " print hInfo . cr

create GPUInfo[] 7 cells allot

GPUInfo[] data[]+ hInfo invokelong1 . cr

proc ShowInfo
    "Total global memory " print GPUInfo[] @ 1024 / 1024 / . " MB " print cr
    "multiProcessorCount " print GPUInfo[] 1 -th @ . cr
    "clockRate " print GPUInfo[] 2 -th @ 1000 / . " MHz" print cr
    "sharedMemPerBlock " print GPUInfo[] 3 -th @ . cr
    "regsPerBlock " print GPUInfo[] 4 -th @ . cr
    "maxThreadsPerMultiProcessor " print GPUInfo[] 5 -th @ . cr
    "maxThreadsPerBlock " print GPUInfo[] 6 -th @ . cr
endproc

ShowInfo

create a[] 1 , 2 , 3 , 4 , 5 ,
create b[] 2 , 4 , 6 , 8 , 10 ,
create c[] 5 cells allot


10 constant wavsize

256 constant GPU_threads

create x[] wavsize floats allot

create wav[] wavsize GPU_threads * floats allot

create wav_res[] GPU_threads floats allot

"Running vectors addition on GPU..." print cr

c[] data[]+ a[] data[]+ b[] data[]+ 5 hAdd invokelong4

proc listc
  5 0 do
    c[] i -th @ . cr
  loop
endproc

listc

proc fill
  wavsize 0 do
    i s>f x[] i -th f!
  loop

  GPU_threads 0 do
    wavsize 0 do
      i s>f wav[] j wavsize * i + -th f!
    loop
  loop

endproc

fill

proc listw
  GPU_threads 0 do
    wav_res[] i -th f@ f. cr
  loop
endproc

"Running wavelet on GPU...(" print GPU_threads . " threads)" print cr

x[] data[]+ wavsize
wav[] data[]+ GPU_threads
wav_res[] data[]+ hWav invokelong5

listw

: check
  0
  10 0 do
    i dup * +
  loop
  "Answer is " print . cr
;

check


