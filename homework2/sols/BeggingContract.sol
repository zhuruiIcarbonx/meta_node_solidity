// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract BeggingContract {

   address public admin;
   uint public totalAmount;
   // 存款余额
    mapping(address => uint) public balances;

    event Donation(address sender,uint amount, uint gas);
    event Withdraw(address to,uint amount, uint gas);
    
    receive() external payable{
        emit Donation(msg.sender,msg.value, gasleft());
    }

    constructor(address _admin){
       admin = _admin;
    }

    // 定义modifier
    modifier onlyAdmin {
        require(msg.sender == admin); 
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }

    // 存款
    function donate(address payable to,uint amount) external payable {
        require(to == address(this), " to address not contract address");
        require(amount > 0, " value is zero");
        require(msg.sender.balance >= amount, " balance not enough");
        to.transfer(amount);
        balances[msg.sender] += amount;
        totalAmount += amount;
        
    }

    // 取款
    function withdraw (address payable addr)  external  payable onlyAdmin {
        addr.transfer(totalAmount);
        emit Withdraw(addr,totalAmount, gasleft());
    }

    // 查询
    function getDonate(address addr) external view returns (uint) {
       return balances[addr];
    }


}