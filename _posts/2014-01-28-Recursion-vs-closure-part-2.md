---
layout: post
title: Recursion Functional vs Closure Part II
description: "To understand recursion you must first understand recursion"
modified: 2014-01-28
tags: [recursion, algorithms, optimization, perfJS, JavaScript]
image: the-golden-ratio.jpg
comments: true
share: true
---
## Background

To continue our discussion from my [previous post](http://harleykwyn.com/Recursion-closure-and-iteration/) I've decided to run another head ot head test with a functional recursive implementation and a closure scope recursive implementation.

A quick review of the differences between implementations

1. [Recursion](http://en.wikipedia.org/wiki/Recursion) with a [closure variable](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Closures) to keep track of answers
2. [Functional recursion](http://en.wikipedia.org/wiki/Recursion#Functional_recursion) which passes in all variables with each recursive call.
3. Iteration which uses a while loop to iterate over all of the possibilities. We'll leave this one out of the fight for now.

## Implementations

Ideally both of the following implementations should be executed in 0(n) time. This is mainly to test V8's (chrome's javascript engine) handling of functional recursion and closure scope recursion.

Each of these implementations references a javascript object with keys for all of the numbers and their associated letters.

{% highlight javascript %}
var phoneDigitsToLetters = {
  0: '0',
  1: '1',
  2: 'ABC',
  3: 'DEF',
  4: 'GHI',
  5: 'JKL',
  6: 'MNO',
  7: 'PQRS',
  8: 'TUV',
  9: 'WXYZ'
};
{% endhighlight %}

### Functional Recursion

{% highlight javascript %}
var telephoneWordsFunctional = function(digitString, word, possibleWords) {
  possibleWords = possibleWords || [];
  if(digitString.length === 0){
    possibleWords.push(word);
    return;
  }
  word = word || '';
  var letters = phoneDigitsToLetters[digitString[0]];
  digitString = digitString.substring(1);
  for(var i = 0; i < letters.length ; i ++){
    telephoneWordsFunctional(digitString, word + letters[i], possibleWords);
  }
  return possibleWords;
};
{% endhighlight %}

###Closure Recursion

The key difference here is the subroutine we're wrapping into line 3. This places the possibleWords array outside the scope of the subroutine function which behaves much like the functional recursive implementation above.

This allows the v8 javascript engine to clean up the function calls after they're finished instead of leaving them open. Scopes in Javascript will not close until they are no longer referenced and if we have to continually pass all of our arguments along, v8 will have to keep all of those instances open. [This](https://medium.com/p/8eee8afb41df) blog post explains this well and how to address this if you want to continue to use functional programming.

{% highlight javascript %}
var telephoneWordsClosure = function(digitString){
  var possibleWords = [];
  var subroutine = function(digitString, word, index){
    if(index === digitString.length){
      possibleWords.push(word);
      return;
    }
    var newWord;
    var letters = phoneDigitsToLetters[digitString[index]]
    for (var i = 0 ; i < letters.length ; i ++){
      newWord = word + letters[i];
      subroutine(digitString, newWord, index + 1 );
    }
  };
  subroutine(digitString, '', 0);
  return possibleWords;
};
{% endhighlight %}

## PerfJS test results

![jsPerf Table]({{ this.site }}/images/jsPerfTable.png)

![jsPerf Bar Chart]({{ this.site }}/images/jsPerfBarChart.png)

On my computer using chrome the results of the [perfJS spec](http://jsperf.com/permute-telephone-letters) I created show that once again the recursive solution is the most optimal. Closure recursion is approximately as the same difference as last time.

I encourage you to run [my perfJS](http://jsperf.com/tree-map-kwyn) on your own computer and in different browsers and report back to me what you find!
