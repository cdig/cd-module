# cd-module v2

This branch contains the cd-module v2 codebase. It's a big upgrade over the original cd-module codebase (which lives on in the [master](https://github.com/cdig/cd-module) branch). Keep reading to learn all about v2 — like how it's only 6 short of being tasty.

<br>
## Starting A New v2 Module

Grab the [starter](https://github.com/cdig/cd-module-starter), and follow the instructions there.


<br>
## Upgrading An Existing v1 Module

### Prolog
First, you should make sure you've talked to Ivan and he's made sure you have all the command line utilities and setup that you need. Here's a rough list of stuff he will check:

* make sure nvm is installed
* nvm install stable
* nvm use stable
* nvm alias default stable
* make sure `sudo chown $(whoami):staff ~/.nvm` if necessary
* bash_profile should have no nvm stuff
* bashrc should be current, with NVM path correct for the given username
* npm install -g npm
* npm install -g gulp
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
In v2, you can enhance your module with Asset Packs — reusable bundles that contain styles, scripts, and components. Instead of cd-module having built-in styles, we now include a default Asset Pack: [lbs-pack](//github.com/cdig/lbs-pack). You can use other packs in addition to it. You can replace the lbs-pack with an entirely different pack (eg: for client-specific modules that don't share much at all with lbs-modules).

Asset Packs are intended to help you take your favorite design patterns and make them reusable across all your modules, without having to go through Sean or Ivan.

You are free to make changes to the [lbs-pack](//github.com/cdig/lbs-pack), so that those changes apply across all LBS modules. You may want to run your changes past Ivan, so that he can make sure they'll perform well, but this is by no means a requirement.


### 3. Focus Mode
Option-click on a cd-main to toggle focus mode. All other stuff will be hidden. This makes it super easy to check how your layout looks as you resize the window. Even better — when you make the window narrower than the minimum size we care about (768px — iPad Portrait), we change the background color around the edges, so you know when you can stop giving a crap about stuff breaking — woo!


### 4. Activity Emphasis
Over the next few months, we'll get some real scoring infrastructure in LBS. Along the way, there'll probably be a few revisions to how activities are handled. Here are the changes in v2:

* We "lock" scrolling at the `cd-main` containing your current activity — whereas in v1, we locked on `cd-page`, which sucked. While it'd be nice to "lock" right at the activity, this would actually be worse for UX.
* The current activity's `cd-main` gets a blue border, giving it a nice bit of emphasis.
* The green bubble points animation has been removed. We'll be replacing it with something more effective in the future.


### 5. Top & Bottom Bars
Instead of the HUD, we now have a bar at the top and bottom of the module. Hopefully, this'll offer the same functionality as the HUD, while feeling more integrated with LBS, doing a better job of deferring to the content, and not being as glitchy on mobile.

The design might seem a bit weird at the moment, but I'm planning to add navigation recommendations, and other advanced features, to this space in the future.


<br>
<br>
## Removed Features


### 1. ~~Smartphone Support~~
As discussed, we're dropping support for Smartphones. But there are consequences!

You should no longer use @media rules in your CSS, ideally. You should be able to make everything work well with `%` units and other "fluid" techniques. If this is too difficult, please ask for help.


### 2. ~~Non-Standard SCSS Variables~~
You shouldn't see any of those annoying colour variables like `$cdDarkGrey` anymore.


### 3. ~~SCORM~~
We no longer support environments other than LBS. If we need to do another big content project, we'll extend cd-module to support that at that time.


### 4. ~~IE9~~
In addition to dropping support for IE9, we're also no longer checking whether the user's browser is good enough to run our stuff (since the code needed to do that was NOT light). LBS will serve as the gatekeeper, withholding our content from unworthy browsers.


### 5. ~~SWFs~~
SWF support has been removed from cd-module. If you need to use a SWF in a module, please install the [cd-swf-pack](/cdig/cd-swf-pack). TODO: If you try to use a SWF without the pack installed, we should issue a warning.


### 6. ~~<main>~~
Using `<main>` the way we were was a minor violation of the HTML spec. In v2, you must use `<cd-main>`, as many of the new features depend on it.


### 6. ~~Audio~~
Audio is temporarily removed, as part of killing the HUD. In the future, it will be added back.


<br>
<br>
## Internal / Design Changes


### Performance
The load-time performance of cd-module has been considerably improved, but there's still lots of waste. Here are some guidelines for ongoing development:

* Don't Take "load" unless you absolutely must. Instead, Take "DOMContentLoaded", or just run immediately as your script loads. Do your work and get out of the way.
* On the contrary, defer work until (long) after load time. There's a lot of front-of-line congestion, so if you can do your work rather lazily, that's excellent. Especially if you're touching the DOM or loading assets.
* Aggressively pursue better HTTP performance. Use cache-friendly precompiled scripts. We'll take the hit on additional request/response for now, given that we'll have CDN support and HTTP2 in the next six months.

The runtime performance of cd-module has also been improved. It's pretty much as good as it can be right now — it's important that we try really hard to keep it this way. Test frequently on terrible hardware.


### ~~cd-foundation~~
Rather than have a repo that just bundles together a bunch of libs, you should grab those libs libs a la carte when needed.

TODO: A lot of those libs, though, are only of interest to cd-module, and should just be merged in. If we find we want to use them in a lot of other projects, we can duplicate the code for the time being (duplication hell > dependency hell), and extract what's needed when it would demonstrably save us pain.



<br>
<br>
## Planned For v3+

### Audio
This is an open issue.. not sure the right way to solve it. Doing speaker icons per-main might be.. too much visual noise, if they're in context. Perhaps, they can sit just outside the main, off to the right. That might be a nice spot for other UI elements, too, like the score indicator.

### New Score Animation
Perhaps, little effervescent bubbles that float up and disappear. I seem to like bubbles.

### Scroll-Driven Animations
This includes giving something sticky positioning, but changing its state as you scroll.

### Production builds
No sourcemaps, perhaps some URL rewriting with asset fingerprinting.


<br>
<br>
## Documentation


### Browser Support
We support: `last 5 Chrome versions, last 2 ff versions, IE >= 10, Safari >= 8, iOS >= 8`. We'll probably bump this spring 2016, depending on how Edge adoption goes. We're supporting quite a few Chrome versions, because I'm not convinced that our users run Chrome often enough to stay reasonably up-to-date. This should only affect code volume (because of prefixes), not behavior.


### Known Issues
When you make a compile-time error in your SCSS or Coffee, the error message that appears in the Terminal is *not* very helpful in exactly locating the offending line of code. It's surely possible to provide some better info, but I have absolutely no idea how to do so at this point. That said, you should be able to make good use of the error message, and review your recent changes in order to locate the err.


### Naming Conventions

#### 1. CSS Classes -> Content Styling
Classes are reserved for styling content. Don't use them as hooks for JS, and don't use them in low-level systems. If you must use a class for a non-content purpose, namespace it with the exact name of your system.

#### 2. HTML Attributes -> JS Systems
Attributes on elements are reserved for JS and low-level systems. The JS targeting an attribute should enhance the element, but not do anything too crazy. Attributes should be namespaced with the name of the system.

#### 3. Custom Elements -> Components
Custom elements are reserved for components (html + css + js). All bets are off for anything inside a custom element — the JS has total freedom to wildly manipulate the element, restructure any internal DOM, introduce styling, etc.


### z-index
TODO: port over the table of z-indices from v1, and update with all the new values.



<br>
<br>
## License
Copyright (c) 2014-2015 CD Industrial Group Inc. http://www.cdiginc.com
