// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IERC20} from "@aave/core-v3/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

//import {IPool} from "https://github.com/aave/aave-v3-core/blob/master/contracts/interfaces/IPool.sol";
//import {IPoolAddressesProvider} from "https://github.com/aave/aave-v3-core/blob/master/contracts/interfaces/IPoolAddressesProvider.sol";
//import {IERC20} from "https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/IERC20.sol";

contract MarketInteractions {
    
    address payable owner;

    IPoolAddressesProvider public immutable ADDRESS_PROVIDER;
    IPooL public immutable POOL;

    address private immutable linkAddress = 0x07C725d58437504CA5f814AE406e70E21C5e8e9e;
    IERC20 private link;

    constructor (address _addressProvider) {
        ADDRESS_PROVIDER = IPoolAddressesProvider(_addressProvider);
        POOL = IPool(ADDRESS_PROVIDER.getPool());
        owner = payable(msg.sender);
        link = ERC20(linkAddress);
    }

    function supplyLiquidity(address _tokenAddress, uint256 _amount) external {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address onBehalfOf = address(this);
        uint16 referralCode = 0;

        
        POOL.supply(asset, amount, onBehalfOf, referralCode);
    }

    function withdrawLiquidity(address _tokenAddress, uint256 _amount) external returns(uint256) {
        address asset = _tokenAddress;
        uint256 amount = _amount;
        address to = address(this);

        return POOL.withdraw(asset, amount, to);


    }

    function getUserAccountData(address _userAddress) external view returns (
      uint256 totalCollateralBase,
      uint256 totalDebtBase,
      uint256 availableBorrowsBase,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    )
    {
        return POOL.getUserAccountData(_userAddress);
    }

    

    

}