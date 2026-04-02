# Carbon Credit Offset Marketplace

A professional-grade implementation for the Regenerative Finance (ReFi) sector. This repository enables the trading and "Retiring" of carbon offsets. Using the ERC-1155 standard, it supports multiple vintages (years) and project types (reforestation, methane capture) in a single contract.

## Core Features
* **Fractional Offsets:** Trade small amounts of carbon credits (1 kg CO2e) to make offsetting accessible to retail users.
* **Retirement Logic:** A permanent "Burn" function that issues a non-transferable certificate (SBT) upon carbon retirement.
* **Metadata Standards:** Links to third-party audits (Verra, Gold Standard) stored on IPFS.
* **Flat Architecture:** Single-directory layout for the Marketplace, Credit Token, and Retirement registry.

## Workflow
1. **Mint:** Project developers mint credits after verification.
2. **List:** Credits are listed on the marketplace for a fixed price in USDC.
3. **Buy:** Companies or individuals purchase credits.
4. **Offset:** Users "Retire" the credits to claim the environmental benefit, removing them from circulation.

## Setup
1. `npm install`
2. Deploy `CarbonMarketplace.sol` and `CarbonCreditToken.sol`.
