pragma solidity >=0.6.2;

import './IPublicLock.sol';

interface IUnlockswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function masterLock() external view returns (IPublicLock);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);
    function createPairWithSpecificLock(address tokenA, address tokenB, IPublicLock _pairLock) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}
