pragma solidity >=0.6.2;

import '../interfaces/IUnlockswapV2Factory.sol';
import './UnlockswapV2Pair.sol';
import '../interfaces/IPublicLock.sol';

contract UnlockswapV2Factory is IUnlockswapV2Factory {
    address public override feeTo;
    address public override feeToSetter;
    IPublicLock public override masterLock;

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    constructor(address _feeToSetter, IPublicLock _masterLock) public {
        feeToSetter = _feeToSetter;
        masterLock = _masterLock;
    }

    function allPairsLength() external view override returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external override returns (address pair) {
        require(tokenA != tokenB, 'UnlockswapV2: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UnlockswapV2: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'UnlockswapV2: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(UnlockswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IUnlockswapV2Pair(pair).initialize(token0, token1, masterLock);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function createPairWithSpecificLock(address tokenA, address tokenB, IPublicLock _pairLock) external override returns (address pair) {
        require(tokenA != tokenB, 'UnlockswapV2: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UnlockswapV2: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'UnlockswapV2: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(UnlockswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IUnlockswapV2Pair(pair).initialize(token0, token1, _pairLock);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external override {
        require(msg.sender == feeToSetter, 'UnlockswapV2: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external override {
        require(msg.sender == feeToSetter, 'UnlockswapV2: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
