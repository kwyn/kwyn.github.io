---
layout: post
title: So You Want to be a Kaggle Wizard
description: "Learn ALL the things"
modified: 2014-02-27
tags: [machine learning, python, image processing]
image: blur07.jpg
comments: true
share: true
---

# Background
My group at Hack Reactor decided for a short project we would attempt to tackle a Kaggle competition. Specifically the [GalaxyZoo Kaggle competition](http://www.kaggle.com/c/galaxy-zoo-the-galaxy-challenge). A daunting challenge considering 1. we are new to machine learning. 2. some of us are new to programming and 3. we only have two weeks to work on this specific project.

Diving into researching and reading the forums we found some helpful information and actually found this [post](http://www.kaggle.com/c/galaxy-zoo-the-galaxy-challenge/forums/t/6803/beating-the-benchmark).

After much effort trying to execute the supposed 20 minute solution referenced on the GalaxyZoo Kaggle competition forums I've decided to help complete newbies get up and running with python and the appropriate libraries to execute this solution.

__If you want to cheat, you can jump down to the bottom of the page for the full code but it'd be better if you could try to follow along.__

_note: I this is designed for a Unix/MacOSX based setup_

# Overview
According to the post for beating the benchmark:

>Step 1 : for all images in train and test, resize to 50x50, and vectorize to 1-D array.
>
>Step 2: Run the RandomForestRegression from scikit-learn on the train and test set with 10 estimators.
>
>Step 3: Submit Results
>
>Step 4: You have beaten the benchmark

Problem with this is that that it assumes you know how to do all of this with a large set of data already. So I'm going to show you how to set up the environment for using Python, scikit-image and scikit-learn.  You may want to check out the [scikit-image]() and [scikit-learn](http://scikit-learn.org/stable/documentation.html) documentation.



## Snake Charming (Installing Anaconda)

[Anaconda](https://store.continuum.io/cshop/anaconda/) is an awesome python package that contains all of the awesome tools we'll be using and many others. It's simpler to run the graphic installer provided by Anaconda and following their instillations instruction rather than writing out all the install commands for every dependency. Be sure to install it for your current user.

You should now be able to run the command `spyder` to open up a python editor.

# Step 1.

## Create a python file

Get started by creating an empty python file named `MyFirstForest.py` and open it up in your favorite editor. If you don't have one I suggest spyder as mentioned previously or [Sublime Text 2](http://www.sublimetext.com/).

## Getting the images

If you want to do this with the Kaggle competition data you can down load it [here](http://www.kaggle.com/c/galaxy-zoo-the-galaxy-challenge/data) after you make an account and agree to the competition terms. You'll want to download all of the files and extract them into you workspace directory. Unzipping the image files can take some time.

The very first thing you'll need to do is get a hold of the images which requires the `os` module to access the file system so start by typing
{% highlight python %}
import os
{% endhighlight %}
at the top of the file. This will import the os utility that allows us to access the file system and other parts of the operating system.

Leave a bit of space and type the following code to actually loop through the `trainingImages` directory and read each of the images into a variable that we can manipulate.

You'll also need to initialize an empty list that will hold all our training features. I aptly named mine `trainingFeatures`

{% highlight python %}
#note that this path is absolute path to your training image directory
pathToTrainingImages = '/Users/kwyn/workspace/images_training_rev1/'
for root, dirs, files in os.walk(pathToTrainingImages):   
    trainingFeatures = []
    files = sorted(files)
    for f in files:
        filePath = pathToTrainingImages + f
        img = io.imread(filePath)
{% endhighlight %}

_note that the path for this command is [absolute](http://en.wikipedia.org/wiki/Path_(computing\)#Example)_

## Resize the images

Awesome, so we have our image, but we need to still resize it and we also need to flatten it into a 1D array, where every pixel's RGB value is an element in the array.

{% highlight python %}
from skimage import io
from skimage.transform import resize
{% endhighlight %}

This will import the transform.resize utility from the scikit-image library that will allow us to resize the image.

Place the following command after `img = io.imread(filePath)`

{% highlight python %}
img = resize(img, (50,50))
{% endhighlight %}

## Convert the images into a list

So first we'll need a list to store our feature lists in. An array of arrays for those of you who don't speak python. You'll pick up on it soon enough.

Then after the `img = resize(img, (50,50))` you'll want to include the following line to convert the image to a numpy array:

{% highlight python %}
arrayOfImage = list(img)
{% endhighlight %}

# Flatten the image list

This isn't a flattened array though so we need to also flatten this. With python we have handy list comprehensions that will let us do this with single line using the following code:

{% highlight python %}
flattenedArrayOfImage = [y for x in arrayOfImage for y in x]
{% endhighlight %}

and lastly append this to the an array you'll save to run the your algorithms on later with the following line of code:

We need to hoist a variable for to store each of these arrays as an array of features that we will feed into our random forest.

So right after the line
{% highlight python %}
for root, dirs, files in os.walk(pathToTrainingImages):
{% endhighlight %}
You'll include this line of code:
{% highlight python %}
trainingFeatures = []
{% endhighlight %}

## Convert list to a numpy array

scikit-learn methods use the numpy library so we can't feed it a list we must first convert the tuple list we have just created into a numpy array. To do that we need to have import the numpy feature and alias it to something pretty like `np`. You want to do that by including the that with the following line after the the imports :

{% highlight python %}
import numpy as np
{% endhighlight %}

and then make sure you write the next line of code out of the loop, to do this you have to make sure that you are not indented at all as python is white space sensitive and then include the following line to convert the list to a numpy array:

{% highlight python %}
trainingFeature = np.array(trainingFeatures)
{% endhighlight %}

You should have something that looks like this:

{% highlight python %}
import os
import csv
from skimage import io
from skimage import color
from skimage.transform import resize
import numpy as np

print "opening training images"

pathToTrainingImages = '/Users/kwyn/workspace/images_training_rev1/'
for root, dirs, files in os.walk(pathToTrainingImages):   
    trainingFeatures = []
    files = sorted(files)
    for f in files:
        filePath = pathToTrainingImages + f
        img = io.imread(filePath)
        img = resize(img, (50,50))
        img = color.colorconv.rgb2grey(img)
        arrayOfImage = list(img)
        flattenedArrayOfImage = [y for x in arrayOfImage for y in x]
        trainingFeatures.append(flattenedArrayOfImage)

trainingFeatures = np.array(trainingFeatures)
{% endhighlight %}

You'll have to repeat this code for the testing data. Just adjust the path name and the variable names for the `trainingFeatures` list to something like `testingFeatures`

We're about half way there, keep going!

# Step 2.

## Load the training data

The training data is given to us in a `.csv` format. We can use a numpy module that to read the data directly into a numpy array with `np.loadtxt` which you can read up on in the numpy documentation for [loadtxt](http://docs.scipy.org/doc/numpy/reference/generated/numpy.loadtxt.html)

This following code will load the csv data into a numpy array:
{% highlight python %}
pathToTrainingData = "/Users/kwyn/workspace/training_solutions_rev1.csv"
with open(pathToTrainingData) as f:
    numColumns = len(f.readline().split(','))
trainingSolutions = np.loadtxt(pathToTrainingData, delimiter=',', skiprows=1, usecols=range(1,numColumns))
{% endhighlight %}

We aren't interested in the header of the data being included in our numpy array so we remove that and we also exclude the the first columns with the galaxy IDs.

## Train the algorithm

Time for the exciting part! Using scikit-learn to train a random forest on the data. We'll first need to include the scikit-learn module for random forest regressors. You can do that by including the following with your import commands at the top of the file.

{% highlight python %}
from sklearn.ensemble import RandomForestRegressor
{% endhighlight %}

If your interested in delving into what all the parameters mean you can check the [sckit-learn documentation](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html)

Then after all the previous code we will append the following code to actually train our algorithm.

{% highlight python %}
rfr = RandomForestRegressor(n_estimators=10, max_depth=9, max_features=30, n_jobs=-1)
rfr.fit(trainingFeatures, trainingSolutions)
{% endhighlight %}

Once this successfully runs then you'll have a trained algorithm!

## Saving your algorithm with joblib

One more module that you will most likely want to exploit is called `joblib` it allows us to directly save python objects and use them later after the script has finished running. In a later post I'll explain the difference between using this and pickling that is frequently used in python code. You can read more about the module [here](http://pythonhosted.org//joblib/)

{% highlight python %}
from sklearn.externals import joblib
{% endhighlight %}

Then right after the lines that train your algorithm write the following code setting the path to a file you wish to save your algorithm in I chose `Algorithms` for mine

{% highlight python %}
algorithmName = "myFirstForest"
joblib.dump(rfr, 'Algorthims')
{% endhighlight %}

As you iterate over different parameters and changing features in the future you'll probably change the name in  of the `algorithmName` variable.

_Be sure to create this the Algorithms folder before running the python script_

# Running the produced algorithm on the test data

This part is also easy. Just make sure to use joblib to save your prediction somewhere just in case writing to CSV doesn't go as planned.

Include the following code:

{% highlight python %}
prediction = rfr.predict(testingFeatures)
joblib.dump(prediction, 'Solutions/firstPrediction')
{% endhighlight %}

# Step 3.
## Formatting the prediction data for submission
The Kaggle competition expects the csv to be exported in a specific format so so that the tester they have can read the file correctly and perform the error calculations. For this we use numpy's `.savetxt` method. If you want to know more about how this works you can read up on numpys documentation for [savetxt](http://docs.scipy.org/doc/numpy/reference/generated/numpy.savetxt.html)

For now just copy this code after your predictions have been made
{% highlight python %}
galaxyIDs = galaxyIDs.astype(int)
prediction = np.column_stack((galaxyIDs, prediction))
headerRow = 'GalaxyID,Class1.1,Class1.2,Class1.3,Class2.1,Class2.2,Class3.1,Class3.2,Class4.1,Class4.2,Class5.1,Class5.2,Class5.3,Class5.4,Class6.1,Class6.2,Class7.1,Class7.2,Class7.3,Class8.1,Class8.2,Class8.3,Class8.4,Class8.5,Class8.6,Class8.7,Class9.1,Class9.2,Class9.3,Class10.1,Class10.2,Class10.3,Class11.1,Class11.2,Class11.3,Class11.4,Class11.5,Class11.6'
formatting = '%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f'
np.savetxt('Predictions/firstPrediction.csv', prediction, fmt=formatting, delimiter=',', newline='\n', header=headerRow, footer='', comments='')

{% endhighlight %}

Submit the output file in the Solutions folder to the competition.
# Step 4.
## Ta'da you've beaten the bench mark

Hope this has helped those of you new to python and machine learning. If you're clever you'll start experimenting with the scikit-learn morphology library and tweaking features.

# Complete Code

Your code should look something like this:

{% highlight python %}
import os
import numpy as np
from skimage import io
from skimage import color
from skimage.transform import resize
from sklearn.externals import joblib
from sklearn.ensemble import RandomForestRegressor

print "Opening training images"

pathToTrainingImages = '/Users/kwyn/workspace/images_training_rev1/'
for root, dirs, files in os.walk(pathToTrainingImages):   
    trainingFeatures = []
    files = sorted(files)
    for f in files:
        filePath = pathToTrainingImages + f
        img = io.imread(filePath)
        img = resize(img, (50,50))
        img = color.colorconv.rgb2grey(img)
        arrayOfImage = list(img)
        flattenedArrayOfImage = [y for x in arrayOfImage for y in x]
        trainingFeatures.append(flattenedArrayOfImage)

trainingFeatures = np.array(trainingFeatures)

print trainingFeatures

print "Finished converting training images to numpy arrays"
print "Opening test images"

pathToTestingImages = "/Users/kwyn/workspace/images_test_rev1/"
for root, dirs, files in os.walk(pathToTestingImages):
    testingFeatures=[]
    galaxyIDs = []
    files = sorted(files)
    for f in files:
        filePath = pathToTestingImages + f
        galaxyIDs.append(f[:-4])
        print(galaxyIDs)
        img = io.imread(filePath)
        img = resize(img, (50,50))
        img = color.colorconv.rgb2grey(img)
        arrayOfImage = list(img)
        flattenedArrayOfImage = [y for x in arrayOfImage for y in x]
        testingFeatures.append(flattenedArrayOfImage)

testingFeatures = np.array(testingFeatures)
galaxyIDs = np.array(galaxyIDs)

print "Finished converting test images to numpy array."
print "Opening training data..."

pathToTrainingData = "/Users/kwyn/workspace/training_solutions_rev1.csv"
with open(pathToTrainingData) as f:
    numColumns = len(f.readline().split(','))
trainingSolutions = np.loadtxt(pathToTrainingData, delimiter=',', skiprows=1, usecols=range(1,numColumns))

print trainingSolutions[0]

print "Finished loading training data"  
print "starting random forest training"

rfr = RandomForestRegressor(n_estimators=10, max_depth=9, max_features=30, n_jobs=-1, oob_score="true")
rfr.fit(trainingFeatures, trainingSolutions)

print "Finished random forest training"
print "Saving algorithm"

algorithmName = "myFirstForest"
joblib.dump(rfr, 'Algorthims/'+algorithmName )

print "starting testing..."

prediction = rfr.predict(testingFeatures)
joblib.dump(prediction, 'Solutions/firstPrediction')

print "finished testing"
print "writing predictions to csv"

galaxyIDs = galaxyIDs.astype(int)
prediction = np.column_stack((galaxyIDs, prediction))
headerRow = 'GalaxyID,Class1.1,Class1.2,Class1.3,Class2.1,Class2.2,Class3.1,Class3.2,Class4.1,Class4.2,Class5.1,Class5.2,Class5.3,Class5.4,Class6.1,Class6.2,Class7.1,Class7.2,Class7.3,Class8.1,Class8.2,Class8.3,Class8.4,Class8.5,Class8.6,Class8.7,Class9.1,Class9.2,Class9.3,Class10.1,Class10.2,Class10.3,Class11.1,Class11.2,Class11.3,Class11.4,Class11.5,Class11.6'
formatting = '%d,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f'
np.savetxt('Predictions/firstPrediction.csv', prediction, fmt=formatting, delimiter=',', newline='\n', header=headerRow, footer='', comments='')

print "finished you can find you predictions in Predictions folder"
{% endhighlight %}
