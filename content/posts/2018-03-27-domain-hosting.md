---
title: Custom domain hosting with Github and Namecheap
author: Brooke Watson
date: '2018-03-27'
slug: domain-hosting
categories: []
toc: true
        toc_float: true
tags:
  - hugo
  - blogdown
  - netlify
  - namecheap
  - R
  - github
  - domain hosting
description: Cheap and cheerful hosting of a custom domain name, for people who don't know anything about TLDs.
--- 

I am a compulsive buyer of online real estate. Ever since I learned about specialty TLDs - domain extensions that expand the traditional .com, .org, and .net sites to include .limo, .diamonds, and .juegos - I will occasionally log on to [Namecheap.com](https://www.namecheap.com), fall into an internet k-hole, and emerge 30 minutes later, $13 lighter but flush with `brooke.city`, `pangolin.agency`, `medium.place`, and `mammal.party`, among others. 

I haven't done anything with most of these. In fact, most lapse without ever redirecting to anything but the Namecheap parking space, a momentary, 48 cent adrenaline rush. In all likelihood, Pangolin Agency will never become an hour-long crime procedural that follows three endangered little sandshrew detectives on a slow but steady mission to end wildlife trafficking. 

But finally, around a year ago, I made the first step, linking a Github pages repo to what is now my personal webpage, [brooke.science](http://www.brooke.science). A month ago, I added a subdomain ([blog.brooke.science](http://blog.brooke.science)) and built a much more robust site on it, complete with a new Github repo and using new tools. 

It took me an entire weekend of increasingly frustrated and cryptic Git commit messages to figure out how to point brooke-watson.github.io to my new, corny, custom domain. This shouldn't have been the case. 

Linking a website to a custom domain, if you're familiar with the online lingo, is actually only about 3 **incredibly simple** steps. But I didn't know anything about web hosting, and didn't take the time to RTFM before I started, so I assumed that everything was more complex than it needed to be. I've seen tons of great [tutorials](http://www.emilyzabor.com/tutorials/rmarkdown_websites_tutorial.html) lately that walk through building a website on Github or Netlify, often using the standard username.github.io or customname.netlify.com urls. But in many of these, I've seen little instruction on linking these to a custom domain, or even on acquiring one in the first place. 

Having recently deployed the old [blog](http://blog.brooke.science) on Netlify using a custom subdomain, I'm momentarily intimately familiar with the process. I'm writing these steps down, with screenshots, so I don't make it too complicated for myself the next time. Perhaps they will also be of use to someone else.

# Buy a domain name

I like [Namecheap](https://www.namecheap.com/) as a platform, so that's what I'll use here. I've also heard good things about [Hover](https://www.hover.com/) (and bad things about GoDaddy).  Namecheap was the cheapest I found, which is convenient if you're buying six goofy domains at a time. It also allows you to set up email addresses for a small additional cost.  

# Choose a domain setup

There are basically three ways you can set up your domain. I've listed them in increasing order of complexity, but also increasing order of long-term flexibility and stability. I'd recommend \#1 if you're not building a *new* website, \#2 if you are, and \#3 if you're building more than one. 

I know that many people in the R community host sites on Rbind.io, or use a domain host other than Namecheap, but I haven't used these, so I can't speak to that. I also know people with only one site that still use Netlify - I'm genuinely curious about why that is additionally useful, but as far as I can tell, it's not necessary for the basics.

1. **Redirect a custom domain name to an existing site.** This is the simplest method, but can get buggy if people are finding the site both through your domain and through traditional channels. It can also confuse Google Analytics and other tracking programs, so it's not super useful as a long-term solution. 

2. **Link your domain name to a standard Github pages site.** This is and what I've done for my [personal website](http://brooke.science/), and for most people, it will be enough. You can automatically set up a [Github Pages](https://pages.github.com/) site by naming a repo yourGithubname.github.io and customizing a [Jekyll](http://jekyllthemes.org/) or [Hugo](https://themes.gohugo.io/) theme within it. However, if you want to host **multiple custom** sites on Github, you'll want to use something like Netlify to deploy your site. 

3. **Link your domain name to a Github repo and deploy your website continuously via Netlify**. [Netlify](http://netlify.com) is a free service that will *watch* a Github repo with a website inside of it and update that website whenever you push changes to the master branch. This way, you can have multiple Github repos connected to multiple domain names all from within the same Github account. This is what I do for [blog.brooke.science](http://blog.brooke.science), which has its [own repo](http://github.com/brooke-watson/blog) on Github and a subdomain in Namecheap. 

# Step 0: Get to your DNS.

First things first: after you've bought 

## Option 1: Set up a redirect.

Redirecting your domain name to an existing website is the easiest way to use your domain name. You might want to do this if, for example, you bought a [novelty domain name for your pet snake](http://www.judith.press), but you don't want to build her an entire website - you just want to redirect traffic to her Instagram account.

When you go to manage the domain name, all you have to do is delete the CNAME record (from the image above) and change the redirect record to the site you want to redirect to, like so:  

![](/figs/2018-03-27-domain-hosting/one-redirect.png)

If this is all you want to do, you're done. [Judith.press](http://judith.press) now redirects to @officialkingjudy's Instagram. 

You can chose a "masked" redirect, which means that even after it redirects, you will still see "judith.press" in the browser. This is cute, but much less stable than unmasked redirects. 

I can also add redirects with different "hosts". Currently, I only have an `@` host, which means that judith.press redirects. If we want the browswer to know what to do with www.judith.press, we have to add a `www` host. 

![](/figs/2018-03-27-domain-hosting/many-redirects.png)

Redirecting is really easy, but it's not the most stable permanent solution. It's great if you want to buy a heap of domains with the mayor of New York City's name in them and redirect them to [John Oliver clips](https://www.youtube.com/watch?v=1pqe_oqDJp0), but redirects regularly get exhausted, tap out, and asks you to clear your cookies and try again. 

**If you're building your website somewhere like Github, I STRONGLY recommend that you can configure your CNAME record in Namecheap to point to the repo without redirecting.**

## Option 2: Configure your A records and CNAME record for Github

`A records` and a `CNAME record` in Namecheap offer a more permanent solution. This sounds confusing, but if you're using your-username.github.io to host your website, it literally is just 2 (+/-0.5) steps.

**Step 1**: Add a CNAME record to the top level of your github repo. This is just a file called CNAME (no extension, all caps) that has one line inside it - yourdomain.tld.

![](/figs/2018-03-27-domain-hosting/gh-cname.png)

**Step 2**: Log in to your Namecheap account Add a CNAME record in Namecheap 

![](/figs/2018-03-27-domain-hosting/cname.png)

## Option 3: Connect to Netlify 


https://help.github.com/articles/setting-up-an-apex-domain/


# Build your website.


# Jekyll vs Hugo


1. [Github](http://www.github.com). More specifically, [A Github repo](http://www.github.com/brooke-watson/brooke-watson.github.io/) with an R project (`.Rproj` file)<sup>1</sup> inside of it. This is the **production center** - where you build your website. In many cases, an entire website can live in one repository, with sub-folders for the HTML, CSS, and Javascript foundations, as well as your specific text and image file decorations. I actually use two - one for my [landing page](http://brooke.science), and one for [my blog](http://blog.brooke.science) - but you don't need to do that. 


3. [Namecheap](http://namecheap.com). Netlify gives you an automatic domain name every time you publish a website. it's usally something bonkers, like `percolated-mousetrap-234982.netlify.com`. You can change this to something simple and nice, like `brooke.netlify.com`<sup>2</sup>, but if you want to drop the `netlify.com` and just call your blog `brooke.city`, you'll need to buy a domain name. 

# Step 1: Update (or start!) your fancy new website.

I'm not going to reinvent the wheel, here - others have provided tremendously helpful walk-throughs of hosting a [Jekyll](http://jekyllthemes.org/) website on Github, or hosting a [Hugo](https://themes.gohugo.io/theme/cactus/) blog on Github or Netlify. These are the ones that I've found most helpful. 

1. [Emily Zabor](http://www.emilyzabor.com/tutorials/rmarkdown_websites_tutorial.html) on building a static personal website in Jekyll, and hosting it on Github
2. Emily Zabor again on building a [blog](http://www.emilyzabor.com/tutorials/rmarkdown_websites_tutorial.html#blogs) website in Hugo using the R package `blogdown`
3. [Alison Hill](https://alison.rbind.io/post/up-and-running-with-blogdown/) with even more details on `blogdown`
4. [Mara Averick](https://maraaverick.rbind.io/2017/10/updating-blogdown-hugo-version-netlify/) on deploying a Hugo blog in Netlify 

If you need to troubleshoot further, I'd recommend: 

1. [Jenny](http://happygitwithr.com/) on Git and Github in R
2. [Yihui](https://bookdown.org/yihui/blogdown/output-format.html) on Blogdown


<sup>1</sup> Sidebar: just keep every R script inside an R project. Every single one. It's just easier.
<sup>2</sup> Well, you suckers can't anymore, because that's mine now. Thems the breaks. 