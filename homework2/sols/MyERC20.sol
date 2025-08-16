// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "h2/IERC20.sol";

contract MyERC20 is IERC20{

    uint256 public   totalSupply;
    mapping (address => uint256) public  balances;
    mapping (address => mapping(address => uint256)) public   allowances;


    string public  name;   // 名称
    string public  symbol;  // 符号

    address public admin;

    // event Transfer(address indexed from, address indexed to, uint256 value);
    // event Approve(address owener,address spender,uint256 amount);

    constructor (string memory _name,string memory _symbol,address _admin){
        name = _name;
        symbol = _symbol;
        admin = _admin;
    }

    function mint() external {
       require(msg.sender == admin,"only admin can mint!");
       balances[admin] += 1000;
       totalSupply += 1000;
    }

    function mintTo(address to) external {
       require(msg.sender == admin,"only admin can mint!");
       balances[to] += 1000;
       totalSupply += 1000;
    }

    function  getTotalSupply() external view returns (uint256){
        return totalSupply;
    }


    function balanceOf(address account) external view returns (uint256){

        return balances[account];

    }

    function transfer(address to,uint256 amount) external returns (bool) {

        require(balances[msg.sender] > amount, " banlance not enough");
        balances[msg.sender] -=  amount;
        balances[to] +=  amount;
        emit Transfer(msg.sender,to,amount);
        return true;

    }


     function approve(address spender, uint256 amount) external returns (bool) {

        require(balances[msg.sender] > amount, " banlance not enough");
        allowances[msg.sender][spender] =  amount;
        emit Approval(msg.sender,spender,amount);
        return true;

    }

    
    function allowance(address owner, address spender) external  view returns (uint256){
        return allowances[owner][spender];
    }


    function transferFrom(address from,address to,uint256 amount) external returns (bool)  {
        
        require(allowances[from][msg.sender] > amount, " allowances not enough");
        require(balances[from] > amount, " banlance not enough");
        allowances[from][msg.sender] -=  amount;
        balances[from] -=  amount;
        balances[to] +=  amount;
        return true;

    }




}