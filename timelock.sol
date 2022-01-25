pragma solidity ^0.8.11;

contract FundLock {

    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;


    function deposit() external payable {
        require(msg.value >= 1 ether, "Minimum Lock is 1 Ether");
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _seconds) public {
        lockTime[msg.sender] += _seconds;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient Balance");
        require(block.timestamp > lockTime[msg.sender], "LockTime Not Reached");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed To send Ether");
    }
}

