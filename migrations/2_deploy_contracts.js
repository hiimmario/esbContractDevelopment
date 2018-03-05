var bettingContract = artifacts.require("./bettingContractV1.sol");

module.exports = function(deployer) {
  deployer.deploy(bettingContract, 30010, 1, {value: 10000});
};
