# cd-module v2
A Framework for LBS Lessons

### Table of Contents

- [Starting A New v2 Module](#starting-a-new-v2-module)
- [Upgrading An Existing v1 Module](#upgrading-an-existing-v1-module)
- [What's New In v2?](#whats-new-in-v2)
- [Planned For v3+](#planned-for-v3)
- [Documentation](#documentation)
  - [Browser Support](#browser-support)
  - [Naming Conventions](#naming-conventions)
  - [Z-Index Values](#z-index-values)
  - [Project Folder](#project-folder)
  - [Configuration API](#configuration-api)
  - [Terminal Commands](#terminal-commands)
  - [SCSS Variables](#scss-variables)
  - [cd-page](#cd-page)
  - [cd-main](#cd-main)
  - [cd-row](#cd-row)
- [Troubleshooting](#troubleshooting)



<br>
<br>
## Starting A New v2 Module

There's a great writeup in the Wiki: https://github.com/cdig/lunchboxsessions/wiki/How-To-Make-a-Module


<br>
<br>
<br>
## Upgrading An Existing v1 Module

### Prelude

If this is the first module you've updated in a while, please open Terminal and run `nvm current`. If it displays something less than `v5.1.1`, please run the following commands:

```bash
nvm install stable
npm install -g npm
npm install -g bower coffee-script gulp
```

If you have any trouble with this, you'll need to get help from Ivan before continuing.

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

Open the Terminal, and `cd` into your module folder. Triple-click the following line, and paste it into the Terminal.

```bash
rm -rf node_modules gulpfile.js gulp-svg.coffee && curl -fsS https://raw.githubusercontent.com/cdig/cd-module-starter/v2/dist/package.json > package.json && curl -fsS https://raw.githubusercontent.com/cdig/cd-module-starter/v2/dist/gulpfile.coffee > gulpfile.coffee && curl https://lunchboxsessions.s3.amazonaws.com/static/cd-module/node_modules.zip > node_modules.zip && unzip -nq node_modules.zip && rm node_modules.zip && npm update && gulp to-the-future
```

Paste it in to your Terminal. Stuff will start running. After about 30 seconds, the upgrade process will finish.

If you see "Your jacket is now dry", then the upgrade succeeded! You're ready to ~~ride your hoverboard~~ get to work on your v2 module.

Otherwise, please consult the [upgrade failed](#my-v1-to-v2-upgrade-failed) troubleshooting guide.

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/jacket.jpg)


### Lemma Three
Did you write down any fonts earlier, in step 3? There's a new file, `source/styles/fonts.scss` — open that file and uncomment the fonts you need.

Back in the Terminal, run the `gulp` command. The Terminal might flood with errors — call Ivan! Otherwise, your browser should open up with your newly upgraded module. Welcome to the future!

![](http://lunchboxsessions.s3.amazonaws.com/static/github-cd-module-readme/party.jpg)


### Epilogue
While you're reviewing your newly upgraded module, here are some trouble spots to look out for.

#### Text in cd-map
We've changed the standard font to Lato, which flows a little differently than the previous standard font(s) like Myriad. The change can be particularly painful in cd-maps, especially ones where the text is "bare" — that is, not placed in a box.

#### Colors
We've automatically changed all references to the old, non-standard colors like "cdDarkRed" to the new standard LBS colors. Make sure all your colored text, or text on colored backgrounds, is still readable. It should be, but if not, fix accordingly. Reminder: all the new colors are designed to work as a background for both white text and black text, so aim for consistency within a given layout (eg: all white or all black).

#### `<main>` Styles
We've automatically replaced the `<main>` element with `<cd-main>` in all your HTML and Kit files. However, if you refer to the `main` element anywhere in your CSS, you'll need to update that to target the `cd-main` element instead.



<br>
<br>
<br>
## What's New In v2?


### 1. Gulp
We're killing CodeKit, and switching to [Gulp](http://gulpjs.com). When it's time to work on a module, `cd` into your module folder, and then run the `gulp` command. It'll auto-compile all your files, watch them for changes, and live-reload the browser. You can test your module on other machines, too — when you run `gulp`, it'll show you the URLs to use when "Local" (from your computer) and "External" (from other computers).

Thanks to Gulp, we no longer need these files:

* ~~libs.js~~
* ~~scripts.coffee~~
* ~~styles.coffee~~

That means you won't need to worry about updating those files whenever you add something new to your module. Ivan and Sean worked really hard to make the cd-module [gulpfile](//github.com/cdig/cd-module-starter/blob/v2/dist/gulpfile.coffee) smart enough to find all your files, and compile them properly. * crying *

Gulp (and the browser reloading system we're using, browser-sync) should be much more reliable than CodeKit, but it's not perfect. If you find you're having a lot of trouble with it, we have a staggering number of options that tweak its behaviour, and the freedom to swap out browser-sync entirely for other, equivalent systems that might work better.


### 2. Asset Packs
In v2, you can enhance your module with Asset Packs — reusable bundles that contain styles, scripts, and components. Instead of cd-module having built-in styles, we now include a default Asset Pack: [lbs-pack](//github.com/cdig/lbs-pack). You can use other packs in addition to it. You can replace the lbs-pack with an entirely different pack (eg: for client-specific modules that don't share much at all with lbs-modules).

Asset Packs are intended to help you take your favorite design patterns and make them reusable across all your modules, without having to go through Sean or Ivan.

You are free to make changes to the [lbs-pack](//github.com/cdig/lbs-pack), so that those changes apply across all LBS modules. You may want to run your changes past Ivan, so that he can make sure they'll perform well, but this is by no means a requirement.


### 3. Focus Mode
Option-click on a cd-main to toggle focus mode. All other stuff will be hidden. This makes it super easy to check how your layout looks as you resize the window. Even better — when you make the window narrower than the minimum size we care about (768px — iPad Portrait), we change the background color around the edges, so you know when you can stop giving a crap about stuff breaking — woo!


### 4. Activity Emphasis
Over the next few months, we'll get some real scoring infrastructure in LBS. Along the way, there'll probably be a few revisions to how activities are handled. Here are the changes in v2:

* We "lock" scrolling at the `cd-main` containing your current activity — whereas in v1, we locked on `cd-page`, which sucked. While it'd be nice to "lock" right at the activity, this would actually be worse for UX.
* The current activity's `cd-main` gets a blue border, giving it a nice bit of emphasis.
* The green bubble points animation has been removed. We'll be replacing it with something more effective in the future.


### 5. Top & Bottom Bars
Instead of the HUD, we now have a bar at the top and bottom of the module. Hopefully, this'll offer the same functionality as the HUD, while feeling more integrated with LBS, doing a better job of deferring to the content, and not being as glitchy on mobile.

The design might seem a bit weird at the moment, but I'm planning to add navigation recommendations, and other advanced features, to this space in the future.


### 6. Performance
The performance of cd-module has been considerably improved. There no more spinning-gear loading screen. Modules should be visible and usable in under a second. Scrolling is smoother. Animations will run *slightly* faster. There's less superfluous crap.

Here are some guidelines you can follow to help things go fast.
* Don't `Take "load"` unless you absolutely must. Instead, `Take "DOMContentLoaded"`.
* Try to delay doing your "work" until the relevant content is visible on screen, by using PageScrollWatcher or other means.
* For now, keep your SVG artwork simple. The fewer shapes the better. Avoid transparencies.


### 7. Asset Compilation
In cd-module of yore, you'd put some of your files in `public/`, and some of your files in `source/`. In v2, you put everything in `source/`. When you run `gulp`, we'll copy all your assets over to the `public/` folder. This means, in v2, you should NOT put anything in the `public` folder. We're making this change in preparation for some powerful features in upcoming versions of cd-module.

1. In v3, `gulp` will take care of optimizing your assets for you. You should still use ImageAlpha and follow the relevant [guide](https://github.com/cdig/lunchboxsessions/wiki/Guide-to-Asset-Optimization), but in case you forget, we'll cover your butt.
2. In v4, `gulp` will fingerprint your assets and rewrite your URLs so that they're loaded from the Hyperzine CDN. This is some next-level craziness right here. The future is pretty cool.



### 8. ~~Smartphone Support~~
As discussed, we're dropping support for Smartphones. But there are consequences!

You should no longer use @media rules in your CSS, ideally. You should be able to make everything work well with `%` units and other "fluid" techniques. If this is too difficult, please ask for help.

We've also removed column orientation from cd-row. Any `col="blah"` attributes are ignored. For a complete list of current cd-row attributes, check the documentation below on [cd-row](#cd-row).


### 9. ~~Non-Standard SCSS Variables~~
We've standardized all the variables you'll use in your SCSS. For a complete list, check the documentation below on [SCSS Variables](#scss-variables).


### 10. ~~SCORM~~
We no longer support environments other than LBS. If we need to do another big content project, we'll extend cd-module to support that at that time.


### 11. ~~IE9~~
In addition to dropping support for IE9, we're also no longer checking whether the user's browser is good enough to run our stuff (since the code needed to do that was NOT light). LBS will serve as the gatekeeper, withholding our content from unworthy browsers.


### 12. ~~SWFs~~
SWF support has been removed from cd-module. If you need to use a SWF in a module, please talk to Ivan.


### 13. ~~`<main>`~~
Using multiple `<main>` elements was a violation of the HTML spec. In v2, you must use `<cd-main>`, and many of the new features depend on it.


### 14. ~~Audio~~
Audio is temporarily removed, as part of killing the HUD. In the future, it will be added back.


### 15. ~~cd-foundation~~
We now have [cd-library](https://github.com/cdig/cd-library), which is a better version of the same idea.



<br>
<br>
<br>
## Planned For v3+

### Audio
This is an open issue.. not sure the right way to solve it. Doing speaker icons per-main might be.. too much visual noise, if they're in context. Perhaps, they can sit just outside the cd-main, off to the right. That might be a nice spot for other UI elements, too, like the score indicator.

### New Score Animation
Perhaps, little effervescent bubbles that float up and disappear. I seem to like bubbles.

### Scroll-Driven Animations
This includes giving something sticky positioning, but changing its state as you scroll.

### Production builds
No sourcemaps, perhaps some URL rewriting with asset fingerprinting.

### Even Better Performance
We could do some of these things, maybe:

* Lazy load images based on scroll position
* Adapt things that read/write the DOM to work assuming an async/lazy page environment
* Load activities just-in-time, rather than up-front

### Integration
Modules work well as standalone, isolated pieces of content, but that's not the ambition. We want modules to be aware of their surroundings, and both pull in elements of their environment, and offer aspects of themselves for outside use.

* Support for standardized metadata (title, description, icon, etc) that can be automatically discovered and used in menus, link previews, etc
* A standard for GUI elements provided by the environment (eg: an LBS header and footer that bookends the module, or a floating HUD provided by a launcher — NOT baked into the module itself)
* Tight integration with Hyperzine as a source of media assets
* Tight integration with the data lake / scoring services for storing and displaying facts from the user's history



<br>
<br>
<br>
## Documentation


### Browser Support
We support: `last 5 Chrome versions, last 2 ff versions, IE >= 10, Safari >= 8, iOS >= 8`. We'll probably bump this spring 2016, depending on how Edge adoption goes. We're supporting quite a few Chrome versions, because I'm not convinced that our users run Chrome often enough to stay reasonably up-to-date. This should only affect code volume (because of prefixes), not behavior.



### Naming Conventions

#### 1. CSS Classes are for Content Styling
Classes are reserved for styling content. Don't use them as hooks for JS, and don't use them in low-level systems. If you must use a class for a non-content purpose, namespace it with the exact name of your system.

#### 2. HTML Attributes are for JS Services
Attributes on elements are reserved for JS and low-level systems. The JS targeting an attribute should enhance the element, but not do anything too crazy. Attributes should be namespaced with the name of the system.

#### 3. Custom Elements are for Components
Custom elements are reserved for components (html + css + js). All bets are off for anything inside a custom element — the JS has total freedom to wildly manipulate the element, restructure any internal DOM, introduce styling, etc.

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
1003    | scroll-hint               | ScrollHint
2000    | cd-hud                    | cdHUD
10000   | editor-container textarea | [Editor](https://github.com/cdig/editor)

* call-outs have been given a z-index of ~100 so that you can layer content above or below them.



### Module Project Folder
Your **module project folder** contains everything needed to build your module.

File or Folder      | Who Uses It     | Purpose
--------------------|-----------------|----------------
bower_components/   | bower & gulp    | Boilerplate HTML, CSS, and JS.
bower.json          | bower           | Tells bower what components to install.
gulpfile.coffee     | gulp            | Tells gulp how to compile the module.
node_modules/       | gulp & npm      | Plugins for gulp, installed by npm.
package.json        | npm             | Also tells npm what gulp plugins to install.
public/             | browsers & gulp | The compiled module. Don't change anything in here.
resources/          | You             | Raw art assets.
source/             | You             | All the content for this module.
source/index.kit    | You             | Ties together all the page HTML files.

You are *encouraged* to organize the `source` folder however you'd like.

#### Where should my module project folder live?
The "official" copy of the module project should live in `Dropbox/Client Projects/LunchBox Sessions/cd-modules`.
When you're working on a module, it's safe to make a *copy* of the project folder outside of Dropbox, if you'd prefer.
When you're done, please make sure the Dropbox copy is up-to-date. Ivan and Sean may need to make changes to it (though they'll always ask first). Do not add the module to Hyperzine.




### Terminal Commands
Command        | Description
--------------:|--------------------------
bower update   | Downloads files for cd-module into bower_components
cd             | "change directory" aka: go to a folder
gulp           | Compiles the module & starts browser sync
gulp update    | Updates the gulpfile (which tells gulp what to do)
npm install    | Downloads files for gulp into node_modules

Once `gulp` is running, you need to press `control-c` to stop it.



### Configuration API
cd-module allows for configuration via the [Config](https://github.com/cdig/cd-library#config) system, with the following values:

Name               | Type            | Purpose
-------------------|-----------------|----------------
dev                | Boolean         | If true, the module runs in dev mode (Editor, etc)
hide-hud           | Boolean         | If true, we make the HUD invisible

Ha. Not much at the moment. More to come!




### SCSS Variables
Here's a complete list of SCSS variables in cd-module v2. These variables are provided by the [lbs-pack](https://github.com/cdig/lbs-pack). The definitive source file is [here](https://github.com/cdig/lbs-pack/blob/v2/pack/styles/vars.scss).

```scss
// SIZES
$maxPageWidth: 64rem;
$maxLineLength: 42em;
$iPadLandscape: 1024px;
$iPadPortrait: 768px;

// SHADE
$white:  white;
$silver: hsl(210,  12%, 80%);
$grey:   hsl(210,   9%, 52%);
$smoke:  hsl(210,  12%, 26%);
$black:  black;

// KEY
$red:    hsl(  2,  75%, 53%);
$orange: hsl( 25, 100%, 59%);
$yellow: hsl( 43, 100%, 50%);
$green:  hsl(130,  85%, 35%);
$blue: 	 #0063be; // approximately hsl(209, 100%, 37%);
$indigo: hsl(270,  50%, 58%);
$violet: hsl(330,  55%, 50%);

// ALT
$teal:   hsl(180, 100%, 29%);
$mint:   hsl(153,  80%, 41%);
$pink:   hsl(357, 100%, 75%);
$brown:  hsl( 23,  40%, 46%);
$navy:   hsl(235,  52%, 22%);
$maroon: hsl(359,  65%, 40%);
```


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


### cd-main
This standard element marks a major unit of content within a page.
You may include as many `<cd-main>` elements within the page as you'd like,
to break up the flow of the page into nice units.
Most of the content of your module — text, images and games — will go inside the `<cd-main>` element.
But you are also free to place content outside of the `<cd-main>` element.
This can be used to create full-width "hero" content, which will stretch edge-to-edge on mobile.
This is a great way to showcase beautiful photos.

```html
<cd-page id="my-amazing-page">
  <cd-main>
    <!-- content -->
  </cd-main>
  
  <img src="image/hero.png">
  
  <cd-main>
    <!-- content -->
  </cd-main>
  
</cd-page>
```

**Requirements:**
* The cd-main element must be a direct child of a cd-page.


### cd-row
`<cd-row>` uses flexbox to create a dynamic multi-column layout. In this example, the three images will all appear side-by-side.

```html
<cd-row>
  <img src="image/puppy-1.jpg">
  <img src="image/puppy-2.jpg">
  <img src="image/puppy-3.jpg">
</cd-row>
```

Quick thing to note (which will be explained later): currently having a video inside of cd-row requires that video to be embedded within a div in order to work inside of IE.

#### Attributes

**Container — X Alignment:**
These attributes are applied to the cd-row element directly, and determine what happens when the items in the row aren't wide enough to occupy all available space in the row.

Example: `<cd-row row="space-between">`<br>
Default: `center`

Attribute     | Visual  | Description
-------------:|:-------:|------------------
center        | -abc-   | Items in the center, extra space on both sides.
left          | abc-    | Items to the left, extra space at the right.
right         | -abc    | Items to the right, extra space at the left.
space-around  | -a-b-c- | Extra space evenly split between items and around the outside.
space-between | a-b-c   | Extra space evenly split between items, but not around the outside.


<br><br>
**Container — Height & Y Alignment:**
These attributes are applied to the cd-row element directly, and determine what happens when the items in the row have differing heights. In pretty much all cases, the cd-row takes the height of the tallest element.

Example: `<cd-row row="top">`<br>
Default: `center`, or `top` if the cd-row has `class="text"`

Attribute | Description
---------:|------------------
center    | Items aligned at their vertical centers, ragged at the top and bottom. Good for rows of graphics.
top       | Items aligned at the top, ragged at the bottom. Good for rows of paragraphs.
bottom    | Items aligned at the bottom, ragged at the top.
baseline  | Items aligned at their text baseline. Good for single words of text.
stretch   | The height of row contents is stretched, matching the largest item. Good for boxes with a background color.


<br><br>
**Item — Width:**
These attributes are applied to the row items individually, and control their widths.

Example: `<div row="Sx">`<br>
Default: `1x`

Attribute                               | Description
---------------------------------------:|------------------
1x 2x 3x 4x 5x                          | Dynamic widths. These sizes specify how wide the item should be, relative to an item that's "1x". Items will then be scaled to fit in the available space. For instance, if you have one item that's 2x and one item that's 3x, it'll be like you've used a 5-column grid.
1/2 1/3 2/3 1/4 2/4 3/4 1/5 2/5 3/5 4/5 | Fractional widths. These sizes FORCE the item to be a certain fraction of the width of the cd-row. By using these sizes, you can have a row that doesn't use all the available width. This is desirable if you're using any of the fancy container sizing options described above. You can also make a row that's too wide — don't do this. To avoid rounding errors, it's better to use the dynamic widths if you're going to have content that actually fills the row.
Sx                                      | Content-based width. This one is very powerful. Rather than sizing based on the available space, this row item will take its width from its own content. This sizing rule works great with dynamic widths, and *sometimes* works okay with fractional widths (though you might risk the row becoming too wide).


<br><br>
**Item — Height & Y Alignment:**
These attributes are applied to the row items individually, and control their vertical size and positioning.

Example: `<div row="top">`<br>
Default: `center`

Attribute | Description
---------:|------------------
center    | The item's center is aligned with the center of the row's height.
top       | The item's top is aligned with the top of the row's height.
bottom    | The item's bottom is aligned with the bottom of the row's height.
baseline  | The item is aligned at the row's text baseline.
stretch   | The height of the item is stretched, matching the height of the row. If the item is the tallest in the row, then this (usually) has no effect.


<br><br>
**Item — Ordering:**
These attributes let you arrange the row items in a different order than they appear in your HTML. If two items have the same order, they'll take their order from the HTML.

Example: `<div row="2nd">`<br>
Default: `1st`

Attribute | Description
---------:|------------------
1st       | First (Default)
2nd       | Second
3rd       | Third
4th       | Fourth
5th       | Last



<br>
<br>
<br>
## Troubleshooting

This section is a work-in-progress. In the future, as we diagnose and resolve issues, Ivan will populate this section with good advice accordingly.

#### I ran `gulp` and got an error

Try the following steps in order. After each step, check to see if it fixed the problem by running `gulp`.

* Delete the `node_modules` folder, then `cd` into your project and run `npm install` (takes a few minutes).
* Ask Ivan for help :(

#### My v1-to-v2 upgrade failed

1. Is your computer plugged in?
2. Did you `cd` into the correct folder?
3. Do you have a working internet connection?
4. Delete the `node_modules` folder, then retry [Chapter Two](#chapter-two)
5. Delete your v2 module project folder, and [start the upgrade process over again](#upgrading-an-existing-v1-module).
6. Ask Ivan for help :(



<br>
<br>
<br>
## License
Copyright (c) 2014-2015 CD Industrial Group Inc. http://www.cdiginc.com
