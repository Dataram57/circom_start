circom circuit.circom --r1cs --sym --wasm
snarkjs plonk setup circuit.r1cs ceremony_final.ptau circuit_prover.zkey
snarkjs zkey export verificationkey circuit_prover.zkey circuit_verifier.json