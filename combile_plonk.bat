call circom circuit.circom --r1cs --sym --wasm
call snarkjs plonk setup circuit.r1cs ceremony_final.ptau circuit_prover.zkey
call snarkjs zkey export verificationkey circuit_prover.zkey circuit_verifier.json