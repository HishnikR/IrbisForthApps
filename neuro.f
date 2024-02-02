
1000 CONSTANT #MAX

int #neurons

create neuro1[] #MAX cells allot
create neuro2[] #MAX cells allot
create neuro_f[] #MAX cells allot

create synapse_conn[] #MAX dup * cells allot
create synapse_k[] #MAX dup * allot
create neuro_synapse_quantity[] #MAX cells allot

int #synapse

int neuro[] neuro1[] to neuro[]
int neuro_old[] neuro2[] to neuro_old[]


proc frelu
  fdup 0.0 f< if fdrop 0.0 then
endproc

proc setf // function, index --
   neuro_f[] swap -th !
endproc

proc neuron // index --
  0.0
  neuro_synapse_quantity[] over -th @ 0 do
    synapse_conn[] over #MAX * -th i + @  // - input index
    neuro_old[] swap -th f@ // -- f: input value
    synapse_k[] over #MAX * -th i + f@
    f* f+
  loop
  neuro[] swap -th f!
endproc

proc process_neurons
  #neurons 0 do

  loop
endproc

int src
int dest

create str 256 allot

proc connect // index_source, index_dest --
  to dest
  synapse_conn[] dest #MAX *
    neuro_synapse_quantity[] dest -th @ + -th
  !
  neuro_synapse_quantity[] dest -th @ 1 +
  neuro_synapse_quantity[] dest -th !


endproc

proc ->
  parse
  here str>int
  connect
endproc

proc setk // neuron, index, f: k --
  swap #MAX * +
  synapse_k[] swap -th f!
endproc

proc coefs // neuron, f: { } --
  neuro_synapse_quantity[] over -th @ 0 do
    dup i setk
  loop
  drop
endproc

proc info
  #neurons 0 > if
    "Statistics on connections" print
    #neurons 0 do
      "Neuron " str s!
      str i %d
      str
      neuro_synapse_quantity[] i -th @ %d

      str " : " s+
      neuro_synapse_quantity[] i -th @ if
        neuro_synapse_quantity[] i -th @ 0 do
          str
          synapse_conn[] j #MAX * i + -th @ %d
          str "( " s+
          str
          synapse_k[] j #MAX * i + -th f@ %f
          str ") " s+
        loop
      then
      str print
    loop
    else
    "No neuron added" print
  then
endproc

2 to #neurons

1 -> 0
2 -> 0
2 -> 1
5 -> 1

0 2.0 1.0 coefs
1 4.0 3.5 coefs





