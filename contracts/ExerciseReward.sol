// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExerciseReward {
    mapping(address => uint256) public balances;
    
    struct Exercise {
        uint256 steps;
        uint256 calories;
        uint256 timestamp;

    }
    
    mapping(address => Exercise[]) public exerciseRecords;
    uint256 public totalSupply;
    string public name = "ExerciseToken";
    string public symbol = "EXT";
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event ExerciseRecorded(address indexed user, uint256 steps, uint256 calories, uint256 timestamp);
    
    function transfer(address to, uint256 value) public returns (bool) {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function recordExercise(uint256 steps, uint256 calories) public {
        uint256 timestamp = block.timestamp;
        exerciseRecords[msg.sender].push(Exercise(steps, calories, timestamp));
        uint256 reward = calculateReward(steps, calories);
        balances[msg.sender] += reward;
        totalSupply += reward;
        emit ExerciseRecorded(msg.sender, steps, calories, timestamp);
    }
    
    function calculateReward(uint256 steps, uint256 calories) internal pure returns (uint256) {
        return (steps + calories) / 100;
    }
    
    function getExerciseRecords(address user) public view returns (Exercise[] memory) {
        return exerciseRecords[user];
    }
}
