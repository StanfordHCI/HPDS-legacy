# Contributing to Hybrid-Physical-Digital-Spaces

Thanks so much for stopping by and showing an interest in contributing! Below, you'll find a detailed description of the system to help you get up and running in no time.

Even if I (Michael) have moved on from the project by the time you are reading this, if you have any questions that I can help with, consider this an open invitation to [shoot me an email](mailto:coopermj@stanford.edu). I'm always happy to help.

## "The Bird's Eye View" - What Am I Doing?

This project is the sensing platform for the Hybrid Physical + Digital Spaces Project. This sensing platform is going to be used in two ways:

1. To power data collection for short-term (1 hr) experiments determining the impact of built environments on human wellbeing. These experiments are being done with the Catalyst Group - over Summer 2018 we worked to determine experimental protocol and to find rooms on campus which would be suitable for these experiments to take place (e.g. natural light that can be cut off, building that gives us sufficient data from building sensors, etc.).

2. To power data collection for a longer-term digital intervention pilot which we intend to pilot in Lantana later this year. The idea behind this pilot is that a digital display will be installed in Lantana (the design-themed dorm on campus), the displayed image of which varies depending on users' progress toward goals of wellbeing (these will be determined before installation, but may include increasing one's daily step count, getting sufficient sleep each night, etc.). For example, each person may have a rendered plot of a garden displayed on the screen. Flowers would grow on participants' plots as they approach their goals for the week.

I've also created [a system diagram](https://docs.google.com/presentation/d/1LOPQ9DrceVtQM-4Q3sGZyE6UcYlD4UMBH01ypuS9-ck/edit?usp=sharing) illustrating the various pieces of sensing data which this platform is (and will be) collecting.

## Two Apologies In Advance

This guide is written for someone with a rudimentary knowledge of iOS app development and Swift. If your Swift abilities significantly exceed my own, then this guide may be a bit slow for you - if this is the case, I apologize in advance.

Second, this is the first application I have written in Swift, and I was learning Swift (starting from zero) over the course of this project. If there are parts of my code which are over-documented, under-documented, or written in poor Swift style, I again apologize in advance.

## "State of the System" - A Basic Orientation

Currently, this sensing platform does two things:

