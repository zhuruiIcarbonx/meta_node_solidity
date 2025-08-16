// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
 
contract ArrayMerger {


 function merge(uint256[] memory arr1,uint256[] memory arr2) public pure returns (uint256[] memory){

       uint256 len1 = arr1.length;
       uint256 len2 = arr2.length;
       uint256[] memory arr = new uint256[](len1+len2);

       uint256 i1=0;
       uint256 i2=0;
       uint256 i=0;
        while (i1 < len1 && i2 < len2) {
            if (arr1[i1] <= arr2[i2]) {
                arr[i] = arr1[i1];
                i1++;
            } else {
                arr[i] = arr2[i2];
                i2++;
            }
            i++;
        }

        while (i1 < len1) {
            arr[i] = arr1[i1];
            i1++;
            i++;
        }
        
        // Copy remaining elements from arr2, if any
        while (i2 < len2) {
            arr[i] = arr2[i2];
            i2++;
            i++;
        }
        
        return arr;

 }





}