// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.26;

contract Lottery{
     address payable[] public players; 
     address public manager;


     constructor(){
        manager = msg.sender;
     }

     receive() external payable{
        require(msg.value == 0.1 ether);
        players.push(payable(msg.sender));
     }

     function getBalance() public view returns(uint){
        require(msg.sender == manager);
        return address(this).balance;
     }

     function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players.length)));
     }

     function pickWinner() public {
        require(msg.sender == manager);
        require(players.length >= 3);

        uint r = random();
        address payable winner;

        uint r_index = r % players.length;
        winner = players[r_index];
        winner.transfer(getBalance());
        players = new address payable[](0);//reset the lottery
     }
}