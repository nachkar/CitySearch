# CitySearch

CitySearch is an iOS application built using Swift 5 on XCode 12.0.1 for all devices running on iOS 12.0 or higher.

MVVM and coodinators architectures are used to develop "CitySearch".

The purpose of this the application is reading and filtering a list of 200k + of cities. "Operation" and "OperationQueue" are used to execute the previous tasks in order not to block the interaction with the UI. All loads are executed in background tasks with a dependency between reading the JSON file and the filtering it.

For filtering a list of 200k + list for a prefix match, an algorithm was used to search in a specific array containing ONLY the cities which the names start with the first letter of the searched text in order to prevent a high complexity algorithm and having to go through all the cities to find the required ones.

Some test cases were added for accessing the data from the JSON file and to check the accuracy of the filtering.

In order to run the application just clone the repository and run it on any simulator or device.
