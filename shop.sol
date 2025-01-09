// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Shop {
    address public shopOwner;

    constructor() {
        shopOwner = msg.sender;
    }

    modifier onlyShopOwner() {
        require(msg.sender == shopOwner, "Only the shop owner can perform this action.");
        _;
    }

    modifier priceNotZero(uint _productPrice) {
        if (_productPrice == 0) {
            revert("The price of the product can not be Zero, Enter a valid price");
        }
        _;
    }

    struct marketProduct {
        string productName;
        uint productPrice;
    }

    mapping (uint => marketProduct) public marketProducts;

    function addProduct (string memory _productName, uint _productPrice, uint _productId ) public onlyShopOwner priceNotZero(_productPrice) {
        marketProduct storage newProduct = marketProducts[_productId];
        newProduct.productName = _productName;
        newProduct.productPrice = _productPrice; 
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




