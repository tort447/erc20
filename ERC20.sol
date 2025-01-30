// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20("ER20C", "ERC"), Ownable(address(this)) {

    uint256 public immutable maxSupply;

    constructor(uint256 _initialSupply, uint256 _maxSupply) {
        require(_initialSupply <= _maxSupply, "Initial supply exceeds max supply");
        maxSupply = _maxSupply;
        _mint(msg.sender, _initialSupply);
    }

    // Функція для випуску нових токенів (доступна тільки власнику)
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= maxSupply, "Exceeds max supply");
        _mint(to, amount);
    }

    // Функція для спалювання токенів
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
}
