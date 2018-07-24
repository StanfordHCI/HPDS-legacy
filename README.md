# Hybrid-Physical-Digital-Spaces
Repo for HPDS, "The Building Project," supervised by James Landay and Liz Murnane.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

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

## Built With
[AWARE Framework iOS](https://github.com/tetujin/AWAREFramework-iOS)
[ResearchKit](https://github.com/ResearchKit/ResearchKit)

## Authors

## License

## Acknowledgments
Acknowledgement to [Yuuki Nishiyama](https://github.com/tetujin) for his work on the AWARE Framework iOS.

## Tutorials for Reference
Here are a list of tutorials that were used over the course of this project. The hope here is that, if you are not familiar with some of the design elements of the HPDS-Data app, these resources will enable you to quickly bring yourself up to speed.

* [Using AWAREFramework-iOS (library version of AWARE iOS)](http://www.awareframework.com/creating-a-standalone-ios-application-with-awareframework-ios/)
* [Managing a Study with AWARE](http://www.awareframework.com/run-a-study-with-aware/)
* [Stanford CS193P (Tour of XCode, Introduction to Swift)](https://www.youtube.com/playlist?list=PLPA-ayBrweUz32NSgNZdl0_QISw-f12Ai)
* [ScrollView + UILabel (Scrollable Label with Auto Layout)](https://www.youtube.com/watch?v=odOLFazBBsU)
* [ResearchKit Survey Tutorial](https://www.raywenderlich.com/104575/researchkit-tutorial-with-swift)
