(async () => {
    const snarkjs = require('snarkjs');
    const fs = require('fs');

    const proofInput = JSON.parse(fs.readFileSync('input.json'));
    const { proof, publicSignals } = await snarkjs.plonk.fullProve(
    proofInput,
    'circuit_js/circuit.wasm',
    'circuit_prover.zkey'
    );

    console.log('Proof: ', proof);
    console.log('Public Signals: ', publicSignals);

    const vKey = JSON.parse(fs.readFileSync('circuit_verifier.json'));
    const res = await snarkjs.plonk.verify(vKey, publicSignals, proof);
    console.log("Verification result:", res);
})();