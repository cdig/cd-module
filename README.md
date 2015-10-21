# cd-module v2

A framework and standard library to help you make gorgeous modules.

This branch contains the cd-module v2 codebase. It's a big upgrade over the original cd-module codebase (which lives on in the [master](https://github.com/cdig/cd-module/tree/master) branch). Keep reading to learn all about v2 — like how it's only 6 short of being tasty!



### Table of Contents

- [Quick Reference](#quick-reference)
- [Starting A New v2 Module](#starting-a-new-v2-module)
- [Upgrading An Existing v1 Module](#upgrading-an-existing-v1-module)
- [New Features](#new-features)
- [Removed Features](#removed-features)
- [Planned For v3+](#planned-for-v3)
- [Reference](#reference)
- [Documentation](#documentation)


<br>
## Quick Reference

### Command Line

Command        | Description
--------------:|--------------------------
bower update   | Downloads files for cd-module into bower_components
gulp           | Compiles the module & starts browser sync
gulp update    | Updates the gulpfile
npm install    | Downloads files for gulp into node_modules


### Hyperzine

* Before adding a module to Hyperzine, delete the `node_modules` folder.
* After taking a module out of Hyperzine, `cd` into the module folder and run `npm install`.



<br>
## Starting A New v2 Module

Grab the [starter](https://github.com/cdig/cd-module-starter/tree/v2), and follow the instructions there.


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
rm gulpfile.js
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


### 6. ~~`<main>`~~
Using `<main>` the way we were was a minor violation of the HTML spec. In v2, you must use `<cd-main>`, as many of the new features depend on it.


### 7. ~~Audio~~
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
We now have [cd-library](https://github.com/cdig/cd-library), which is a better version of the same idea.



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

### Even Better Performance
We could do some of these things, maybe:

* Lazy load images based on scroll position
* Adapt frameworks and scripts to work assuming an async/lazy page environment
* Load scripts for activities on-demand
* Don't make assumptions about the size/layout of the module as a whole — restrict scripts to working within a page, with appropriate guarantees about when page assets become available

### Modular Scale
Text size should be based on a well-chosen rhythm, rather than the current "wing it" approach I've taken.

### Integration
Modules work well as standalone, isolated pieces of content, but that's not the ambition. We want modules to be aware of their surroundings, and both pull in elements of their environment, and offer aspects of themselves for outside use.

* Support for standardized metadata (title, description, icon, etc) that can be automatically discovered and used in menus, link previews, etc
* A standard for GUI elements provided by the environment (eg: an LBS header and footer that bookends the module, or a floating HUD provided by a launcher — NOT baked into the module itself)
* Tight integration with Hyperzine as a source of media assets
    * If we're using JS to lazy-load media, that's a good hook for adding extra control over how the media gets loaded (eg: you supply a normal relative URL that refers to a piece of media included in the module bundle, but it has query params that the JS can use to change the URL dynamically, to load a particular version from Hyperzine, perhaps using versioning rules like Bower)
* Tight integration with the data lake / scoring services for storing and displaying facts from the user's history



<br>
<br>
## Reference


### Browser Support
We support: `last 5 Chrome versions, last 2 ff versions, IE >= 10, Safari >= 8, iOS >= 8`. We'll probably bump this spring 2016, depending on how Edge adoption goes. We're supporting quite a few Chrome versions, because I'm not convinced that our users run Chrome often enough to stay reasonably up-to-date. This should only affect code volume (because of prefixes), not behavior.


### Naming Conventions

#### 1. CSS Classes are for Content Styling
Classes are reserved for styling content. Don't use them as hooks for JS, and don't use them in low-level systems. If you must use a class for a non-content purpose, namespace it with the exact name of your system.

#### 2. HTML Attributes are for JS Services
Attributes on elements are reserved for JS and low-level systems. The JS targeting an attribute should enhance the element, but not do anything too crazy. Attributes should be namespaced with the name of the system.

#### 3. Custom Elements are for Components
Custom elements are reserved for components (html + css + js). All bets are off for anything inside a custom element — the JS has total freedom to wildly manipulate the element, restructure any internal DOM, introduce styling, etc.

| Name       | Type            | Written As | Example      |
|------------|-----------------|------------|--------------|
| Component  | HTML, CSS, & JS | kebab-case | call-out     |
| Element    | HTML Only       | singleword | figcaption   |
| Mixin      | CSS Only        | kebab-case | magic-unders |
| Service    | JS Only         | CamelCase  | PageLocking  |
| Style Rule | CSS Only        | Selector   | .text-center |


### Z-Index Values
z-index | CSS Selector              | System
-------:| ------------------------- | ------
0-999   |                           | your module content
100     | call-out[open]            | call-outs
101     | call-out-point            | call-outs
1000    | cd-modal                  | ModalPopup
10000   | editor-container textarea | [Editor](https://github.com/cdig/editor)

* call-outs have been given a z-index of ~100 so that you can layer content above or below them.



<br>
<br>
## Documentation

TODO: The below docs are currently from v1, and need to be updated for v2.

### cd-page
This custom element is the highest-level grouping of content within a module.
Following the example of the [module starter](https://github.com/cdig/cd-module-starter),
your module will have a `source/pages` folder.
Each file in this folder will have exactly one `<cd-page>` element that wraps all the page contents.
You'll import all of these page files into the `<body>` of the `index.kit` for your module.

```html
<cd-page id="my-amazing-page">
  <!-- page content -->
</cd-page>
```

**Requirements:**
* You must give each page an `id`, which must be unique within the module.
* The page file should have the same name as the `id` of the `<cd-page>`.

**Behaviour:**
The default styling creates a centred column with lots of top and bottom margin, with a nice shadow poking out from the corners to establish the vertical flow of the module. The ID is used for the title of the page in the Page Switcher, and the filename for Page Audio.


### cd-row

**Usage:**
`<cd-row>` uses flexbox to create a dynamic multi-column layout. In this example, the three images will all appear side-by-side.

```html
<cd-row>
  <img src="image/puppy-1.jpg">
  <img src="image/puppy-2.jpg">
  <img src="image/puppy-3.jpg">
</cd-row>
```

**Requirements:**
TODO

**Behaviour:**
Quick thing to note (which will be explained later): currently having a video inside of cd-row requires that video to be embedded within a div in order to work inside of IE.


### h1

**Usage:**
This heading element is used exclusively for the title of the page.
It should almost always be the first child of the first `<main>` element in the page,
though you might also want to wrap it with a [cd-row](#cd-row) to place it beside a tall image.

```html
<cd-page id="my-amazing-page">
  <main>
  
    <h1>My Amazing Page</h1>
  
  </main>
</cd-page>
```

**Requirements:**
* You should only use h1 for the title of a page. It should very closely match the id of the [cd-page](#cd-page) element.
* You should not apply your own styling to the h1 within the module. Custom styling should come from the [_project folder](#_project-folder) and be shared across the entire project.

**Behaviour:**
h1 elements get very special styling, with [Magic Underlines](#magic-underlines)
and colours from the [_project folder](#_project-folder).


### cd-main

**Usage:**
This standard element marks a major unit of content within a page.
You may include as many main elements within the page as you'd like,
to break up the flow of the page into nice units.
Most of the content of your module — text, images and games — will go inside the main element.
But you are also free to place content outside of the main element.
This can be used to create full-width "hero" content, which will stretch edge-to-edge on mobile.
This is a great way to showcase beautiful photos.

```html
<cd-page id="my-amazing-page">
  <main>
    <!-- content -->
  </main>
  
  <img src="image/hero.png">
  
  <main>
    <!-- content -->
  </main>
  
</cd-page>
```

**Requirements:**
* The main element must be a direct child of a cd-page.

**Behaviour:**
The default styling creates a white padded background behind the content.



<br>
<br>
## License
Copyright (c) 2014-2015 CD Industrial Group Inc. http://www.cdiginc.com
