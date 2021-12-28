//SPDX-License-Identifier: GPL-3.0

//Lottery SmartContract 

pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    
    address payable[] public players;
    address public manager;

    constructor(){
        manager = msg.sender;
    }

    receive() external payable{
        //checks if value sent to the contract is 0.1 ether, else fails.
        require(msg.value == 0.1 ether);
        //Convert An Address to A Payable one
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
    }

    function pickWinner() public{
        require(msg.sender == manager);
        require(players.length >= 3);

        uint r = random();
        address payable winner;
        uint winnerIndex = r % players.length;
        winner = players[winnerIndex];
        winner.transfer(getBalance());

        //Resetting the Lottery Contract
        players = new address payable[](0);
    }
    
}