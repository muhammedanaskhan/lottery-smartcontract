//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface ERC20Interface {
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256);
    function transfer(address _to, uint256 value) external returns(bool success);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}

contract Cryptos is ERC20Interface{
    string public name = "Cryptos";
    string public symbol = "CRPT";
    uint public decimals = 0;
    uint public override totalSupply;

    address public founder;
    mapping(address => uint) public balances;

    constructor () {
        totalSupply = 10000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address _owner) public view override returns (uint256){
        return balances[_owner];
    }

    function transfer(address _to, uint256 value) public override returns (bool success){
        require(balances[msg.sender] >= value);

        balances[_to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, _to, value);
        
        return true;
    }

}
