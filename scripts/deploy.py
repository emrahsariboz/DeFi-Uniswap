from brownie import TestSwapUniswap, config, network, accounts, web3, interface
from web3 import Web3
import math


def main():
    deploy()


def deploy():
    DAI_WHALE = "0x6B175474E89094C44Da98b954EedeAC495271d0F"
    WETH_ADDRESS = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
    WBTC = "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599"
    DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F"

    # 1000 DAI
    amountIn = Web3.toWei(1000, "ether")

    # Min Amount
    amountOutMin = 1

    # account = accounts.add(config["wallets"]["from_key"])
    account = accounts[0]

    # Initialize
    tokenIn = interface.IERC20(DAI)
    tokenOut = interface.IERC20(WBTC)

    contract = TestSwapUniswap.deploy(
        {"from": account}  # , "value": web3.toWei(0.1, "ether")}
    )

    # Approve
    tokenIn.approve(contract.address, amountIn, {"from": DAI_WHALE})

    # Swap
    contract.swap(
        tokenIn.address,
        tokenOut.address,
        amountIn,
        amountOutMin,
        account,
        {"from": DAI_WHALE},
    )

    print(f"WBTC balance of address {account} is {tokenOut.balanceOf(account)}")

    contract.addLiquidity(
        WETH_ADDRESS,
        DAI,
    )
