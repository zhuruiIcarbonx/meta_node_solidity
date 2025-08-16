// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


contract RomanToIntger{

  
  mapping (string=>uint256) public initMap;

constructor(){
   initMap["I"]=1;
   initMap["V"]=5;
   initMap["X"]=10;
   initMap["L"]=50;
   initMap["C"]=100;
   initMap["D"]=500;
   initMap["M"]=1000;

}


  function toInt(string memory str)  external view returns (uint256 ){
     
     uint len = bytes(str).length;
     bytes memory bt = bytes(str);
     uint256   result;
     uint256  preValue;
     string memory k;
     for (uint i=0; i < len; i++) {
        k = string(abi.encodePacked(bt[i]));
        uint256 value = initMap[k];
        if(value < preValue){
            result -= value;
        } else {
            result += value;
        }
        preValue = value;
     }
     return result;

  }



}