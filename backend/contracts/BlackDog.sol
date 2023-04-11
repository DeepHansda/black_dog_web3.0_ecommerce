//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

contract BlackDog {
    struct Product {
        string id;
        string image;
        string name;
        string category;
        uint256 cost;
        uint256 stock;
        uint256 rating;
    }

    struct Order {
        Product product;
        uint256 time;
    }

    event ProductCreated(
        string id,
        string image,
        string name,
        string category,
        uint256 cost,
        uint256 stock,
        uint256 rating
    );

    mapping(string => Product) public s_products;
    mapping(address => mapping(uint256 => Order)) public s_orders;
    mapping(address => uint256) public s_orderCount;

    address public immutable i_owner = msg.sender;

    function createOrder(
        string memory _id,
        string memory _image,
        string memory _name,
        string memory _category,
        uint256 _cost,
        uint256 _stock,
        uint256 _rating
    ) public {
        Product memory product = Product(
            _id,
            _name,
            _image,
            _category,
            _cost,
            _stock,
            _rating
        );

        s_products[_id] = product;

        emit ProductCreated(
            _id,
            _image,
            _name,
            _category,
            _cost,
            _stock,
            _rating
        );
    }
}
