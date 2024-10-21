## To-Do List Contract

### Objective

Create a Solidity smart contract that allows users to manage a to-do list. Users can add tasks, mark tasks as completed, remove tasks, and retrieve task details.

## Additional Information

- **Task Struct**: The `Task` struct holds details about each task, including its ID, description, and whether it is completed.

- **Item Listing**: The `addTask` function allows users to add new tasks by specifying the task description. It increments the `nextTaskId`, creates a new `Task` in the `tasks` mapping, and emits a `TaskAdded` event.

- **Task Completion**: The `completeTask` function allows users to mark a task as completed. It verifies that the task exists using the `_ensureTaskExists` function and updates the `isCompleted` status of the task. It then emits a `TaskCompleted` event.

- **Task Removal**: The `removeTask` function enables users to remove a task. It ensures the task exists, deletes it from the `tasks` mapping, and removes its ID from the `taskIds` array. It then emits a `TaskRemoved` event. This function can only be used if the task is completed, if not it reverts with a `TaskMustToBeCompleted` error.

