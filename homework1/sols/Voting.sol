// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract Voting{

  uint256 public len;
  mapping (address=>uint256) public voteMap;
  mapping (uint256=>address) public addrMap;
  address public admin;

constructor(address _admin){
   admin = _admin;
}


  function vote(address addr) external {
     
     if (voteMap[addr]>0){
        voteMap[addr] = voteMap[addr] + 1;
     }else {
        voteMap[addr] = voteMap[addr] + 1;
        addrMap[len] = addr;
        len++;
     }

  }

  function getVote(address addr) external view  returns (uint256){

     return voteMap[addr];

  }

function resetVotes() external {

    require(msg.sender == admin,"not admin,permission forbidden!");
    for (uint i=0;i< len;i++){
        voteMap[addrMap[i]] = 0;
        addrMap[i] = address(0);
    }
    len = 0;

}


}