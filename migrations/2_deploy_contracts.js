var bettingContract = artifacts.require("./bettingContractV1.sol");

module.exports = function(deployer) {
  deployer.deploy(bettingContract, 30010, "0x627306090abaB3A6e1400e9345bC60c78a8BEf57", 1, 2);
};
