# cd-module v2
A Framework for LBS Lessons

### Table of Contents

- [Starting A New v2 Module](#starting-a-new-v2-module)
- [Upgrading An Existing v1 Module](#upgrading-an-existing-v1-module)
- [What's New In v2?](#whats-new-in-v2)
- [Planned For v3+](#planned-for-v3)

Documentation can be found in the Wiki: https://github.com/cdig/lunchboxsessions/wiki


<br>
<br>
## Starting A New v2 Module

There's a great writeup in the Wiki: https://github.com/cdig/lunchboxsessions/wiki/How-To-Make-a-Module


<br>
<br>
<br>
## Upgrading An Existing v1 Module

### READ_ME_FIRST.txt

Open Terminal and run `nvm current`. If it displays something less than `v5.3.0`, please run the following commands one at a time:

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

1. Open the Terminal, and `cd` into your module folder. Triple-click the following line, and paste it into the Terminal.
  ```bash
  rm -rf node_modules gulpfile.js gulp-svg.coffee && curl -fsS https://raw.githubusercontent.com/cdig/cd-module-starter/v2/dist/package.json > package.json && curl -fsS https://raw.githubusercontent.com/cdig/cd-module-starter/v2/dist/gulpfile.coffee > gulpfile.coffee && curl https://lunchboxsessions.s3.amazonaws.com/static/cd-module/node_modules.zip > node_modules.zip && unzip -nq node_modules.zip && rm node_modules.zip && npm update && gulp to-the-future
  ```
2. Paste it in to your Terminal. Stuff will start running. After about 30 seconds, the upgrade process will finish.
3. If you see "Your jacket is now dry", then the upgrade succeeded! You're ready to ~~ride your hoverboard~~ get to work on your v2 module. Otherwise, please consult the [upgrade failed](#my-v1-to-v2-upgrade-failed) troubleshooting guide.

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
## License
Copyright (c) 2014-2015 CD Industrial Group Inc. http://www.cdiginc.com
