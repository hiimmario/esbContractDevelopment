var bettingContractV1 = artifacts.require("./bettingContractV1.sol");

contract('bettingContractV1', function(accounts) {

    it("deploy contract, take bet and set winner - happy path", function() {
        var betting_contract_v1;

        return bettingContractV1.deployed().then(function (instance) {

            betting_contract_v1 = instance;
            console.log("contract deployed");
            return betting_contract_v1.getMatchId.call();

        }).then(function(result) {

            assert.equal(30010, result, "match id after contract deployment should be 30100");
            console.log("matchid from contract deployment: " + result);
            return betting_contract_v1.getFunds.call();

        }).then(function(result) {

            assert.equal(3000000000000000000, result, "funds from contract deployment should be 3000000000000000000wei");
            console.log("contract funds after deployment in wei: " + result);
            betting_contract_v1.makeBet.sendTransaction(2, {value: 3000000000000000000, from:accounts[1]});
            return betting_contract_v1.getFunds.call();

        }).then(function(result) {

            assert.equal(6000000000000000000, result, "funds should be 6000000000000000000 wei");
            console.log("contract funds after taking bet on other team (in wei): " + result);
            betting_contract_v1.setWinner(2);
            return betting_contract_v1.getFunds.call();

        }).then(function(result) {

            console.log("set winner done, funds should be sent to winner and contract funds should be 0 at the end (in wei):  " + result);
            assert.equal(0, result, "funds should be 0 and sent to winner");

        });
    });
});
