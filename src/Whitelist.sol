// SPDX-License-Identifier: UNLICENSED 
pragma solidity ^0.8.12;

import {OwnableUpgradeable} from "@openzeppelin-upgrades/contracts/access/OwnableUpgradeable.sol";

/*
* Note: The OwnableUpgradeable contract is used to ensure that only the owner of the contract 
* can add or remove addresses from the whitelist. It must be OwnableUpgradeable instead of Ownable
* because RegistryCoordinator is OwnableUpgradeable, and it caused conflicts on onlyOwner modifier.
*/
contract Whitelist is OwnableUpgradeable {
    mapping(address => bool) whitelist;

    event AddedToWhitelist(address indexed account);
    event RemovedFromWhitelist(address indexed account);

    modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender), "Caller is not whitelisted");
        _;
    }

    function add(address _address) public onlyOwner {
        whitelist[_address] = true;
        emit AddedToWhitelist(_address);
    }

    function remove(address _address) public onlyOwner {
        whitelist[_address] = false;
        emit RemovedFromWhitelist(_address);
    }

    function isWhitelisted(address _address) public view returns(bool) {
        return whitelist[_address];
    }
}
