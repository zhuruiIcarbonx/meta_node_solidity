// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract BinarySearch {
 
   
    uint256[] public sortedArray;
 
    
    constructor(uint256[] memory initialValues) {
        sortedArray = initialValues;
    }
 
   
    function binarySearch(uint256 value) public view returns (bool) {
        return binarySearchInternal(value, 0, sortedArray.length - 1);
    }
 
    
    function binarySearchInternal(uint256 value, uint256 left, uint256 right) private view  returns (bool) {
        if (left > right) {
            return false; 
        }
        uint256 mid = (left + right) / 2;
        if (sortedArray[mid] == value) {
            return true; 
        } else if (sortedArray[mid] < value) {
            return binarySearchInternal(value, mid + 1, right); 
        } else {
            return binarySearchInternal(value, left, mid - 1); 
        }
    }
}