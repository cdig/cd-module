# cd-module v2

This branch contains the cd-module v2 codebase. It's a big upgrade over the original cd-module codebase (which lives on in the [master](https://github.com/cdig/cd-module) branch). Keep reading to learn all about v2 — like how it's only 6 short of being tasty.

<br>
## Starting A New v2 Module

Grab the [starter](https://github.com/cdig/cd-module-starter), and follow the instructions there.


<br>
## Upgrading An Existing v1 Module

### Prolog
First, you should make sure you've talked to Ivan and he's made sure you have all the command line utilities and setup that you need. He should write a complete list, but here's a start:

* nvm, node, npm, gulp
* Audible bell, visual bell, and/or badge app icon on Terminal errors


### Phase One

#### 1. Make a fresh COPY of your module.
If anything goes wrong, you should feel comfortable just trashing the upgraded version, and falling back to the original.

#### 2. Move your SVG Activities
Move the activity folder completely out of your module. Put it somewhere else. Activities are now stand-alone things. You'll develop them in isolation, and then add the compiled result to your module. (Here's why we're making this change: in the not too distant future, you'll just be able to directly "include" an activity from Hyperzine in your module).

#### 3. Write down your fonts (except Varela Round)
For some modules, the fonts are imported in your `source/styles.scss` file. In other modules, you may have uncommented a line the `bower_components/_project/dist/styles.scss` file. Before upgrading, you need to check both of these places and write down the fonts that your module is using. You probably aren't using Varela Round, but for some reason it was uncommented by default in _project, so I'd ignore that unless you know you need it.

#### 4. Pull CSS rules out of styles.scss
Also, while you're in `source/styles.scss`, make sure there are no actual CSS rules in here. Normally, the file is just full of import statements and comments. If you have any actual CSS, you need to move it to a different file (I recommend making a `source/styles/module.scss` file, and dumping it in there).

#### 5. Pull coffee code out of scripts.coffee
Finally, open `source/scripts.coffee`. Again, this file is normally just full of `# @codekit-blubber 'blah.coffee'` statements and comments. If you have any actual CoffeeScript code in here, you need to copy that to a different file (I recommend `source/scripts/module.coffee`).

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/onward.jpg)

### Chapter Two
Now, we're going to activate the module time machine, sending your module into the future.

Open the Terminal, and `cd` into your module folder. Copy this entire block, *including the empty space at the end!*

```bash
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-starter/v2/dist/package.json > package.json
curl -fsS https://raw.githubusercontent.com/cdig/cd-module-starter/v2/dist/gulpfile.coffee > gulpfile.coffee
npm install
gulp to-the-future
     
```

Paste it in to your Terminal. Stuff will start running. Go make a coffee. Talk to Mark for a bit. Minutes later (like, fricking, half an hour), the upgrade process will finish, and it'll clear the screen. Then you're ready to ~~ride your hoverboard~~ get to work on your v2 module.

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/jacket.jpg)


### Lemma Three
You wrote down some fonts earlier, yes? There's a new file, `source/styles/fonts.scss` — open that file and uncomment the fonts you need.

Back in the Terminal, run the `gulp` command. You'll either have a spectacular display of error fireworks — call Ivan! — or your newly upgraded module will pop up in your favorite web browser with a ton of new features and super-fast, hopefully-more-reliable compiling and reloading via gulp. Welcome to the future!

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/party.jpg)

### Epilogue
While you're reviewing your newly upgraded module, here are some trouble spots to look out for.

#### Text in cd-map
We've changed the standard font to Lato, which flows a little differently than the previous standard font(s) like Myriad. The change can be particularly painful in cd-maps, especially ones where the text is "bare" — that is, not placed in a box.

#### Colors
We've automatically changed all references to the old, non-standard colors like "cdDarkRed" to the new standard LBS colors. Make sure all your colored text, or text on colored backgrounds, is still readable. It should be, but if not, fix accordingly. Reminder: all the new colors are designed to work as a background for both white text and black text, so aim for consistency within a given layout (eg: all white or all black).





<br>
<br>
## A Quick Note About Hyperzine
Before adding a v2 module to Hyperzine, you need to delete the `node_modules` folder. After taking a module out of Hyperzine, you need to `cd` into the module folder and run `npm install`. Then you can run `gulp` as normal, and get down to work.


<br>
<br>
## New Features


### 1. Gulp
We're killing CodeKit, and switching to [Gulp](http://gulpjs.com). When it's time to work on a module, `cd` into your module folder, and then run the `gulp` command. It'll auto-compile all your files, watch them for changes, and live-reload the browser. You can test your module on other machines, too — when you run `gulp`, it'll show you the URLs to use when "Local" (from your computer) and "External" (from other computers).

Thanks to Gulp, we no longer need these files:

* ~~libs.js~~
* ~~scripts.coffee~~
* ~~styles.coffee~~

That means you won't need to worry about updating those files whenever you add something new to your module. Ivan and Sean worked really hard to make the cd-module [gulpfile](//github.com/cdig/cd-module-starter/blob/v2/dist/gulpfile.coffee) smart enough to find all your files, and compile them properly. * crying *

