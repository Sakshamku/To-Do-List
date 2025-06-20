// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TodoList {
    uint public taskCount = 0;

    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => Task) public tasks;

    event TaskCreated(uint id, string content);
    event TaskCompleted(uint id, bool completed);
    event TaskDeleted(uint id);

    function createTask(string memory _content) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content);
    }

    function toggleComplete(uint _id) public {
        Task storage task = tasks[_id];
        task.completed = !task.completed;
        emit TaskCompleted(_id, task.completed);
    }

    function deleteTask(uint _id) public {
        require(_id > 0 && _id <= taskCount, "Invalid ID");
        delete tasks[_id];
        emit TaskDeleted(_id);
    }

    function getTask(uint _id) public view returns (string memory content, bool completed) {
        Task memory task = tasks[_id];
        return (task.content, task.completed);
    }
}
