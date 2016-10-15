---
layout: post
title: Hello World App for Chrome Devtools Extensions
description: "You can do what?"
modified: 2014-02-27
tags: [Chrome Developer Tools, Chrome Extensions, Hello World]
image: blur07.jpg
comments: true
share: true
---

# Background
I'm attempting to build a visualizer for scope and variable assignment in JavaScript and I wanted to leverage the power of chrome devtools which exposes these in their source panel.

The awesome thing about the chrome developer console is that it is written in JavaScript HTML and CSS, so you can build a web app inside of it.

If you've never build a chrome extension before follow these tutorials to get started.

[Chrome Extensions Overview](http://developer.chrome.com/extensions/overview)
[Chrome Extensions Example](http://developer.chrome.com/extensions/getstarted)

Once you've finished those you can start with the hello world app. Here's some more documentation that may be helpful if you get lost. [Extending Chrome Developer Tools](http://developer.chrome.com/extensions/devtools)

After going through those first few tutorials you'll have gathered by now that we at least need a `manifest.json` object.  

To create dev extension you have to have a `devtools_page` key on the `manifest.json`. It should looks something like the following:

{% highlight json %}
{
  "name": "myFirstDevExtension",
  "version": "0.0.1",
  "description": "Hello World",
  "minimum_chrome_version": "10.0",

  "devtools_page": "devtools.html",
  "manifest_version": 2
}
{% endhighlight %}

Next is simple enough. You have to define your `devtools.html` or whatever you decided to name your html file. Which for hte moment only need to contain a devtools javascript file.

{% highlight html %}
<!DOCTYPE html>
<html>
  <body>
    <script src="devtools.js"></script>
  </body>
</html>
{% endhighlight %}

{% highlight javascript %}
chrome.devtools.panels.create("My Panel",
    "Panel.html",
    function(panel) {
      // code invoked on panel creation
    }
);
{% endhighlight %}

To get a panel up and running with some html all you need to do is create a `Panel.html` file and include whatever you like in it now. You could put cat gifs int here if you'd really like but you should also now have access ot all of your tools through communications between `Panel.html` , `devtools.js` , and `dectools.html`.

For now we can just put a loud and proud `<h1>` tag in there.

{% highlight html %}
<h1>Hello World</h1>
{% endhighlight %}



You can theoretically run an entire angular app within this window. In later posts I may delve more into this and how to use the special devtools available to us within these confines.
