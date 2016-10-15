---
layout: post
title: Slick jekyll themes + Github Pages
description: "Quick Start: How to setup Github Pages using Jeckyll."
modified: 2014-01-28
tags: [github.io, github, Github Pages, tutorials, Jekyll Themes]
image: imac_and_coffee.jpg
comments: true
share: true
---

Cool, so you have your custom URL pointing to your github.io page. But it still looks like this.:

![Out of box Jekyll]({{ site.url }}/images/StandardJekyll.png)

### How can we fix that?

Well for ~~lazy~~ clever people like you and me we have our google fu to find themes like [these](http://jekyllthemes.org/). There are many more though so make sure to go explore! Don't want all of our blogs to look the same after all.

If we're starting from scratch we can just fork the repo from the source and then rename the repo to the standard _username_.github.io

Let's say we want to use [this](http://jekyllthemes.org/themes/herringcove-theme/) theme.

You'll go to the "Home Page" and fork the repo

Now rename the repo to your _username_.github.io . To do this just go to the repo settings and replace "herring-cove" with "_username_.github.io"

{% highlight bash %}
  ~ $ git clone username.github.io
  ~ $ cd username.github.io
  ~/username.github.io
{% endhighlight %}

Now open up this file and clear out anything you don't want. Be sure to also recreate your `CNAME` file if you're using a custom URL. This is covered in my previous post in step three.

Important things to change are removing any default most. I suggest moving them somewhere else to save as templates for later. Possibly in an `_.drafts` folder int he root of your _username_.github.io repo.

Some important things to note are editing your `_config.yml` file so that the url is pointing at your github.io page or custom url.

{% highlight YAML %}
title:            Harley Kwyn Hacking
description:      Hacking ALL the things
url:              http://harleykwyn.com
{% endhighlight %}

Once you have that basic configuration done then you can edit whatever else you like in the repo and push it to your github page.
Another helpful thing to know is that you can test if your edits will build using you can run jekyll from the local repo file using the following comand:

{% highlight bash %}
~/username.github.io jekyll build
{% endhighlight %}

And then you check how it looks on the `localhost:4000` post if you change the url to look like this:

{% highlight YAML %}
title:            Harley Kwyn Hacking
description:      Hacking ALL the things
url:              localhost:4000
{% endhighlight %}

and then run this command in your local repo

{% highlight bash %}
~/username.github.io jekyll serve
{% endhighlight %}

Then point your browser at `localhost:4000` and you can tinker with it. More on different Jekyll server modes can be found in the [Jekyll documentation](http://jekyllrb.com/docs/usage/)

Alright! go have fun and build some slick looking sites.

### References

[Jekyll themes](http://jekyllthemes.org/themes/herringcove-theme/)

[Jekyll](http://jekyllrb.com/)
