// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title CarbonCreditToken
 * @dev ERC-1155 representing different carbon offset projects/vintages.
 */
contract CarbonCreditToken is ERC1155, Ownable {
    mapping(uint256 => uint256) public totalRetired;

    event CreditsRetired(address indexed account, uint256 indexed id, uint256 amount);

    constructor(string memory _uri) ERC1155(_uri) Ownable(msg.sender) {}

    function mint(address to, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(to, id, amount, data);
    }

    /**
     * @dev "Retire" credits to claim the offset. Once retired, they are burned.
     */
    function retire(uint256 id, uint256 amount) public {
        _burn(msg.sender, id, amount);
        totalRetired[id] += amount;
        emit CreditsRetired(msg.sender, id, amount);
    }
}
