pragma solidity ^0.4.8;

contract TXRegister{
    mapping (uint => bytes32) public transactions;

    function saveTransaction(uint _counter, bytes32 _txHash) returns (bool confirmation){
        transactions[_counter] = _txHash;
        return true;
    }

    function getTransacion(uint _counter) constant returns (bytes32 txHash){
        return (transactions[_counter]);
    }
}