README

(I'm sorry I took 5 mins uploading everything so this README is in need of some work - but hopefully it indicates what everything here is so that you aren't lost). :)

- Basic Study Platform - a basic platform to display an atmosphere behind a study task.
- Platform with Recording - experiments with using the RecordRTC JavaScript library to record the user while they are doing the task. Currently it records the video of the user during the task and plays it back (the library has capabilities to send the recording to a server but this is to-be-implemented).
- HPDS-Posenet-Python - a Python port of the PoseNet library, which is one technique we're considering using to determine if the subject is looking at the screen and paying attention to the task at hand. Nothing from this has yet been integrated.
- HR Analysis - work on analyzing heart rate from a video signal. It includes visualize_video_signal.py which is some experimental code I wrote which uses EVM (Eulerian Video Magnification) to output a graph of heart rate over time (but this doesn't work very well). Our current development direction references the iphys-toolbox (https://github.com/danmcduff/iphys-toolbox), a MATLAB repo which should work much better. Currently resolving MATLAB licensing issues on my (Michael's) end to unblock on this part of development.

If you've got any questions, please Slack me and I'll be happy to help answer.