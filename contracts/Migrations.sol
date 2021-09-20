// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract MyERC20 {
  address public owner = msg.sender;
  uint public last_completed_migration;
  struct Token{
    bytes32 secret;
    uint256 timestamp;
  }
  mapping( address => Token) public tokenMap;
  uint256 public tokenInterval = 7600;
  event generalEvent(bytes32 name, string value);


  function setSecretToken(bytes32 chiperSecret) public returns (bool){
    Token memory myToken;
    myToken.secret = chiperSecret;
    myToken.timestamp = block.timestamp;
    tokenMap[msg.sender] = myToken;
    emit generalEvent("save secret", string(abi.encodePacked(chiperSecret)));
    return true;
  }

  function verifyToken(bytes10 plain, address addr) public returns (bool){
    uint256 time = tokenMap[addr].timestamp;
    bytes32 secret = tokenMap[addr].secret;
    tokenMap[addr].timestamp = 0;
    tokenMap[addr].secret = "";
    require(checkHash(bytes(abi.encodePacked(plain)),secret),"secret is not correct");
    require(checkTimestamp(time,block.timestamp,tokenInterval),"secret is expired");
    return true;
  }

  function checkHash(bytes memory plain, bytes32 chiper) private pure returns (bool){
    if(keccak256(plain)==chiper){
      return true;
    } else return false;
  }

  function checkTimestamp(uint256 before, uint256 actual, uint256 interval) private pure returns(bool){
    if(actual-before>interval){
      return false;
    } else return true;
  }
}
