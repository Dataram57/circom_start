pragma circom 2.0.0;

include "circomlib/circuits/bitify.circom";
include "circomlib/circuits/poseidon.circom";

template PoseidonMerkleRoot(level_count) {    
    //inputs
    signal input index;
    signal input value;
    signal input leafs[level_count];
    
    //get element (end leaf) path
    component bits = Num2Bits(level_count);
    bits.in <== index;

    //computation parts
    component ph_left[level_count];
    component ph_right[level_count];
    signal ph_add_left[level_count];
    signal ph_add_right[level_count];
    signal ph_next[level_count + 1];

    //define first root:    
    ph_next[0] <== value;

    //blind computation of the merkle tree root
    for (var i = 0; i < level_count; i++){
        //left
        ph_left[i] = Poseidon(2);
        ph_left[i].inputs[0] <== leafs[i];
        ph_left[i].inputs[1] <== ph_next[i];
        
        //right
        ph_right[i] = Poseidon(2);
        ph_right[i].inputs[0] <== ph_next[i];
        ph_right[i].inputs[1] <== leafs[i];
        
        //next
        ph_add_left[i] <== ph_left[i].out * bits.out[i];
        ph_add_right[i] <== ph_right[i].out * (1 - bits.out[i]);
        ph_next[i + 1] <== ph_add_left[i] + ph_add_right[i];
    }

    //output
    signal output out <== ph_next[level_count];
}