Gulp (and the browser reloading system we're using, browser-sync) should be much more reliable than CodeKit, but it's not perfect. If you find you're having a lot of trouble with it, we have a staggering number of options that tweak its behaviour, and the freedom to swap out browser-sync entirely for other, equivalent systems that might work better.


### 2. Asset Packs
As of v2, cd-module no longer provides any styling. At all.

Instead, you can plug-in "Asset Packs", which contain styles, scripts, images, components, SVGs, and whatever else you might want. So instead of cd-module offering some built-in styles, we now include a default Asset Pack: [lbs-pack](//github.com/cdig/lbs-pack). You can use other packs in addition to it. You can replace the lbs-pack with an entirely different pack (eg: for client-specific modules that don't share much at all with lbs-modules).

The Asset Pack system is VERY flexible, so be aware that you're being given quite a lot of rope with which to hang yourself. However, it should give you a lot more freedom to style modules however you wish, and make those styles reusable across all your modules, without having to go through Sean or Ivan.

You are free to make changes to the [lbs-pack](//github.com/cdig/lbs-pack), so that those changes apply across all LBS modules. You may want to run your changes past Ivan, so that he can make sure they'll perform well, but this is by no means a requirement (if you know what you're doing). The goal is that you guys will feel comfortable making such changes on your own.


### 3. Focus Mode [TODO]
Option-click on a cd-main to toggle focus mode. All other cd-mains will be hidden.


### 4. Better Page Locking
Now, an incomplete activity will prevent you from scrolling past its containing cd-main (than its containing cd-page).


<br>
<br>
## Removed Features


### 1. ~~The HUD~~
HUD's dead, baby. The HUD offered some nice functionality, but it was a pretty poor design. Instead of cramming more and more stuff into the HUD, we're removing it entirely. Some of its features are outright gone. Some of its features have moved. Some of its features are temporarily missing, and will be restored in the future.


### 2. ~~Smartphone Support~~
As discussed, we're dropping support for Smartphones. But there are consequences!

You should no longer use @media rules in your CSS. You should be able to make everything work well with `%` units and other "fluid" techniques. If this is too difficult, please ask for help.


### 3. ~~Non-Standard SCSS Variables~~
You shouldn't see any of those annoying colour variables like `$cdDarkGrey` anymore.


### 4. ~~Scoring~~
In preparation for our upcoming LBS scoring service, a lot of the existing scoring/points behavior has been reduced to a minimum.


### 5. ~~SCORM~~
We no longer support environments other than LBS. If we need to do another big content project, we'll extend cd-module to support that at that time.


### 6. ~~IE9~~
In addition to dropping support for IE9, we're also no longer checking whether the user's browser is good enough to run our stuff (since the code needed to do that was NOT light). LBS will serve as the gatekeeper, withholding our content from unworthy browsers.


### 7. ~~SWFs~~
SWF support has been removed from cd-module. If you need to use a SWF in a module, please install the [cd-swf-pack](/cdig/cd-swf-pack). TODO: If you try to use a SWF without the pack installed, we should issue a warning.


### 8. ~~<main>~~
Using `<main>` the way we were was a minor violation of the HTML spec. For future modules, please use `<cd-main>` instead. For the time being, `<main>` will continue to work, but it'll be removed in a future update.


### 9. ~~cd-foundation~~
Rather than have a repo that just bundles together a bunch of libs, you should grab those libs libs a la carte when needed. A lot of those libs, though, are only of interest to cd-module, and should just be merged in. If we find we want to use them in a lot of other projects, we can duplicate the code for the time being (duplication hell > dependency hell), and extract what's needed when it would demonstrably save us pain.


<br>
<br>
## Internal / Design Changes


### Progressive Enhancement
As I'm rewriting all the cd-module scripts, I should make sure things exhibit the load time and runtime characteristics I want.
* The initial time-to-first-page is crushed as far below 1 second as possible. Scripts that build-up fancy behaviour run after there's already content on the page. These scripts should be idempotent, so that pages/content can be freely added or removed at any time. These scripts should be well-targeted, so that non-module content can be dynamically added in and around module content, without conflict.
* Aggressively pursue better HTTP performance — better use of cache-friendly modules, balanced against the benefits of concat+min. Likewise, pursue CDN support.


### Crushing Issues [TODO]
See issues added to the v2 milestone.


<br>
<br>
## Documentation


### Browser Support
We support: `last 5 Chrome versions, last 2 ff versions, IE >= 10, Safari >= 8, iOS >= 8`. We'll probably bump this spring 2016, depending on how Edge adoption goes. We're supporting quite a few Chrome versions, because I'm not convinced that our users run Chrome often enough to stay reasonably up-to-date. This should only affect code volume (because of prefixes), not behavior.


### Known Issues
When you make a compile-time error in your SCSS or Coffee, the error message that appears in the Terminal is *not* very helpful in exactly locating the offending line of code. It's surely possible to provide some better info, but I have absolutely no idea how to do so at this point. That said, you should be able to make good use of the error message, and review your recent changes in order to locate the err.


### Naming Conventions
*Yo Dog, I Heard You Like CSS, So I Put A Style Guide In Your Stylesheet So You Can Style Your Rules While You Rule Your Styles.*

#### 1. .class -> CSS
Classes should be for styling, and that's it. The naming scheme will be decided as I figure out the right interface for Asset Packs (see below).

#### 2. [attribute] -> JS
Attributes should be for JS, and that's it. This JS should enhance the element, but not do anything too crazy or introduce possibly conflicting styling. Attributes should adopt an `x-blah` naming scheme, so we don't need to use silly "cd-blah" prefixes. The exception to all this is attributes on a component (custom element) — they can use whatever names they want, and the meaning of those attributes is defined by the component.

#### 3. <custom-element> -> Components
Custom elements should be for components (html + css + js), and that's it. All bets are off for anything inside a custom element — the JS has total freedom to wildly manipulate the element, restructure any internal DOM, introduce styling, etc.

A lot of the scripts available to cd-module v1 are implementation details (Pages, PageScrollWatcher, PageAudio, etc). We should go private by default, and only open things up for module developer's to use if need be. It'd be nice if Take&Make had some notion of privacy boundaries, like package-level privacy in AS3.


<br>
<br>
## License
Copyright (c) 2014-2015 CD Industrial Group Inc. http://www.cdiginc.com
