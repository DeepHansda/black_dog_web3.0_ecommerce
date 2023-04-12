//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

error BlackDog_NotEnoughMoney(string id, string name, uint256 price);
error BlackDog_OutOfStock(string id, string name, uint256 price, uint256 stock);

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

    event Buy(
        string id,
        string name,
        uint256 cost,
        uint256 time,
        address buyer
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

    function buyProduct(string memory _id) public payable {
        Product memory product = s_products[_id];
        address sender = msg.sender;
        if (product.cost >= msg.value || msg.value == 0) {
            revert BlackDog_NotEnoughMoney(
                product.id,
                product.name,
                product.cost
            );
        }
        if (product.stock == 0) {
            revert BlackDog_OutOfStock(
                product.id,
                product.name,
                product.cost,
                product.stock
            );
        }
        Order memory order = Order(product, block.timestamp);
        s_orderCount[sender] = s_orderCount[sender] + 1;
        s_orders[sender][s_orderCount[sender]] = order;
        s_products[_id].stock = product.stock - 1;

        emit Buy(product.id, product.name, product.cost, order.time, sender);
    }
}
