
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.26;

contract Auction {
    address payable public owner;

    // will be used to calculate when aution start/ends
    uint256 public startBlock;
    uint256 public endBlock;

    // save all info img/name on IPFS ( interplanetory file system )
    string public ipfshash;

    enum State {
        Started,
        Running,
        Ended,
        Canceled
    }

    State auctionState;

    uint256 public highestBindingBid;
    address payable public highestBidder;

    mapping(address => uint256) public bids;
 
    uint256 public bidIncrement;

    constructor() {
        owner = payable(msg.sender);
        auctionState = State.Running;

        startBlock = block.number; // supposing auction is live for a week ( 1 week = 604800 seconds => 40320 blocks generated : a block is gen in 15 secs )
        endBlock = startBlock + 40320;

        ipfshash = "";
        bidIncrement = 100;
    }

    modifier notOwner() {
        require(msg.sender != owner);
        _;
    }

    modifier afterStart() {
        require(block.number >= startBlock);
        _;
    }

    modifier beforeEnd() {
        require(block.number <= endBlock);
        _;
    }

    function placeBid() public payable notOwner afterStart beforeEnd {
        require(auctionState == State.Running);
        require(msg.value >= 100);

        uint256 currentBid = bids[msg.sender] + msg.value;
        require(currentBid > highestBindingBid);

        bids[msg.sender] = currentBid;
    }
}
