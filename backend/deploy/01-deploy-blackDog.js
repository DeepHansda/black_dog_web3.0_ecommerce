const { network } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
  try {
    const { deploy, log } = deployments;
    const { deployer } =await getNamedAccounts();
    const blockConfirmation = network.config.blockConfirmation || 1;

    console.log("Deploying............")
    await deploy("BlackDog", {
      log: true,
      from: deployer,
      waitConfirmations: blockConfirmation,
      args: [],
    })
      .then((res) => {
        console.log(`Contract Deployed on ${res.address}`)
        // console.log(res);
      })
      .catch((err) => {
        console.log(err);
      });
  } catch (error) {
    console.log(error);
  }
};

module.exports.tags = ["all", "blackDog"];
