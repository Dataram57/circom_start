

# Environment Setup

```
npm install -g snarkjs

git clone https://github.com/iden3/circom
cd circom
cargo build --release
```

# Quick Start:


```
git clone https://github.com/Dataram57/circom_start.git my_new_app
cd my_new_app

npm init -y
npm i snarkjs

circom circuit.circom --r1cs
circom circuit.circom --sym
circom circuit.circom --wasm
```

### Quick code compilation
```
circom circuit.circom --r1cs --sym --wasm
```

### Ptau ceremony
Already generated Ptau ceremonies: [https://github.com/iden3/snarkjs](https://github.com/iden3/snarkjs?tab=readme-ov-file#7-prepare-phase-2)

```
snarkjs powersoftau new bn128 12 ceremony_phase0.ptau -v 
snarkjs powersoftau contribute ceremony_phase0.ptau ceremony_phase1.ptau --name="First contribution Name" -v -e="Random text 1"
snarkjs powersoftau prepare phase2 ceremony_phase1.ptau ceremony_final.ptau -v
```

### Proover, Verifier - Plonk
```
snarkjs plonk setup circuit.r1cs ceremony_final.ptau circuit_prover.zkey
snarkjs zkey export verificationkey circuit_prover.zkey circuit_verifier.json

node app_plonk.js
```

### Proover, Verifier - Groth16 (*faster*)
```
snarkjs groth16 setup circuit.r1cs ceremony_final.ptau circuit_prover.zkey
snarkjs zkey export verificationkey circuit_prover.zkey circuit_verifier.json

node app_groth16.js
```

### Verifier in Solidity 
```
snarkjs zkey export solidityverifier circuit_prover.zkey circuit_verifier.sol
```

# Resources:

- [ZKP programming - Circom](https://www.youtube.com/watch?v=fHbJdNFOpzE&list=PLfDAFuuOdPbX3xRi2eiF9zsukcjrbNLRp&index=1)
- [[Mirror] Quadratic Arithmetic Programs: from Zero to Hero](https://vitalik.eth.limo/general/2016/12/10/qap.html)

### Other

- [Build Your First ZK App with Noir](https://youtu.be/06INZUM5Ca8)
- [Lecture 10.5: Anonymous Payments](https://youtu.be/Z0s4W3UBxM8)