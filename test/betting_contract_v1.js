var bettingContractV1 = artifacts.require("./bettingContractV1.sol");

contract('bettingContractV1', function(accounts) {

    it("deploy contract and receive matchid", function() {
        var betting_contract_v1;

        return bettingContractV1.deployed().then(function (instance) {

            betting_contract_v1 = instance;
            return betting_contract_v1.returnMatchId.call();

        }).then(function(result) {

            console.log("matchId: " + result);
            assert.equal(result, 30010, "match id set is equal to what getmatchid receives");
        });
    });
});
