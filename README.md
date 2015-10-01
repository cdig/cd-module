# cd-module v2

This branch contains the cd-module v2 codebase. It's a big upgrade over the original cd-module codebase (which lives on in the [master](https://github.com/cdig/cd-module) branch). Keep reading to learn all about v2 — like how it's only 6 short of being tasty.

<br>
## Starting A New v2 Module

Grab the [template](https://github.com/cdig/cd-module-template), and follow the instructions there.


<br>
## Upgrading An Existing v1 Module

### Prolog
First, you should make sure you're working on a fresh COPY of your module. If anything goes wrong, you should feel comfortable just trashing the upgraded version, and falling back to the original.

There are a few assumptions we're making. The only one to double-check right now is.. all of your svg-activities must have the word "activity" in the folder name. If they don't, then you need to change that before you upgrade to v2.

### Phase One

Open `source/index.kit`. You'll need to clean it up to look like the following. Delete everything except the `$title` variable, and the list of page imports (including title and ending).

```kit
<!-- $title = Fluid Power Safety -->
<!-- @import ../bower_components/_project/dist/pages/title.kit -->
<!-- @import pages/objectives.html -->
<!-- @import pages/heat.html -->
<!-- @import pages/flammability.html -->
<!-- @import pages/hose-and-fitting-failure.html -->
<!-- @import pages/system-adjustment-hazards.html -->
<!-- @import pages/unexpected-motion-and-pinch-points.html -->
<!-- @import pages/zero-energy-state.html -->
<!-- @import pages/review.html -->
<!-- @import ../bower_components/_project/dist/pages/ending.kit -->
```

Open `source/styles.scss`. Normally this file is just full of `@import` statements and comments. If you have any actual CSS rules in here, you need to keep that stuff, and delete everything else (all the `@import` statements and comments). If there's no actual CSS, just delete the file.

Open `source/scripts.coffee`. Normally this file is just full of `# @codekit-wiggles` statements and comments. If you have any actual CoffeeScript code in here, you need to keep that stuff, and delete everything else (all the `# @codekit-bumblebum` statements and comments.) If there's no actual code, just delete the file.

Finally, delete `source/libs.js`. Who needs libs when you have eight limbs?

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/onward.jpg)

### Chapter Two
Now, we're going to activate the module time machine, sending your module into the future.

Open the Terminal, and `cd` into your module folder. Copy this entire block, *including the empty space* after the comment at the end.

```bash
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/package.json > package.json
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/gulpfile.coffee > gulpfile.coffee
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/.gitignore > .gitignore
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/source/pages/title.kit > source/pages/title.kit
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/source/pages/ending.kit > source/pages/ending.kit
rm -rf bower_components
npm install
gulp evolve
bower update
# clear
# Your jacket is now dry.
     
```

Paste it in to your Terminal. Stuff will start running. It'll clear your screen when done.

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/jacket.jpg)


### Lemma Three

Run the `gulp` command. You'll either have a spectacular display of error fireworks — call Ivan! — or your newly upgraded module will pop up in your favorite web browser. Welcome to the future!

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/party.jpg)


<br>
<br>
## Major Changes In v2


### 1. ~~Codekit~~ Gulp!
We're killing CodeKit, and switching to [Gulp](http://gulpjs.com). When it's time to work on a module, `cd` into your module folder, and then run the `gulp` command. It'll auto-compile all your files, watch them for changes, and live-reload the browser. You can test your module on other machines, too — when you run `gulp`, it'll show you the URLs to use when "Local" (from your computer) and "External" (from other computers).

Thanks to Gulp, we no longer need these files:

* ~~libs.js~~
* ~~scripts.coffee~~
* ~~styles.coffee~~

That means you won't need to worry about updating those files whenever you add something new to your module. Gulp is smart enough to find all your files, and compile them properly.

