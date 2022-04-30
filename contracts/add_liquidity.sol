pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IUS {
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );
}

contract TestSwapUniswap {
    address private constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function swap(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _to
    ) external {
        IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);
        IERC20(_tokenIn).approve(UNISWAP_V2_ROUTER, _amountIn);

        address[] memory path;
        path = new address[](3);
        path[0] = _tokenIn;
        path[1] = WETH;
        path[2] = _tokenOut;

        IUS(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
            _amountIn,
            _amountOutMin,
            path,
            _to,
            block.timestamp
        );
    }

    function addLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _amountA,
        uint256 _amountB
    ) external {
        IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
        IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);

        IERC20(_tokenA).approve(ROUTER, _amountA);
        IERC20(_tokenB).approve(ROUTER, _amountB);

        (uint256 amountA, uint256 amountB, uint256 liquidity) = IUniswap(ROUTER)
            .addLiquidity(
                _tokenA,
                _tokenB,
                _amountA,
                _amountB,
                1,
                1,
                address(this),
                block.timestamp
            );
        emit Log("amountA", amountA);
        emit Log("amountB", amountB);
        emit Log("liquidity", liquidity);
    }
}

// interface IUniswap {
//     function addLiquidity(
//         address tokenA,
//         address tokenB,
//         uint256 amountADesired,
//         uint256 amountBDesired,
//         uint256 amountAMin,
//         uint256 amountBMin,
//         address to,
//         uint256 deadline
//     )
//         external
//         returns (
//             uint256 amountA,
//             uint256 amountB,
//             uint256 liquidity
//         );

//     function getPair(address tokenA, address tokenB)
//         external
//         view
//         returns (address pair);
// }

// interface IPaid {
//     function getReserves()
//         external
//         view
//         returns (
//             uint112 reserve0,
//             uint112 reserve1,
//             uint32 blockTimestampLast
//         );
// }

// contract AddLiqudityTest {
//     constructor() payable {
//         // address(this).balance += msg.value;
//     }

//     // Uniswap Factory Address
//     address private constant FACTORY =
//         0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;

//     // Uniswap Router Address
//     address private constant ROUTER =
//         0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

//     // Address of DAI conint =
//     address private constant DAI = 0xc7AD46e0b8a400Bb3C915120d284AafbA8fc4735;

//     address public double;

//     event Log(string message, uint256);
//     event Pairs(address pair);

//     function getTokenReserves(address _token1, address _token2)
//         external
//         view
//         returns (uint256, uint256)
//     {
//         address pair = IUniswap(FACTORY).getPair(_token1, _token2);
//         //emit Pairs(pair);
//         (uint256 reserve0, uint256 reserve1, ) = IPaid(pair).getReserves();

//         return (reserve0, reserve1);
//     }

//     function addLiquidity(
//         address _tokenA,
//         address _tokenB,
//         uint256 _amountA,
//         uint256 _amountB
//     ) external {
//         IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
//         IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);

//         IERC20(_tokenA).approve(ROUTER, _amountA);
//         IERC20(_tokenB).approve(ROUTER, _amountB);

//         (uint256 amountA, uint256 amountB, uint256 liquidity) = IUniswap(ROUTER)
//             .addLiquidity(
//                 _tokenA,
//                 _tokenB,
//                 _amountA,
//                 _amountB,
//                 1,
//                 1,
//                 address(this),
//                 block.timestamp
//             );
//         emit Log("amountA", amountA);
//         emit Log("amountB", amountB);
//         emit Log("liquidity", liquidity);
//     }
// }
