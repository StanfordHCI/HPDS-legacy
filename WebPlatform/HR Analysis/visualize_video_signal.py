
import cv2
import numpy as np
import matplotlib.pyplot as plt
import os
import re
from tqdm import tqdm

def analyze_video(filename, foldername):
    os.system("python3 -m python_eulerian_video_magnification " + filename + " -o " + foldername)

if __name__ == "__main__":
    # foldername = "EVM_videos"

    # filename = "hrtest_orig.mp4"
    # analyze_video(filename, foldername)

    # regex = re.compile(filename[:filename.find(".")]+".*\.mp4")

    # video_filename = ""
    # for root, dirs, files in os.walk(foldername):
    #   for file in files:
    #     if regex.match(file):
    #        video_filename = foldername + "/" + file
    #        break

    avg_brightness = []
    avg_brightness_forehead = []


    capture = cv2.VideoCapture('video_example_oneminute_99bpm.mp4')
    num_frames = int(capture.get(cv2.CAP_PROP_FRAME_COUNT))

    for i in tqdm(range(num_frames)):
        ret,frame = capture.read()
        if not ret:
            break

        # Load the cascade
        face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
        # Read the input image
        # img = cv2.imread(frame)
        # Convert into grayscale
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        # print(gray)
        # Detect faces
        faces = face_cascade.detectMultiScale(gray, 1.1, 4)
        # Draw rectangle around the faces
        # for (x, y, w, h) in faces:

        # Assumptions:
        # - The user's face is the largest face detected in the frame.
        def face_area(x):
            return x[:, 2] * x[:, 3]
        if not tuple(faces):
            continue
        predicate = face_area(faces)
        biggest = np.argmax(predicate)

        (x, y, w, h) = faces[biggest]
        cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)
        cv2.rectangle(frame, (int(x+0.33*w), int(y+0.2*h)), (int(x+0.66*w), int(y+0.25*h)), (255, 0, 0), 2)

        # Visualize the video frames with superimposed location data
        # break
        # TODO
        # Now you have a frame and a bounding box. So add the average brightness within
        # that bounding box from that frame to an array.
        avg_brightness.append(np.mean(frame[x:x+w, y:y+h]))
        avg_brightness_forehead.append(np.mean(frame[int(x+0.33*w):int(x+0.66*w), int(y+0.2*h):int(y+0.25*h)]))

    plt.xlabel("Video Frame")
    plt.ylabel("Brightness of Defined Facial Region")
    plt.plot(avg_brightness, label = "Average face brightness")
    plt.plot(avg_brightness_forehead, label = "Average forehead brightness")
    plt.legend()
    plt.show()