---
layout: page
title: Recursion, Closure, and Iteration
description: "To understand recursion you must first understand recursion"
modified: 2014-01-26
tags: [recursion, algorithms, optimization, perfJS, JavaScript]
image: the-golden-ratio.jpg
comments: true
share: true
---
## Background

There's been quite some discussion about recursion and iteration in our classes at Hack Reactor when dealing with toy problems.

One of the toy problems we approached was a simple tree map function and we were wondering what would be effectively faster in implementation.

For those of you who don't know what a tree map function is it is an algorithm that takes in a [tree data structure](http://en.wikipedia.org/wiki/Tree_%28data_structure%29) and [maps](http://en.wikipedia.org/wiki/Map_%28higher-order_function%29) a function to each value in that tree and returns a tree containing the new values but in the same structure as before.

To test this I'm going to implement three different methods.

1. [Recursion](http://en.wikipedia.org/wiki/Recursion) with a [closure variable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Closures) to keep track of answers
2. [Functional recursion](http://en.wikipedia.org/wiki/Recursion#Functional_recursion) which passes in all variables with each recursive call.
3. Iteration which uses a while loop to iterate over all of the trees using a stack to manipulate data for [depth-first traversal](http://en.wikipedia.org/wiki/Tree_traversal#Depth-first)

To understand the conceptual difference of all of these I'm going to draw you a scenario. Imagine a teacher wants to record all of the names of the students in the class. The teacher could go about this in many ways. Imagine that you have to iterate over all students. You could imagine the following:

1. Recursion with a closure :
    Someone standing with a notepad writing the answer of each individual down and handing it to the teacher
2. Functional recursion:
    Every student in the chain writing their answer down on a note pad and passing it to the next student and eventually passing it all the way back to the teacher
3. Iteration:
    Teacher going to each student and telling them to write their answer down on a note pad the teacher is holding.

## Implementations


Ideally all of the following implementations should be executed in O(n) time. This is mainly to test V8's (chrome's javascript engine) handling of recursion, closure scopes, and iterations.


### Functional Recursion
{% highlight javascript %}
Tree.prototype.map = function(callback){
  var newTree = new Tree(callback(this.value));
  for (var i = 0 ; i < this.children.length; i++){
    newTree.addChild( this.children[i].map(callback) );
  }
  return newTree;
};
{% endhighlight %}

### Closure Recursion
{% highlight javascript %}
Tree.prototype.closureMap = function(callback){
  var buildNode = function(callback, node, newNode){
    for(var i = 0; i < node.children.length; i++){
      newNode.addChild( callback(node.children[i].value) );
      buildNode(callback, node.children[i], newNode.children[i]);
    }
  };
  var newTree = new Tree( callback(this.value) );
  buildNode(callback, this, newTree);
  return newTree;
};
{% endhighlight %}

### Iterative
{% highlight javascript %}
Tree.prototype.iterativeMap = function (callback) {
  var newTree = new Tree(callback(this.value));
  var stack = [ [this, newTree] ];
  while(stack.length > 0){
    currentNodes = stack.pop();
    node = currentNodes[0];
    newNode = currentNodes[1];
    newNode.value = callback(node.value);
    for(var i = 0; i < node.children.length; i++){
      newNode.addChild(node.children[i].value);
      stack.push([ node.children[i], newNode.children[i] ]);
    }
  }
  return newTree;
};
{% endhighlight %}

## PerfJS test results

On my computer the results of the [perfJS spec](http://jsperf.com/tree-map-kwyn) I created show that the recursive solution is the most optimal with closure recursion coming in a close second at 16% less operations per second, and then the slowest being iterative without 18% less operations per second. This may be due to the fact that the recursion implementation has less variable declarations and calls to pop and push functions which can be quite expensive on their own. I encourage you to run [my perfJS](http://jsperf.com/tree-map-kwyn) on your own computer and in different browsers and report back to me what you find!

For larger problems recursion may run into space issues if you are not closing scope after each recursive call.
