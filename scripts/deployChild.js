async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Contract = await ethers.getContractFactory("ChildContract");
  const contract = await Contract.deploy();

  console.log("Contract address:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

// // 10秒ごとに main 関数を実行する
// setInterval(() => {
//   main()
//     .then(() => console.log('Deployment successful'))
//     .catch(error => {
//       console.error(error);
//       process.exit(1);
//     });
// }, 10000);