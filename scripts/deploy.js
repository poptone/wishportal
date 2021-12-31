async function main() {
    const wishContractFactory = await ethers.getContractFactory("WishPortal");
    const wishContract = await wishContractFactory.deploy({value: ethers.utils.parseEther("0.1")});
    await wishContract.deployed()
    console.log("WishPortal address:", wishContract.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });