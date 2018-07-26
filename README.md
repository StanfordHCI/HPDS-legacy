# Hybrid-Physical-Digital-Spaces
Repo for HPDS, "The Building Project," supervised by James Landay and Liz Murnane.

## Getting Started
Welcome to the project! Thank you for stopping by.

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites
This project requires XCode 9.4.1. All other frameworks/pods are included within the repository.

### Installation
Navigate into the directory on your computer where you would like to place the project folder. Then type the following command to download the project.

```
$ git clone https://github.com/StanfordHCI/Hybrid-Physical-Digital-Spaces.git
```

Navigate into the newly-created directory, then into HPDS-Data. Open up the file with the .xcworkspace extension (not the .xcproject) in XCode. From here, you can make various edits, add features, have a party, etc.

To commit changes to the repo, save all of your changes locally, then navigate into the project folder from your terminal. Then, type the following commands:

```
$ git add .
$ git commit -m “[message]”
```

Where “message” (inside quotes but no need for the square brackets), is a brief description of the changes you have made since  last committing to the repo. Next, type,

```
$ git push origin master
```

And this should update the repository to the version running locally on your machine. :)

The rule of thumb with which I am familiar is to commit “whenever something works”. This means you probably shouldn't quite commit as often as you save, but once progress has been made (even small progress), don’t be hesitant to commit your changes.

When starting work on a project each day, you should confirm that you are working on the latest version of the codebase. To do so, navigate to the project folder in your terminal, then type,

```
$ git pull
```

This will ensure your local copy of the code is up to date with the latest version in the codebase.

### Orientation

Below, please find descriptions of some of the key files in the project:

* ```AppDelegate.swift```: Contains the code necessary to get the sensors up and running, and sending data to the AWARE server.
* ```ViewController.swift```: Provides the ```syncSensors``` function (though sensors sync automatically, this enables the "Sync Sensors" button you will find on the home screen), openEmail function (which enables the user to contact the researchers running the study), and the researchKitSurvey function (which starts a survey through ResearchKit).

## Deployment
To deploy this project to an iOS simulator or to a live device:

1. Follow the instructions at [this tutorial](http://www.awareframework.com/run-a-study-with-aware/) to set up an AWARE server. If you are working on HPDS, there is no need to set up a separate AWARE server; the current one should work great.

2. If you have set up a new AWARE server, because you are working on a different project, update the ```getUrl() -> String``` function in ```AppDelegate.swift``` to return the url of your new AWARE server. Additionally, update the variable ```email``` under the ```openEmail``` function in ```ViewController.swift``` to an email at which you would like users to be able to reach you.

3. Build and run the project in XCode. From XCode, you can set the simulated device on which you would like the project to run. To run on a live device, plug the device into your computer. After a few seconds, the device should become available to select from the menu in the top-left corner (to the right of the play button). Select your device, then run the project.

## Built With
[AWARE Framework iOS](https://github.com/tetujin/AWAREFramework-iOS)  
[ResearchKit](https://github.com/ResearchKit/ResearchKit)

## Contributing

## Authors

## License

## Acknowledgments
[Yuuki Nishiyama](https://github.com/tetujin) for his work on the AWARE Framework iOS, and for his AWARE Framework tutorials, which were used in the development of this application.
[jeffery_the_wind](https://stackoverflow.com/questions/36225543/how-to-use-orkeserializer-in-my-app) on StackOverFlow. His solution to serialize a ORKResult to a JSON (with ever-so-minor modifications) was used in this project. 
[Sergey Kargopolov](http://swiftdeveloperblog.com/about/) on Swift Developer Blog. His code to [convert JSON string to NSDictionary in Swift](http://swiftdeveloperblog.com/code-examples/convert-json-string-to-nsdictionary-in-swift/) was used in t his project.

## Tutorials for Reference
Here are a list of tutorials that were used over the course of this project. The hope here is that, if you are not familiar with some of the design elements of the HPDS-Data app, these resources will enable you to quickly bring yourself up to speed.

* [Using AWAREFramework-iOS (library version of AWARE iOS)](http://www.awareframework.com/creating-a-standalone-ios-application-with-awareframework-ios/)

* [Managing a Study with AWARE](http://www.awareframework.com/run-a-study-with-aware/)

* [Stanford CS193P (Tour of XCode, Introduction to Swift)](https://www.youtube.com/playlist?list=PLPA-ayBrweUz32NSgNZdl0_QISw-f12Ai)

* [ScrollView + UILabel (Scrollable Label with Auto Layout)](https://www.youtube.com/watch?v=odOLFazBBsU)

* [ResearchKit Survey Tutorial](https://www.raywenderlich.com/104575/researchkit-tutorial-with-swift)
