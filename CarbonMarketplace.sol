// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract CarbonMarketplace is ReentrancyGuard {
    struct Listing {
        address seller;
        uint256 pricePerUnit;
        uint256 amount;
    }

    IERC20 public immutable paymentToken;
    IERC1155 public immutable carbonToken;

    mapping(uint256 => Listing) public listings;

    event CreditListed(uint256 indexed id, address indexed seller, uint256 price);
    event CreditSold(uint256 indexed id, address indexed buyer, uint256 amount);

    constructor(address _paymentToken, address _carbonToken) {
        paymentToken = IERC20(_paymentToken);
        carbonToken = IERC1155(_carbonToken);
    }

    function listCredits(uint256 _id, uint256 _amount, uint256 _price) external {
        carbonToken.safeTransferFrom(msg.sender, address(this), _id, _amount, "");
        listings[_id] = Listing(msg.sender, _price, _amount);
        emit CreditListed(_id, msg.sender, _price);
    }

    function buyCredits(uint256 _id, uint256 _amount) external nonReentrant {
        Listing storage listing = listings[_id];
        uint256 totalCost = listing.pricePerUnit * _amount;

        paymentToken.transferFrom(msg.sender, listing.seller, totalCost);
        carbonToken.safeTransferFrom(address(this), msg.sender, _id, _amount, "");
        
        listing.amount -= _amount;
        emit CreditSold(_id, msg.sender, _amount);
    }
}
