//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

contract BEP20Token {

    mapping(address => uint) _balances;
    mapping(address => mapping(address => uint)) _allowance;

    uint _totalSupply;
    string _name;
    string _symbol;
    uint _decimals = 18;


    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(uint totalSupply, string memory name, string memory symbol) {
        _totalSupply = totalSupply;
        _name = name;
        _symbol = symbol;
        _balances[msg.sender] = totalSupply;
    }
    
    function tokenInfo() public view returns(uint, string memory, string memory, uint) {
        return (_totalSupply, _name, _symbol, _decimals);
    }

    function balanceOf(address owner) public view returns(uint){
        return _balances[owner];
    }

    function transfer(address to, uint value) public returns(bool){
        require(balanceOf(msg.sender) >= value, "Insufficient Balance");
        _balances[to] += value;
        _balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function transferFrom(address from, address to, uint value) public returns(bool){
        require(balanceOf(from) >= value, 'Insufficient Balance');
        require(_allowance[from][msg.sender] >= value, 'Insufficient Allowance');
        _balances[to] += value;
        _balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint value) public returns(bool){
        _allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }


}