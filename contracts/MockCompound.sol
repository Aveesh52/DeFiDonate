pragma solidity ^0.5.0;

// Everyone who deposits funds is issued time tokens.
// 1 CHAR token is equivalent to 1 DAI for 1 block and represents your voting power
// There are three phases - voting, deposit and donate
// In the voting phase CHAR holders vote on the address they would like to receive funds from the next deposit phase.
// In the deposit phases people can depositnpm
// Each epoch (e.g. 1000 blocks)

import './ICompound.sol';
import './MockDepositToken.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract MockCompound is ICompound {
    using SafeMath for uint256;

    MockDepositToken public token;

    constructor(address _token) public {
        token = MockDepositToken(_token);
    }

    function redeemUnderlying(uint redeemAmount) external returns (uint) {
        token.mint(address(this), redeemAmount);
        require(token.transfer(msg.sender, redeemAmount));
        return 0;
    }

    function mint(uint mintAmount) external returns (uint) {
        require(token.transferFrom(msg.sender, address(this), mintAmount));
        return 0;
    }

    function balanceOfUnderlying(address owner) external returns (uint) {
        // Add a small amount to owner
        return token.balanceOf(address(this)).mul(105).div(100);
    }
}
