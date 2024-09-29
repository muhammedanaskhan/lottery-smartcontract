// SPDX-License-Identifier: GPL-3.0

abstract contract BaseContract {
    int256 public x;
    address public owner;

    constructor() {
        x = 5;
        owner = msg.sender;
    }

    function setX(int256 _x) public virtual;
}


contract A is BaseContract {
    int256 public y;

    function setX(int256 _x) public override {}
}
