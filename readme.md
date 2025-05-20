



# Quick Start:

```
circuit.circom --r1cs --wasm --sym
```


---
# Witness - The footage of your actions

### Utilize the 'info' command to display statistics about the circuit
```
snarkjs r1cs info circuit.r1cs
```
### Execute a command to verify by printing the circuit's constraints.
```
snarkjs r1cs print circuit.r1cs circuit.sym
```

### Convert the r1cs file to JSON format for easier human interpretation.
```
snarkjs r1cs export json circuit.r1cs circuit.r1cs.json
```

### Initiate the creation of the witness file
```
node circuit_js/generate_witness.js circuit_js/circuit.wasm input.json circuit_input.wtns 
```

### Verify the compliance of the generated witness with the r1cs file using this command:
```
snarkjs wtns check fibonacci.r1cs fibonacci.wtns
```

---
# Powers of tau - Masonic NWO

Legit Masonic Rituals:
https://github.com/iden3/snarkjs?tab=readme-ov-file#7-prepare-phase-2

### This command initializes a fresh powers of tau file.
```
snarkjs powersoftau new bn128 12 phase1_pot12_00.ptau -v 
```

### The 'contribute' command generates a new contribution in the ptau file.
```
snarkjs powersoftau contribute phase1_pot12_00.ptau phase1_pot12_01.ptau --name="First contribution Name" -v -e="Random text 1"
```

### Adds an additional layer of contribution.
```
snarkjs powersoftau contribute phase1_pot12_01.ptau phase1_pot12_02.ptau --name="Second contribution Name" -v -e="Random text 2"
```

### Introduces a third layer of contribution utilizing third-party software.
```
snarkjs powersoftau export challenge phase1_pot12_02.ptau phase1_challenge_03
snarkjs powersoftau challenge contribute bn128 phase1_challenge_03 phase1_response_03 -e="Random text"
snarkjs powersoftau import response phase1_pot12_02.ptau phase1_response_03 phase1_pot12_03.ptau -n="Third contribution name"
```

### Implements a random beacon in the ptau file for enhanced randomness.
A random beacon acts as a verifiable source of public randomness, becoming available only after a predetermined time.
```
snarkjs powersoftau beacon phase1_pot12_03.ptau phase1_pot12_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"
```

### Initiating the readiness for phase 2 of the setup, which is specific to the circuit.
```
snarkjs powersoftau prepare phase2 phase1_pot12_beacon.ptau phase1_pot12_final.ptau -v
```

---
# Proving and verifying keys

### Proving and verifying keys in Plonk
```
snarkjs plonk setup circuit.r1cs ptau.ptau circuit_prover.zkey
snarkjs zkey export verificationkey circuit_prover.zkey circuit_verifier.json
```



