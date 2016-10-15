---
layout: post
title: Google Comments in Jekyll
description: "Start a discussion using google comments."
modified: 2014-01-28
tags: [github.io, github, Github Pages, tutorials, Google, comments]
image: keyboard_watch.jpg
comments: true
share: true
---
Last post in this unofficial blog posts about blogging series.

Without a discussion about what you're posting your blog isn't very valueble. Disque can be easy to use but if you're like me you beleive in google+ and would love to have that as the commenting platform for your blog.

Let's jump into how to get this installed.

# Installation

Be sure that you have jQuery and the google platforms link included in the scripts at the beginning of your post layout.

typically found under your `_includes` file `scripts.html` and should look kind of like this:
{% highlight HTML %}
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
{% endhighlight %}

Find where you want your comments to appear in your site's HTML. Preferably the comments will be post specific so it's most likely to be found in `_layout` in something that look like `post.html` and in a wrapper, quite possibly a `<footer></footer>` tab

Copy this div into that container
{% highlight HTML %}
<div id="comments"></div>
<script>
  gapi.comments.render('comments', {
      href: window.location,
      width: '624',
      first_party_property: 'BLOGGER',
      view_type: 'FILTERED_POSTMOD'
  });
</script>
{% endhighlight%}

# Setting up Google Authorship

So for this script to work, Google needs to be sure you're associated with this page. To do this we need to setup Google Authorship.

This can be done by navigating to your Google+ profile.

At the top right of the page you'll see your face! (or a default icon) click on that and then click on `Account`

![Google+ Account]({{ site.url }}/images/GooglePlusAccount.png)

Then on the left you'll click `Edit Profile`

![Google+ Edit Profile]({{ site.url }}/images/GooglePlusEdit.png)

Now scroll all the way down to the links section and click edit

![Google+ Links]({{ site.url }}/images/GooglePlusLinks.png)

Then scroll down to to `Contributor to` section and `add a custom link` that points to your main domain name or _username_.github.io

![Google+ Links add URL]({{ site.url }}/images/GooglePlusURL.png)

Great now you're the author of your blog. Not that you weren't before, but now you're ordained by the all might Google.

# Linking your Google account to your page

So one last step add a link to your Google+ profile to your page. Using the following code. the `href` should be your profile URL + `?rel=author` otherwise Google will not _relate_ your authorship to the page.

{% highlight HTML %}
<a href="https://plus.google.com/+YourProfileName?
   rel=author">Google</a>
{% endhighlight %}

You'll notice my name in the footer next to the copy write symbol, I went ahead and sneakily put it there in the `footer.html` template. Like so:

{% highlight HTML %}
  <a href="https://plus.google.com/+KwynMeagher?rel=author"> {{ site.owner.name }} </a>.
{% endhighlight %}

Now get commenting!