Gulp (and the browser reloading system we're using, browser-sync) should be much more reliable than CodeKit, but it's not perfect. If you find you're having a lot of trouble with it, we have a staggering number of options that tweak its behaviour, and the freedom to swap out browser-sync entirely for other, equivalent systems that might work better.


### Asset Packs
As of v2, cd-module no longer provides any styling. At all.

Instead, you can plug-in "Asset Packs", which contain styles, scripts, images, components, SVGs, and whatever else you might want. So instead of cd-module offering some built-in styles, we now include a default Asset Pack: [lbs-pack](//github.com/cdig/lbs-pack). You can use other packs in addition to it. You can replace the lbs-pack with an entirely different pack (eg: for client-specific modules that don't share much at all with lbs-modules).

The Asset Pack system is VERY flexible, so be aware that you're being given quite a lot of rope with which to hang yourself. However, it should give you a lot more freedom to style modules however you wish, and make those styles reusable across all your modules, without having to go through Sean or Ivan.


### HUD's Dead, Baby
The HUD offered some nice functionality, but it was a pretty poor design. Instead of cramming more and more stuff into the HUD, we're removing it entirely. Some of its features are outright gone. Some of its features have moved. Some of its features are temporarily missing, and will be restored in the future.


### Smartphone Support Dropped
As discussed. But there are consequences!

You should no longer use @media rules in your CSS. At all. If you have any, you should remove them. You should make everything work well with `%` units. If this is too difficult.. ask for help!


### Improved Primitives [DRAFT]
We need to revisit what primitives we're using, why, and how: cd-row / cd-map / center-block / etc.

Ideas for new primitives:
* Some sort of grid layout primitive, that supports stacking
* Some sort of drag-and-drop grid layout primitive



<br>
<br>
## Minor Changes


### Simplified Scoring
In preparation for our upcoming LBS scoring service, a lot of the existing scoring/points behavior has been reduced to a minimum.


### LBS Only
We don't support environments other than LBS. If we need to do another big content project, we'll extend cd-module to support that at that time.


### IE10+ only
In addition to dropping support for IE9, we're also no longer checking whether the user's browser is good enough to run our stuff (since the code needed to do that was NOT light). LBS will serve as the gatekeeper, withholding our content from unworthy browsers.


### SWFs Considered Harmful
SWF support has been removed from cd-module. If you need to use a SWF in a module, please install the [cd-swf-pack](/cdig/cd-swf-pack). TODO: If you try to use a SWF without the pack installed, we should issue a warning.


<br>
<br>
## Internal / Design Changes


### Kill cd-foundation [DRAFT]
Rather than have a repo that just bundles together a bunch of libs, you should grab those libs libs a la carte when needed. A lot of those libs, though, are only of interest to cd-module, and should just be merged in. If we find we want to use them in a lot of other projects, we can duplicate the code for the time being (duplication hell > dependency hell), and extract what's needed when it would demonstrably save us pain.


### Yo Dog, I Heard You Like CSS
So I Put A Style Guide In Your Stylesheet So You Can Style Your Rules While You Rule Your Styles.

#### CSS
Classes should be for styling, and that's it. The naming scheme will be decided as I figure out the right interface for Asset Packs (see below).

#### JS
Attributes should be for JS, and that's it. This JS should enhance the element, but not do anything too crazy or introduce possibly conflicting styling. Attributes should adopt an `x-blah` naming scheme, so we don't need to use silly "cd-blah" prefixes. The exception to all this is attributes on a component (custom element) — they can use whatever names they want, and the meaning of those attributes is defined by the component.

#### Components
Custom elements should be for components (html + css + js), and that's it. All bets are off for anything inside a custom element — the JS has total freedom to wildly manipulate the element, restructure any internal DOM, introduce styling, etc.

A lot of the scripts available to cd-module v1 are implementation details (Pages, PageScrollWatcher, PageAudio, etc). We should go private by default, and only open things up for module developer's to use if need be. It'd be nice if Take&Make had some notion of privacy boundaries, like package-level privacy in AS3.


### Progressive Enhancement
As I'm rewriting all the cd-module scripts, I should make sure things exhibit the load time and runtime characteristics I want.
* The initial time-to-first-page is crushed as far below 1 second as possible. Scripts that build-up fancy behaviour run after there's already content on the page. These scripts should be idempotent, so that pages/content can be freely added or removed at any time. These scripts should be well-targeted, so that non-module content can be dynamically added in and around module content, without conflict.
* Aggressively pursue better HTTP performance — better use of cache-friendly modules, balanced against the benefits of concat+min. Likewise, pursue CDN support.


### Runtime Performance
* Remove not-visible pages from the DOM and halt execution of their scripts (might need to establish special APIs around this; thus, breaking change), to see if it helps perf on low-power devices like A5 iPads.


### Crushing Issues
* Better page locking. Activities should lock on themselves (rather than the cd-page they're inside of). You should be able to move the lock point to a different place in the markup. You should be able to create a lock point and trigger, which can be controlled from module code (eg: you have to click a button 5 times to unlock the next bit of content — not something that warrants a full cd-activity).
* Etc (see issues added to the v2 milestone)

<br>
<br>
## Documentation


### Browser Support
We support: `last 5 Chrome versions, last 2 ff versions, IE >= 10, Safari >= 8, iOS >= 8`. We'll probably bump this spring 2016, depending on how Edge adoption goes. We're supporting quite a few Chrome versions, because I'm not convinced that our users run Chrome often enough to stay reasonably up-to-date. This should only affect code volume (because of prefixes), not behavior.


<br>
<br>
## License
Copyright (c) 2014-2015 CD Industrial Group Inc. http://www.cdiginc.com
