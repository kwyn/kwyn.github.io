---
layout: post
title: Custom domains and github pages
description: "How to setup your custom domain with your github.io page you've worked so hard on."
modified: 2014-01-26
tags: [github.io, github, Github Pages, tutorials]
image:
  feature: imac_and_coffee.jpg
comments: true
share: true
---

Github pages are awesome, and with jekyll and cool themes--like the one I'm using right now--you can make a rather polished looking blog in no time. Problem is... that ugly URL up there. _username_.github.io. Wait this is my page! Not github's...

### How can we fix that?

1. Acquire a domain name
   * I used [GoDaddy.com](http://www.godaddy.com/) but there are many [other sites](http://lifehacker.com/5683682/five-best-domain-name-registrars). I've heard of some people using NameCheap which may be a better deal now than GoDaddy
2. Configure DNS at GoDaddy.com
   1. When at GoDaddy navigate to the DNS Zone File of the domain page you want to point to your github.io page.
   2. Click Edit and add two "A (host)"" to point to 192.30.252.153 and 192.30.252.154 like the following image ![GoDaddyZoneFile1]({{ site.url }}/images/GoDaddyZoneFile1.png )
   3. set the www alias to point to your _username_.github.io like the following image ![GoDaddyZoneFile2]({{ site.url }}/images/GoDaddyZoneFile2.png )

3. Create a CNAME file in your _username_.github.io repo
   CNAME file should point to your domain name this is easily done in the root of your directory with something like
   {% highlight bash%} KwynsMacPro: HarleyKwyn.github.io kwyn$ echo "harleykwyn.com" > CNAME
   {% endhighlight %}

Then just push your changes and you're done and on your way! Happy blogging. :)

### References

[Github Pages Documentation](http://pages.github.com/)

[Jekyll](http://jekyllrb.com/)
