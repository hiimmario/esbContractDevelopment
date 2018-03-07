var bettingContract = artifacts.require("./bettingContractV1.sol");

module.exports = function(deployer) {
  deployer.deploy(bettingContract, 30010, 0, {value: 3000000000000000000});
};
