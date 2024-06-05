const ExerciseReward = artifacts.require("ExerciseReward");

module.exports = function (deployer) {
  deployer.deploy(ExerciseReward);
};
