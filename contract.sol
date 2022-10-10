pragma solidity ^0.8.17;

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        Zombie memory zombie = Zombie(_name, _dna);
        zombies.push(zombie);
        uint id = zombies.length - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(bytes32 _name) public {
        string memory name = string(abi.encodePacked(_name));
        uint randDna = _generateRandomDna(name);
        _createZombie(name, randDna); 
    }
}