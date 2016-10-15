---
layout: post
title: Machine Learning Work Flow for Hackers
description: "Learn ALL the things"
modified: 2014-02-27
tags: [machine learning, python, image processing]
image: mandelbrot.jpg
comments: true
share: true
---

# Background

Machine learning is a growing field of interest of high demand and tends to appear arcane to even the bravest programmers. However, a hacker can dive into programming just as much as a computer scientist. The key is in the work flow which we will outline in a high level manner in this post. I will go into how to implement the bulk of this work flow with python and Sci-kit libraries in a later post.

# The Devil's in the Details

Before we dive into the specifics of the work flow I would like to posit the idea that features are arguably the most important thing when it comes to executing machine learning as a hacker and not a PhD in computer science. We can abstract much of the intricacies of the algorithmic parts of machine learning with libraries such as [Mahout](https://mahout.apache.org/) and [Sci-kit Learn](http://scikit-learn.org/)

# Overview

1. Data Processing
2. Feature Extraction and Selection
3. Writing the algorithm (or `import sklearn`)
4. Training the algorithm
5. Applying the algorithm
6. Repeat

## 1. Data Processing

This is basically putting a label on your data. This task is often outsourced to humans on a large scale for complex image labeling tasks. With raw statistical data generated through website APIs one does not have to deal with image determination. Most of the time as a Hacker you will not be doing this part of the process but it is important to understand that this does have to happen at some point.

For playing around with images [this](http://www.image-net.org/) is a handy pre-labeled image database.

## 2. Feature Extraction and Selection

Going back to asking the right question. Features are metrics or meta data about the label you wish to classify or predict. In this case we're talking about images. There are many libraries out there for image processing and reduction of dimensionality for features. It just takes a quick Google search. Sci-kit Image is my personal favorite. This is often the most challenging but productive step in the process and frequently requires iteration and mixing combinations of features that are associated with a specific label.

Some features complement each other and some take away from each other. It's up to you to determine the secret sauce that makes for the best finished algorithm model.

## 3. Writing the algorithm

If you're ambitious you can write your own algorithms but as stated before I suggest using libraries. If you want to understand the math that goes into a lot of this stuff you can take a quick coursera course [here](https://class.coursera.org/ml-003/lecture/preview)

## 4. Training the algorithm

This is the easy part. Abstract the actual writing of the algorithm to Sci-kit learn and throw in your properly formatted data and you're up and running. It's just a matter of tweaking the parameters to find an optimal algorithm architecture and partitioning your data into training and testing. A 50/50 split between train and test is usually good. You can also run something called a [cross-validation](http://en.wikipedia.org/wiki/Cross-validation_(statistics)) test on the data with your algorithm if you want to get an idea for how accurate the algorithm is over the entire data set.

Once the algorithm is trained it will output a function called a model which you will use to predict the label or classification you trained it on.

## 5. Applying the algorithm.

To apply the algorithm model you must also extract features from the test data set in the same way that you did for the training set. Then you can run the algorithm model on the test data to predict the labels or classification of that data.

## 6. Repeat

Evaluate the difference in the accuracy of your algorithm and iterate over the previous steps tweaking the parameters of the algorithm as well as changing the combination of features or extracting new features from your data. Try to be intelligent and figure out intuitively what features should correlate highly with the specific labels you are interested in.

# Take Away

So in short what you need to worry about:

1. Formatting data
2. Extracting important features and being clever about their correlation to the label of interest
3. Installing and playing with different algorithms parameters from those libraries
4. Apply the model, evaluate benefit of each feature and iterate with the permutations of features.

Go start hacking! Machine learning shouldn't be left to the ivory tower.
