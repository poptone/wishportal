// SPDX-License-Indentifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WishPortal {
    uint totalWishes;
    uint private seed;

    struct Wish {
        string message;
        address wisher;
        uint timestamp;
    }

    Wish[] wishes;

    event NewWish(address indexed from, uint timestamp, string message);

    mapping(address => uint) public lastWishedAt;
    constructor() payable {
        console.log("Howdy World!");
    }
    function wish(string memory _message)  public {
        require(lastWishedAt[msg.sender] + 30 seconds < block.timestamp, "Wait 30sec before wishing again");
        lastWishedAt[msg.sender] = block.timestamp;

        totalWishes += 1;
        console.log("%s wished w/ message %s!", msg.sender);
        console.log("Got message: %s", _message);
        wishes.push(Wish(_message, msg.sender, block.timestamp));

        uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);

        seed = randomNumber;

        if(randomNumber < 20) {
            console.log("%s won!", msg.sender);
            uint prizeAmount = 0.001 ether;
            require(prizeAmount <= address(this).balance, "Contract doesn't have money lol");
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to send money");
            }
        emit NewWish(msg.sender, block.timestamp, _message);
        }

function getAllWishes() view public returns (Wish[] memory) {
    return wishes;
}

function getTotalWishes() view public returns (uint) {
    return totalWishes;
    }
}