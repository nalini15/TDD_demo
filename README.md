# TDD with clean architecture 

Test-driven development (TDD) example with Clean Architecture using Mockito framwork

## Getting Started
Testing code scenarios will be written first before creating a feature in the application.
Mockito is a popular mocking framework for unit testing used in Flutter to test the logic of your app.
It allows you to create mock objects that simulate the behavior of real objects, which can be useful in testing scenarios where real objects are not available or are difficult to obtain.

### Step 1
Write testing scenarios (Red)

### Step 2
Make the testing scenarios successful (Green)

### Step 3
Refactor the code

#### Writing code on the domain layer
The first step is to write code at the domain layer. Why the domain layer? because this layer is a layer that does not depend on any other layer. So it will be safer if you start from this layer. In domain layer includes Entity,repository and usecases

#### Writing code on the data layer
After working on the testing code and features at the domain layer, we can move on to working on the code at the data layer. At the data layer, there are data sources, models, and repositories.

#### Writing code on the presentation layer
After working on the domain and data layers, the final step is working on the code at the presentation layer. At this layer, there are state management and pages.



