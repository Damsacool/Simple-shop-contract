require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: process.env.SEPOLIARPC,
      accounts: [process.env.PRIVATEKEY],
    },
    hardhat: {
      forking: {
        url: process.env.SEPOLIARPC,
      },
    },
  },
  etherscan: {
    apiKey: process.env.API_KEY,
  },
};
