const SimpleStorage = artifacts.require("Another");

module.exports = function (deployer) {
  deployer.deploy(Another);
};
