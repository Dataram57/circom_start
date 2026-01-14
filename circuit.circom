//================================================================
//Circom

pragma circom 2.0.0;



//================================================================
//Requirements

include "circomlib/circuits/bitify.circom";
include "circomlib/circuits/comparators.circom";


//================================================================
//Cool circuits

include "poseidon_merkle_root.circom";


//================================================================
//Operations

template Division(){
    //Division `a / b`
    signal input in_a;
    signal input in_b;
    signal output out;

    //divide
    out <-- in_a / in_b;  //assign forgeable division expression
    
    //Make sure the division is correct.
    out * in_b === in_a;
    
    //Make sure b is not 0.
    component b_isZero = IsZero();
    b_isZero.in <== in_b;
    b_isZero.out === 0; 
 }

template Modulo(nBits){
    signal input in_a;          // dividend
    signal input in_b;          // divisor
    signal output out_q;        // quotient
    signal output out_r;        // remainder

    //calculate suggested values
    out_r <-- in_a % in_b;
    out_q <-- (in_a - (in_a % in_b)) / in_b;

    //Ensure b is not 0
    component b_isZero = IsZero();
    b_isZero.in <== in_b;
    b_isZero.out === 0;

    //Main division constraint
    in_a === out_q * in_b + out_r;

    // Enforce remainder < b
    component lt = LessThan(nBits);
    lt.in[0] <== out_r;
    lt.in[1] <== in_b;
    lt.out === 1;
 }

template Power(nBits){
    //inputs
    signal input in_a;
    signal input in_b;

    //bits
    signal bits[nBits];
    component n2b = Num2Bits(nBits);
    n2b.in <== in_b;
    for (var i = 0; i < nBits; i++) {
        bits[i] <== n2b.out[i];
    }

    //power array
    signal powers[nBits];
    powers[0] <== in_a;
    for (var i = 1; i < nBits; i++) {
        powers[i] <== powers[i - 1] * powers[i - 1];
    }
    
    //factors array
    signal factors[nBits];
    for (var i = 0; i < nBits; i++) {
        factors[i] <== powers[i] * bits[i] + (1 - bits[i]);
    }

    //multiply
    signal acc[nBits];
    acc[0] <== factors[0];
    for (var i = 1; i < nBits; i++) {
        acc[i] <== acc[i-1] * factors[i];
    }

    //result
    signal output out;
    out <== acc[nBits-1];
 }

//================================================================
//Main

template MainCircuit() {
    //input
    signal input a;
    signal input b;
    signal output out;    

    //Addition `a + b`;
    out <== a + b;

    //Subtraction `a - b`;
    //out <== a - b;

    //Multiplication `a * b`;
    //out <== a * b;

    //Division `a / b`
    //component div = Division();
    //div.in_a <== a;
    //div.in_b <== b;
    //out <== div.out;

    //Modulo `a % b`
    //component mod = Modulo(252); // for 252-bit numbers
    //mod.in_a <== a;
    //mod.in_b <== b;
    //out <== mod.out_r;
    //signal output out2 <== mod.out_q;

    //Power `a ** b`
    //component pow = Power(256); //for 256 bit numbers
    //pow.in_a <== a;
    //pow.in_b <== b;
    //out <== pow.out;
 }

component main = MainCircuit();


