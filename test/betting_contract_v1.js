var bettingContractV1 = artifacts.require("./bettingContractV1.sol");

contract('bettingContractV1', function(accounts) {

    it("deploy contract and check funds after contract deployment", function() {
        var betting_contract_v1;

        return bettingContractV1.deployed().then(function (instance) {

            betting_contract_v1 = instance;
            return betting_contract_v1.getMatchId.call();

        }).then(function(result) {

            assert.equal(30010, result, "match id after contract deployment should be 30100");
            return betting_contract_v1.getFunds.call();

        }).then(function(result) {

            assert.equal(10000, result, "funds from contract deployment should be 10000");
            betting_contract_v1.makeBet.call(2, {value: 10000, from:accounts[0]});
            return betting_contract_v1.getFunds.call();

        }).then(function(result) {

            console.log("funds after making a bet (should be 20000): " + result);
            assert.equal(20000, result, "funds should be 20000");

        });
    });
});
