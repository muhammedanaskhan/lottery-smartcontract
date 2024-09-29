// SPDX-License-Identifier: GPL-3.0

interface BaseContract {
    function setX(int256 _x) external;
}

contract A is BaseContract {
    int256 public y;

    function setX(int256 _x) public override {}
}