1. Passively collect [HealthKit](https://developer.apple.com/healthkit/) data; relay that data to a database on AWARE (a sensing framework system).

2. Launch Qualtrics-based surveys to measure qualitative emotional (and other) states.

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

- AWARE Backend: if I am no longer working on the project, I suspect you will want to set up a new AWARE backend (since the current AWARE dashboard that is being used is registered under my name/email). To do so, set up a new AWARE Dashboard [here](http://www.awareframework.com), and copy/paste the link to your dashboard into the string returned from `getURL()` in `AppDelegate.swift`.

- Qualtrics Backend: if you wish to setup a different Qualtrics survey on the backend of ESM (Experience Sampling Method - what this periodic surveying is known as), [create a new Qualtrics survey](https://stanforduniversity.ca1.qualtrics.com/ControlPanel/), then copy/paste the url to your Qualtrics survey into the `urlString` parameter within `openSurvey()` within `ViewController.swift`.

Warning: if you update the AWARE library, it may overwrite the parameters that have been set within some of the files in your local version of the library. I recommend making a backup beforehand so you are familiar with the parameters that you have set in your copy of the library.

### Helpful Resources

- AWARE has a [Slack Channel](http://www.awareframework.com:3000) that you can use to speak with the development team. I have found them to be helpful and supportive, and this Slack channel is a great resource if you run into any difficulties with AWARE.

## "Unfinished Tales" - What Remains to Be Completed (And Misc. Unsolicited Thoughts on How to Complete These Tasks)

- [X] Read data (CO2 levels, Air Velocity, Air Temperature into Room from Ventilation System, Room Temperature) from Stanford Building Sensors.
	- Gerry Hamilton (Director, Facilities Energy Management here at Stanford) sent me [an email](https://drive.google.com/file/d/1ukx_KIGBWKWfiGk27PwvcqRQ-dvpJzpI/view?usp=sharing) containing [a sample data readout (.csv format)](https://drive.google.com/open?id=1ba-C1rVjnYvx8Fmq04Aau6OSlyy4ayrA) from the Arrillaga Alumni Center (and this data is similar to that from almost any building we would use for short-duration experiments).
	- My initial approach to this would be to investigate writing a Python script (Python's Pandas module has great functionality for creating a flexible DataFrame from a .csv file) - or something similar - to read data from the .csv building data file, then querying the AWARE backend to load that data into a new table within the AWARE SQL database. I don't see much of a need to read this data through the app.
- [ ] Modify Qualtrics ESM to read into AWARE backend.
	- I don't see a need to read this data in through the HPDS-Data app - a similar Python script to the above could be used to read in data from the Qualtrics .csv file and push it to a new table on the AWARE backend.
	- Check if there is a way to pull from Stanford Qualtrics API instead of having to download data?
- [ ] Read data (Humidity, Temperature) from Elitech GSP Temperature and Humidity Data Logger.
- [ ] Read data (EDA - Galvanic Skin Response) from Empatica Wristband.

## "The Road(s) Not Taken" - Failed Experiments I've Tried and Roadblocks I've Encountered

The biggest point of "iterative learning" (read: thinking something was working, pursuing it, only to realize that it would not, in fact, work as well as I'd hoped - or at all) that I experienced over the course of development was in the realm of setting up the ESM backend. I've compiled this list so that you may save the time that I spent setting them up, testing them, and attempting to fix errors, before moving on. Here are three things I tried before implementing the Qualtrics-based backend:

1. [Sage Bionetworks' BridgeAppSDK](https://github.com/Sage-Bionetworks/BridgeAppSDK): Apple's [ResearchKit](), which I initially had hoped to use for ESM, does not include a backend framework. Sage Bionetworks provides a backend framework to collect ResearchKit data. With this, they've created [a guide](https://developer.sagebridge.org/articles/ios_get_started.html) designed to help developers get set up with a ResearchKit app that pushes to their backend. During communication with them over the summer (when working through their guide gave me XCode errors), they informed me that their tutorial - and platform - are a bit outdated, but that they are working on a fix and updates. (So I am optimistic about using Sage Bionetworks' BridgeAppSDK in future).

2. [Designing a Sensor on the AWARE iOS Client](https://github.com/tetujin/aware-client-ios): by writing a sensor in the format of the file [SampleSensor.m](https://github.com/tetujin/AWAREFramework-iOS/blob/master/Example/AWAREFramework/SampleSensor.m) (along with its approriate header), it is possible to collect survey data from AWARE in the app, then send the data to the AWARE backend whenever the sensors are synchronized (and so the survey would collect/send data just like any other app). I attempted this, but found it beyond my abilities, at which point I began investigating other solutions (like the above and below) - but I am also optimistic that this is another option that is viable.

3. [ProgressKinvey's Kinvey-ResearchKit](https://github.com/Kinvey/kinvey-researchkit): a ResearchKit wrapper used to develop ResearchKit applications on the Kinvey Platform. When I worked through their [Getting Started Guide](https://devcenter.kinvey.com/ios/guides/getting-started), I found loads of syntax errors in their library: a friend who is familiar with Swift and iOS app development took a look and pointed out that the wrapper is almost certainly quite outdated. I have not heard back from the team after contacting them about this, nor have I heard anything about plans to update. It's worth keeping an eye on this one, but I'm less optimistic about its ability to meet our needs.

## What Comes Next?

Hopefully, after reading through this document, you're all set to dive in! Wishing you all the best of luck - and remember, if there's something I haven't covered that you feel is crucial to know, I'm at most [an email away](mailto:coopermj@stanford.edu).
