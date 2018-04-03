---
title: Custom domain hosting with Github and Namecheap
author: Brooke Watson
date: '2018-04-02'
slug: custom-domain-hosting-with-github-and-namecheap
categories: []
tags:
  - hugo
  - blogdown
  - netlify
  - namecheap
  - R
  - github
  - domain hosting
description: Trading in '.github.io' or '.netlify.com' for '.party', '.racing', or '.men'. 
---

I am a compulsive buyer of online real estate. Ever since I learned about specialty TLDs (domain extensions that expand the traditional `.com`, `.org`, and `.net` sites to include `.limo`, `.diamonds`, and `.juegos`), I will occasionally log on to [Namecheap.com](https://www.namecheap.com), fall into an internet k-hole, and emerge 30 minutes later, $13 lighter but flush with `brooke.city`, `pangolin.agency`, `medium.place`, and `mammal.party`, among others. 

I haven't done anything with most of these. In fact, most lapse without ever redirecting to anything but the Namecheap parking space, a momentary, 48 cent adrenaline rush. In all likelihood, Pangolin Agency will never become an hour-long crime procedural following three endangered pangolin lawyers on a slow but steady mission to end wildlife trafficking, and I won't then be able to [flip my newly precious online real estate](http://www.abc.net.au/triplej/programs/hack/kanyeforpresident-domain-flipping/7442084) to Hulu or whomever for a sweet payout. 

But finally, around a year ago, I put at least one of them to use, linking a Github pages repo to what is now my personal webpage, [brooke.science](http://www.brooke.science). A month ago, I added a subdomain ([blog.brooke.science](http://blog.brooke.science), hello, this is where you are now) and built a much more robust site on it, complete with a new Github repo and using new tools. 

It took me several hours of increasingly frustrated and cryptic Git commit messages to figure out how to point brooke-watson.github.io to my new, corny, custom domain. This shouldn't have been the case. 

Linking a website to a custom domain, it turns out, is actually only about 3 **incredibly simple** steps. But I didn't know anything about web hosting, and didn't take the time to RTFM before I started, so I assumed that everything was more complex than it needed to be. Lately, I've seen tons of great [tutorials](/posts/custom-domain-hosting-with-github-and-namecheap/#website-building-tutorials) that walk through building a website on Github or Netlify, often using the standard `username.github.io` or `customname.netlify.com` urls. But in many of these, I've seen little instruction on linking these to a custom domain, or even on how to acquire one in the first place. 

Having recently deployed this [blog](http://blog.brooke.science) on Netlify using a custom subdomain, I'm momentarily intimately familiar with the process. I'm writing these steps down, with screenshots, so I don't make it too complicated for myself the next time. Perhaps they will also be of use to someone else.

If you already have a site hosted at yourgithubname.github.io or whatever-name.netlify.com, you're only approximately 10 minutes[<sup>1</sup>](/posts/custom-domain-hosting-with-github-and-namecheap/#footnotes) and 66 cents away from moving to `rstats.party`, `preposterous.accountant`, and `christina-aguilera-going-online-with-her-nails-looking-fresh.website`.

<center>
<iframe src="//popkey.co/m/zdjAp-thats+right-clicking-blocking/embed" width="480" height="253" frameBorder="0" scrolling="no" allowFullScreen></iframe>
</center>


# Step 1: Buy a domain name

I like [Namecheap.com](https://www.namecheap.com/) as a platform, so that's what I'll demonstrate here. I've also heard good things about [Hover.com](https://www.hover.com/) (and bad things about GoDaddy).  Namecheap was the cheapest I found, which is convenient if you're buying six goofy domains at a time. It also allows you to set up email addresses for a small additional cost.  

There are two main ways to set up a domain: by setting up a redirect, or by adding a `CNAME` and `A records`. If your domain is hosted on Github, I'd strongly recommend adding a CNAME and A records, even if those terms mean nothing to you now. If you just want a vanity domain name to redirect to an existing site, you can skip to the [redirect instructions](/posts/custom-domain-hosting-with-github-and-namecheap/#alternately-set-up-a-redirect). 
# Step 2: Configure your CNAME and A Records

After you've bought your domain name, navigate to "manage" your domain, then click on the "DNS" tab. 

![](/figs/2018-04-02-domain-hosting/namecheap.gif)

Add a record of type `CNAME`, as shown in the screenshot below. In the `host` field, type in "www". In the `value` field, type the current address to your website (leaving out the "http://"). Leave the TTL "Automatic". 

If your website is hosted in Github (whether it is deployed via Github Pages, Netlify, or some other provider), add two `A record`s using the numbers below, with "@" hosts and "Automatic" TTLs. (If the code that builds your website lives somewhere else, you'll need to use that host's IP addresses.) 

```
192.30.252.153 
192.30.252.154
```

![](/figs/2018-04-02-domain-hosting/cname.png)

# Step 3: Add a CNAME file to your Github repo

**If** your website is deployed via Github, you'll need to add a CNAME file to the top level of your Github repo. This is just a file called CNAME (no extension, all caps) that has one line inside it - yourdomain.tld. 

![](/figs/2018-04-02-domain-hosting/gh-cname.png)

I don't think this is necessary if your website is deployed via Netlify. [Netlify](http://netlify.com) is a free service that will **watch** a Github repo with a website inside of it, updating that website whenever you push passing changes to the master branch. Netlify  plays much more nicely with Hugo than Github Pages does, and allows you to have multiple Github repos connected to multiple domain names all from within the same Github account.  You ~*can*~ [deploy](https://gohugo.io/hosting-and-deployment/hosting-on-github/) a Hugo site via Github pages, but I'm not sure why anyone would. Jekyll sites, on the other hand, work like a dream with GH pages. 

## Optional Step 4: Add a subdomain

You can also add as many *subdomains* as you want to your domain: for example, blog.brooke.science is a subdomain of brooke.science. 

To add a subdomain, replace the "www" host with whatever you want (e.g. blog) to appear before the domain. In the "value" field, enter the website that you want blog.yourdomain.tld to point to. For example, my domain blog.brooke.science is built and modified at (http://www.github.com/brooke-watson/blog), and deployed at (http://www.brooke.netlify.com), so "brooke.netlify.com" goes in the value field. 

![](/figs/2018-04-02-domain-hosting/subdomain.png)

# Alternately: Set up a redirect

If the CNAME/A Record set up isn't working, you can **redirect a custom domain name to an existing site.** This is the easiest method to enact, but can get buggy if people are finding the site both through your domain and through search channels. It can also confuse Google Analytics and other tracking programs, so it's not the most useful as a long-term solution. 

However, redirects are very simple, and can be done without changing anything about the existing website. You might want to set up a redirect if, for example, you bought a [novelty domain name for your pet snake](http://www.judith.press), but you don't want to build her an entire website - you just want to redirect traffic to her Instagram account.

When you go to manage the domain name, all you have to do is delete the CNAME record (from the image above) and change the redirect record to the site you want to redirect to, like so:  

![](/figs/2018-04-02-domain-hosting/one-redirect.png)

If this is all you want to do, you're done. [Judith.press](http://judith.press) now redirects to @officialkingjudy's Instagram. 

You *can* chose a "masked" redirect, which means that even after it redirects, you will still see "judith.press" in the browser. This is cute, but much less stable than unmasked and 301 redirects, and **highly** unrecommended. It causes a [duplicate content](https://support.google.com/webmasters/answer/66359?hl=en) problem, and can prevent your website from being indexed by search engines (or even loading properly at all).

I can also add redirects with different "hosts". Currently, I only have an `@` host, which means that only http://judith.press redirects. If we want the browser to know what to do with http://www.judith.press, we have to add a `www` host.

![](/figs/2018-04-02-domain-hosting/many-redirects.png)

Redirecting is really easy, but it's not the most stable permanent solution. It's great if you want to buy a heap of domains with the mayor of New York City's name in them and redirect them to [John Oliver clips](https://www.youtube.com/watch?v=1pqe_oqDJp0), but **if you're building your website somewhere like Github, I STRONGLY recommend that you can configure your CNAME record in Namecheap to point to the repo without redirecting.**

# Website building tutorials

Maybe you haven't yet built a website or blog, but the idea of owning [tinytinymikebloomberg.party](https://www.youtube.com/watch?v=1pqe_oqDJp0) (currently a STEAL at $0.48!) makes you want to. There are HEAPS of resources on the internet to help do this, but I've found that the few below are all I really needed. 

1. [Emily Zabor](http://www.emilyzabor.com/tutorials/rmarkdown_websites_tutorial.html) on building a static personal website in Jekyll, and hosting it on Github
2. Emily Zabor again on building a [blog](http://www.emilyzabor.com/tutorials/rmarkdown_websites_tutorial.html#blogs) in Hugo using the R package `blogdown`
3. [Alison Hill](https://alison.rbind.io/post/up-and-running-with-blogdown/) with even more details on `blogdown`
4. [Mara Averick](https://maraaverick.rbind.io/2017/10/updating-blogdown-hugo-version-netlify/) on deploying a Hugo blog via Netlify.
5. [Yihui](https://bookdown.org/yihui/blogdown/output-format.html) with way more blogdown details than you'll need to get started. 
  
My opinionated advice, as an R user and someone who has used both Jekyll and Hugo in the past, is to start from scratch using the `blogdown` package and a slick Hugo theme. If you've never built a website (and are more comfortable in RStudio than on the command line), I wouldn't spend any time with Jekyll at all. 

If you're already up and running, this should be more than enough. Go forth and fill the internet with 💎`.diamonds` 💎. 

# Footnotes 

<sup>1</sup> It actually may take ~30 minutes after you've configured your new domain for all of your content to be shifted over. Be patient - your old domain still works! In fact, your old website will continue to be a valid address even after your new domain is fully functioning. If, after taking a break from your computer, some of your pages still aren't working, troubleshoot by checking the baseURL in your config file and making sure all your paths are relative.