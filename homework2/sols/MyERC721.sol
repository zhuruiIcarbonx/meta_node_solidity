// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";



contract MyERC721 is IERC721,IERC721Metadata{

    using Strings for uint256; // 使用Strings库，

    string private  _name;
    string private  _symbol;
    uint private  _tokenId;

    // tokenId 到 owner address 的持有人映射
    mapping(uint => address) private owners;
    // address 到 持仓数量 的持仓量映射
    mapping(address => uint) private balances;
    // tokenID 到 授权地址 的授权映射
    mapping(uint => address) private tokenApprovals;
    // owner地址 到 operator地址 的批量授权映射
    mapping(address => mapping(address => bool)) private operatorApprovals;

    // 错误 无效的接收者
    error ERC721InvalidReceiver(address receiver);
    
    constructor(string memory name_, string memory symbol_){
        _name = name_;
        _symbol = symbol_;
    }

    //IERC721Metadata
    function name() external view returns (string memory){
        return _name;
    }

    //IERC721Metadata
    function symbol() external view returns (string memory){
        return _symbol;
    }
   
    function mintNFT(address recipient) external returns (uint){

        require(recipient != address(0), " address cannot be 0");
        _tokenId++ ;
        owners[_tokenId] = recipient;
        balances[recipient] +=  1;
        emit Transfer(address(0), recipient,_tokenId);
        return _tokenId;
        

    } 

     function burnNFT(uint tokenId) external returns (bool){

        require(tokenId > 0," tokenId show greater than 0");
        require(msg.sender == owners[tokenId]," tokenId not yours");
        owners[tokenId] = address(0);
        balances[msg.sender] -= 1;
        emit Transfer(msg.sender, address(0),tokenId);
        return true;

    } 

    //IERC721Metadata
    function tokenURI(uint tokenId) external view returns (string memory){

        require(owners[tokenId] != address(0), "Token Not Exist");
        string memory _baseURI = baseURI();
        if (bytes(_baseURI).length > 0) {
            return string(abi.encodePacked(_baseURI, tokenId.toString()));
        }
        return "";
    }

     function baseURI() internal pure returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }

     //IERC165
    function supportsInterface(bytes4 interfaceId) external pure returns (bool){
        return
            interfaceId == type(IERC721).interfaceId||
            interfaceId == type(IERC165).interfaceId||
            interfaceId == type(IERC721Metadata).interfaceId;

    }


   function balanceOf(address owner) external view returns (uint256 balance){
         require(owner != address(0), "not a address");
         balance =  balances[owner];
   }

   
    function ownerOf(uint tokenId) external view returns (address owner){
        require(owners[tokenId] != address(0), "Token Not Exist");
        owner = owners[tokenId];
    
   }

  
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external{
        require(from != address(0), " from address cannot be 0");
        require(to != address(0), " to address cannot be 0");
        require(owners[tokenId] ==  from," tokenId owner not from address");
        _transfer(msg.sender,from, to, tokenId);
        _checkOnERC721Received(from, to, tokenId, data);
    
   }
   
   // _checkOnERC721Received：函数，用于在 to 为合约的时候调用
   //IERC721Receiver-onERC721Received, 以防 tokenId 被不小心转入黑洞。
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory data) private {
        if (to.code.length > 0) {
            try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
                if (retval != IERC721Receiver.onERC721Received.selector) {
                    revert ERC721InvalidReceiver(to);
                }
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert ERC721InvalidReceiver(to);
                } else {
                    /// @solidity memory-safe-assembly
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        }
    }

   
    function safeTransferFrom(address from, address to, uint256 tokenId) external{
        
        require(from != address(0), " from address cannot be 0");
        require(to != address(0), " to address cannot be 0");
        require(owners[tokenId] ==  from," tokenId owner not from address");
        _transfer(msg.sender,from, to, tokenId);
    
   }

    
    function transferFrom(address from, address to, uint256 tokenId) external{

        require(from != address(0), " from address cannot be 0");
        require(to != address(0), " to address cannot be 0");
        require(owners[tokenId] ==  from," tokenId owner not from address");
        
        _transfer(msg.sender,from, to, tokenId);
    
   }

   function _transfer(address sender,address from, address to, uint256 tokenId) private{

        require(from == sender||tokenApprovals[tokenId]==sender, " not your tokenId or not approved");
        tokenApprovals[tokenId] = to;
        owners[tokenId] = to;
        balances[from] -=1;
        balances[to] +=1;
        emit Transfer(from, to, tokenId);
    
   }

    
    function approve(address to, uint256 tokenId) external{

         require(to != address(0), " to address cannot be 0");
         require(tokenId > 0," tokenId shoud greater than 0");
         require(msg.sender == owners[tokenId], " tokenId not yours");
         tokenApprovals[tokenId] = to;
         emit Approval(msg.sender, to, tokenId);
    
   }

 
    function setApprovalForAll(address operator, bool approved) external{

        require(operator != address(0), " operator address cannot be 0");
        operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
        
    
   }

  
    function getApproved(uint256 tokenId) external view returns (address operator){
         require(tokenId > 0," tokenId shoud greater than 0");
         operator = tokenApprovals[tokenId];
    
   }

   
    function isApprovedForAll(address owner, address operator) external view returns (bool){
        require(owner != address(0), " owner address cannot be 0");
        require(operator != address(0), " operator address cannot be 0");
        return operatorApprovals[owner][operator] ;
    
   }

}