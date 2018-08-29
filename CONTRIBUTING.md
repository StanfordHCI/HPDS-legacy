# CONTRIBUTING to Hybrid-Physical-Digital-Spaces

Thanks so much for stopping by and showing an interest in contributing! Below, you'll find a detailed description of the system to help you get up and running in no time.

Even if I (Michael) have moved on from the project by the time you are reading this, if you have any questions that I can help with, consider this an open invitation to [shoot me an email](mailto:coopermj@stanford.edu). I'm always happy to help.

## Two Apologies In Advance

This guide is written for someone with a rudimentary knowledge of iOS app development and Swift. If your Swift abilities significantly exceed my own, then this guide may be a bit slow for you - if this is the case, I apologize in advance.

Second, this is the first application I have written in Swift, and I was learning Swift (starting from zero) over the course of this project. If there are parts of my code which are over-documented, under-documented, or written in poor Swift style, I again apologize in advance.

## "State of the System" - A Basic Orientation

Currently, this sensing platform does two things:

(1) Passively collect HealthKit data; relay that data to a database on AWARE (a sensing framework system).

(2) Launch Qualtrics-based surveys to measure qualitative emotional (and other) states.

### Basic Requirements

This project has been built with XCode 9.4.1, and Swift 4.1 - if you have not yet updated to that version, [download the latest XCode](https://developer.apple.com/xcode/downloads/) to ensure your XCode version is compatible with that of this project.

### Important Files

To open the project for development, navigate into the `HPDS-Data` folder and open `HPDS-Data.xcworkspace` (note - it is important that you open the `.xcworkspace` file and _not_ the `.xcodeproj` file!). Upon launching XCode, there are two files which are of primary relevance:

- `ViewController.swift`: Provides functionality for three of the main buttons on the home screen. It includes a function to sync sensors with the AWARE database (which should be done automatically, but this feature has been added in case we want to confirm that certain data has been pushed to AWARE), a function to launch the Qualtrics-based ESM survey in Safari (within an in-app display), and a function to open the user's email client to contact the research team should the user have any questions or concerns.

- `AppDelegate.swift`: Upon application launch, the function `application` within `AppDelegate.swift` establishes a connection with the AWARE backend, initializes the AWARE sensor manager, and starts all the AWARE sensors.

### Parameters to Edit

There exist various parameters within the source code which you may choose to edit during testing/deployment. I've compiled a small collection of parameters I suspect you may want to edit, and their locations within the project:

- HealthKit sampling frequency: Located in `pods.xcodeproj` > `Pods` > `AWAREFramework` > `AWAREHealthKit.m`, in the function, `initWithAWAREStudy`.

- HealthKit data to pull: Located in `pods.xcodeproj` > `Pods` > `AWAREFramework` > `AWAREHealthKit.m`, in the functions, `charactersticDataTypesToRead`, `getDataQuantityTypes`, and `getDataCategoryTypes`. Comment and uncomment the data types based on what you are hoping to collect.

- AWARE Backend: if I am no longer working on the project, I suspect you will want to set up a new AWARE backend. To do so, set up a new AWARE Dashboard [here](http://www.awareframework.com), and copy/paste the link to your dashboard into the string returned from `getURL()` in `AppDelegate.swift`.

- Qualtrics Backend: if you wish to setup a different Qualtrics survey on the backend of ESM (Experience Sampling Method - what this periodic surveying is known as), copy/paste the url to your Qualtrics survey into the `urlString` parameter within `openSurvey()` within `ViewController.swift`.

## "Unfinished Tales" - What Remains to Be Completed (And Misc. Thoughts on How to Complete Them)







