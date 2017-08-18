var TxRegister = artifacts.require("./TxRegister.sol");
var Syndicate = artifacts.require("./SyndicateFee.sol");

module.exports = function(deployer) {
  deployer.deploy(Syndicate);
  deployer.deploy(TxRegister);
};
