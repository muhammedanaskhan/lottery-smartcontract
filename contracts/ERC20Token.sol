//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface ERC20Interface {
    function totalSupply() external view returns (uint256);

    function balanceOf(address _owner) external view returns (uint256);

    function transfer(address _to, uint256 value)
        external
        returns (bool success);

    function allowance(address _owner, address _sender)
        external
        returns (uint256 remaining);

    function approve(address _spender, uint256 _value) external returns (bool success);

    function transferFrom(
        address _from,
        address _to,
        uint256 value
    ) external returns (bool success);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

contract Cryptos is ERC20Interface {
    string public name = "Cryptos";
    string public symbol = "CRPT";
    uint256 public decimals = 0;
    uint256 public override totalSupply;

    address public founder;
    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256)) allowed;

    constructor() {
        totalSupply = 10000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 value)
        public
        override
        returns (bool success)
    {
        require(balances[msg.sender] >= value);

        balances[_to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, _to, value);

        return true;
    }

    function allowance(address _owner, address _sender)
        public
        view
        override
        returns (uint256 remaining)
    {
        return allowed[_owner][_sender];
    }

     function approve(address _spender, uint256 _value) public override returns (bool success){
        require(balances[msg.sender] >= _value);
        require(_value >= 0);

        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);

        return true;
     }

      function transferFrom(address _from, address _to, uint256 value) external returns (bool success){
        require(allowed[_from][msg.sender] >= value);
        require(balances[_from] >= value);

        balances[_from] -= value;
        allowed[_from][msg.sender] -= value;

        balances[_to] += value;

        emit Transfer(_from,  _to, value);
        return true;

      }
}
