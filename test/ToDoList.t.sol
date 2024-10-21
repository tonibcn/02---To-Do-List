// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ToDoList} from "../src/ToDoList.sol";
import {Test} from "forge-std/Test.sol";

contract ToDoListTest is Test {
    ToDoList toDoList;

    string newTaskDescription = "Task 1";

    function setUp() external {
        toDoList = new ToDoList();
    }

    function test_AddTask() external {
        // Act and Assert for Event
        vm.expectEmit(true, true, true, true);
        emit ToDoList.TaskAdded(1, newTaskDescription);

        toDoList.addTask(newTaskDescription);

        // Assert task details
        (string memory taskDescription, bool isCompleted) = toDoList.getTask(1);
        assertEq(taskDescription, newTaskDescription);
        assertFalse(isCompleted);

        uint256[] memory taskIds = toDoList.getTaskIds();
        assertEq(taskIds.length, 1);
        assertEq(taskIds[0], 1);
    }

    function test_CompleteTask() external {
        // Arrange
        toDoList.addTask(newTaskDescription);

        // Act and Assert for Event
        vm.expectEmit(true, true, true, true);
        emit ToDoList.TaskCompleted(1);

        toDoList.completeTask(1);

        // Assert task completion
        (, bool isCompleted) = toDoList.getTask(1);
        assertTrue(isCompleted);
    }

    function test_CompleteTask_RevertWhen_TaskNotExists() external {
        // Act and Assert revert when task does not exist
        vm.expectRevert(
            abi.encodeWithSelector(ToDoList.TaskNotExists.selector, 1)
        );
        toDoList.completeTask(1);
    }

    function test_RemoveTask() external {
        // Arrange
        toDoList.addTask(newTaskDescription);

        // Act and Assert for Event
        vm.expectEmit(true, true, true, true);
        emit ToDoList.TaskRemoved(1);

        toDoList.removeTask(1);

        // Assert task removal
        uint256[] memory taskIds = toDoList.getTaskIds();
        assertEq(taskIds.length, 0);
    }

    function test_RemoveTask_RevertWhen_TaskNotExists() external {
        // Act and Assert revert when task does not exist
        vm.expectRevert(
            abi.encodeWithSelector(ToDoList.TaskNotExists.selector, 1)
        );
        toDoList.removeTask(1);
    }

    function test_GetTask() external {
        // Act and Assert revert when task does not exist
        toDoList.addTask(newTaskDescription);
        (string memory taskDescription, bool isCompleted) = toDoList.getTask(1);
        assertEq(taskDescription, newTaskDescription);
        assertFalse(isCompleted);
    }

    function test_GetTask_RevertWhen_TaskNotExists() external {
        // Act and Assert revert when task does not exist
        vm.expectRevert(
            abi.encodeWithSelector(ToDoList.TaskNotExists.selector, 1)
        );
        toDoList.getTask(1);
    }

    function test_GetTaskIds() external {
        uint256[] memory taskIds = toDoList.getTaskIds();
        assertEq(taskIds.length, 0);
    }
}
