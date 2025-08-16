// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract ReverseString{




  function reverse(string memory str) external pure returns (string memory){
     
     uint len = bytes(str).length;
     bytes memory bt = new bytes(len);
     for (uint i=0; i<len; i++) {
        bt[i] = bytes(str)[len-1-i];
     }
     return string(bt);

  }



}