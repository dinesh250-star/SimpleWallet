// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.5.13;

contract SimpleWallet{
    address public owner;
    mapping(address => uint) allowance;
        constructor(){
        owner = msg.sender;
    }
    function addAllowance(address _who,uint _amount) public   {
        require(msg.sender == owner);
        allowance[_who] += _amount;
    }

    modifier allowed(uint _amount){
        require(msg.sender == owner || allowance[msg.sender] >= _amount,"You are not the allowed");
        _;
    }

    function withdraw(address payable _to,uint _amount) public allowed(_amount)  {
        require(_amount <= address(this).balance,"The smart contract doesnt have enough funds");
        if(owner != msg.sender){
            allowance[msg.sender] -= _amount;
        }
        _to.transfer(_amount);
        
    }
     receive() external payable {

    }
}