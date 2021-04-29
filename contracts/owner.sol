pragma solidity ^0.8.4;

contract Owned {
    
    address payable owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "Somente o dono do contrato pode validar o agendamento!");
        _;
    }
}

contract Destroy is Owned {
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}