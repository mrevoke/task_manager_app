

# Task Manager App

This Flutter project is a task manager app that allows users to manage their tasks efficiently. The app provides features such as user authentication, task management, pagination, state management, local storage, and unit tests.

## Overview

The Task Manager App is built using Flutter, a cross-platform framework for building mobile applications. It utilizes various Flutter packages and follows best practices to ensure a clean and intuitive user interface, robust state management, seamless performance, and proper data persistence.

## Key Features

### 1. User Authentication

The app implements user authentication using the provided [DummyJSON Auth Endpoint](https://dummyjson.com/docs/auth). Users can securely log in with their username and password.

### 2. Task Management

Users can perform CRUD operations on tasks, including viewing, adding, editing, and deleting tasks. Task data is managed using the [DummyJSON Todos Endpoint](https://dummyjson.com/docs/todos).

### 3. Pagination

Pagination is implemented to efficiently fetch a large number of tasks. The app utilizes the [DummyJSON Pagination Endpoint](https://dummyjson.com/todos?limit=10&skip=10) for pagination.

### 4. State Management

State management is implemented using the Bloc Architecture. The app efficiently manages state updates across different screens and components, adhering to Flutter best practices and coding standards.

### 5. Local Storage

Tasks are persisted locally using Flutter's shared preferences. This ensures that tasks remain accessible even when the app is closed and reopened, with proper handling of local storage for data persistence.

### 6. Unit Tests

Unit testing in my application meticulously verifies the seamless authentication process, ensuring a flawless user experience and bolstering overall security measures. Quality and coverage are ensured through comprehensive testing, adhering to best practices for unit testing.

# ScreenShots

![Login Screen](assets/images/Login.png)

![List View](assets/images/listview.png)

![Add Task](assets/images/addtask.png)

![Expanded View](assets/images/expanded.png)

![Update Task](assets/images/updatetask.png)
