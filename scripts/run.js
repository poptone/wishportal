async function main() {
    const wishContractFactory = await hre.ethers.getContractFactory("WishPortal")
    const wishContract = await wishContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1")})
    await wishContract.deployed()
    console.log("Contract deployed, woohoo! Address:", wishContract.address);

    let contractBalance = await hre.ethers.provider.getBalance(wishContract.address)
    console.log("Balance: ", hre.ethers.utils.formatEther(contractBalance))


    let wishTxn = await wishContract.wish("A message!");
    await wishTxn.wait()

    wishTxn = await wishContract.wish("Another message!")
    await wishTxn.wait()

    contractBalance = await hre.ethers.provider.getBalance(wishContract.address)
    console.log("Balance: ", hre.ethers.utils.formatEther(contractBalance))

    let allWishes = await wishContract.getAllWishes()
}

main()
.then(() => process.exit(0))
.catch((error) => {
    console.log(error)
    process.exit(1)
    })