pragma circom 2.0.0;


//calculates a ** b
//n - number of bits for b
include "circomlib/circuits/bitify.circom";
template Power(nBits) {
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

template MainCircuit() {
    //input
    signal input a;
    signal input b;
    signal output out;

    //Multiply `a * b`;
    out <== a * b;

    //Power `a ** b` where b has to have number of specified bits
    //component pow = Power(256);
    //pow.in_a <== a;
    //pow.in_b <== b;
    //out <== pow.out;
 }

component main = MainCircuit();
