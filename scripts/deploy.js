
async function main() {
  // We get the contract to deploy
  const TransferHelper = await ethers.getContractFactory("contracts/libraries/TransferHelper.sol:TransferHelper");
  const SafeMath = await ethers.getContractFactory("SafeMath");
  const UnlockswapV2Library = await ethers.getContractFactory("UnlockswapV2Library");


  const UnlockswapV2Factory = await ethers.getContractFactory("UnlockswapV2Factory");
  // const UnlockswapV2Router02 = await ethers.getContractFactory("UnlockswapV2Router02");

const UnlockswapV2Router02 = await ethers.getContractFactory("contracts/v2-periphery-udt/UnlockswapV2Router02.sol:UnlockswapV2Router02")
	var mainLockAddress = "0x52AfD4E40bc38AAca93311037246cdb1C6bC3CfE"
	var wethAddress = "0xc778417e063141139fce010982780140aa0cd5ab"

const unlockswapV2Factory = await UnlockswapV2Factory.deploy(mainLockAddress, mainLockAddress);
const unlockswapV2Router02 = await UnlockswapV2Router02.deploy(unlockswapV2Factory.address, wethAddress);


  console.log("unlockswapV2Factory deployed to:", unlockswapV2Factory.address);
  console.log("unlockswapV2Router02 deployed to:", unlockswapV2Router02.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });







// var UnlockswapV2Factory = artifacts.require("v2-core-udt/UnlockswapV2Factory.sol");
// var UnlockswapV2Router02 = artifacts.require("v2-periphery-udt/UnlockswapV2Router02.sol");
// var TransferHelper = artifacts.require("libraries/TransferHelper.sol");
// var SafeMath = artifacts.require("libraries/SafeMath.sol");
// var UnlockswapV2Library = artifacts.require("libraries/UnlockswapV2Library.sol");


// module.exports = (deployer, network, accounts) => {
//     deployer.then(async () => {
//         await deployUnlockSwap(deployer, network, accounts); 
//         await deployRecap(deployer, network, accounts); 
//     });
// };

// async function deployUnlockSwap(deployer, network, accounts) {
// 	// Rinkeby
// 	var mainLockAddress = "0x52AfD4E40bc38AAca93311037246cdb1C6bC3CfE"
// 	var wethAddress = "0xc778417e063141139fce010982780140aa0cd5ab"
// 	unlockSwapFactoryDeployed = await UnlockswapV2Factory.new(MainLock);
// 	transferHelperDeployed = await TransferHelper.new();
// 	safeMathDeployed = await SafeMath.new();
// 	unlockswapV2LibraryDeployed = await UnlockswapV2Library.new();
// 	await deployer.link(UnlockswapV2Router02, [unlockswapV2LibraryDeployed, safeMathDeployed, transferHelperDeployed]);
// 	unlockswapV2Router02Deployed = await UnlockswapV2Router02.new(unlockSwapFactoryDeployed.address, wethAddress);
		
// }

// async function deployRecap(deployer, network, accounts) {
// 	console.log("unlockSwapFactoryDeployed " + unlockSwapFactoryDeployed.address)
// 	console.log("unlockswapV2Router02Deployed " + unlockswapV2Router02Deployed.address)
// }


