// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Shop {
    address public shopOwner;
    uint public productCount;

    constructor() {
        shopOwner = msg.sender;
    }

    // define custom errors
    error NotShopOwner(address caller);
    error InvalidProductPrice(uint price);
    error ProductDoesNotExist(uint productId);
    error IdAlreadyExists(uint id);

    modifier onlyShopOwner() {
        // require(msg.sender == shopOwner, "Only the shop owner can perform this action.");
        if (msg.sender != shopOwner) {
            revert NotShopOwner(msg.sender);
        }
        _;
    }

    modifier priceNotZero(uint _productPrice) {
        if (_productPrice == 0) {
            revert InvalidProductPrice(_productPrice);
        }
        _;
    }

    struct marketProduct {
        string productName;
        uint productPrice;
    }

    mapping (uint => marketProduct) marketProducts;

    function addProduct (string memory _productName, uint _productPrice) public onlyShopOwner priceNotZero(_productPrice) {
        uint _productId = productCount + 1;
        marketProduct storage newProduct = marketProducts[_productId];
        if (bytes(newProduct.productName).length != 0) {
            revert IdAlreadyExists(_productId);
        }
        newProduct.productName = _productName;
        newProduct.productPrice = _productPrice;
        productCount++;
        // productCount += 1
        // productCount = productCount + 1;
    }

    function getProduct (uint _productId) public view returns (string memory, uint) {
        require(bytes(marketProducts[_productId].productName).length != 0, "This product does not exist");
        marketProduct storage productInfo = marketProducts[_productId];
        return(productInfo.productName, productInfo.productPrice);
    }

    function updateProductPrice (uint _productId, uint _newPrice) public onlyShopOwner priceNotZero(_newPrice) {
        assert(bytes(marketProducts[_productId].productName).length != 0);
        marketProducts[_productId].productPrice = _newPrice;
    }
}