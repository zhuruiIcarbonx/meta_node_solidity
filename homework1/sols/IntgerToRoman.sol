// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
 
contract RomanNumerals {
    function intToRoman(uint num) public pure returns (string memory) {
        // 定义罗马数字的值和对应的符号
        uint[] memory values = new uint[](13);
        string[] memory symbols = new string[](13);
        values[0] = 1000; symbols[0] = "M";
        values[1] = 900; symbols[1] = "CM";
        values[2] = 500; symbols[2] = "D";
        values[3] = 400; symbols[3] = "CD";
        values[4] = 100; symbols[4] = "C";
        values[5] = 90; symbols[5] = "XC";
        values[6] = 50; symbols[6] = "L";
        values[7] = 40; symbols[7] = "XL";
        values[8] = 10; symbols[8] = "X";
        values[9] = 9; symbols[9] = "IX";
        values[10] = 5; symbols[10] = "V";
        values[11] = 4; symbols[11] = "IV";
        values[12] = 1; symbols[12] = "I";
 
        // 构建罗马数字字符串
        string memory result;
        for (uint i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                result = bytes(result).length > 0 ? string(abi.encodePacked(result, symbols[i])) : symbols[i];
                num -= values[i];
            }
        }
        return result;
    }
}