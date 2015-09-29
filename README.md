# cd-module v2

### WORK IN PROGRESS — DO NOT USE

A major revision is happening in this v2 branch. Master will be left alone to serve as the v1 branch. In the far future, when all existing modules are updated or abandoned, we can resume using master as the branch for ongoing development.



# Upgrade Path [Draft]

Here's how you'd upgrade a v1 module to v2. These commands will rewrite a number of files in your module, so be prepared for breaking changes. Have a backup, and test your upgraded module.

1. Open the Terminal, and `cd` into your module folder
2. Run the following. To save time, just copy-paste the whole block, including the comment *and the empty line at the end!*

    ```bash
    curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/package.json > package.json
    curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/gulpfile.coffee > gulpfile.coffee
    curl -fsS https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/.gitignore > .gitignore
    npm install
    gulp evolve
    bower update && bower prune && bower update
    # DONE
         
    ```

3. After you paste it in to your Terminal, stuff will start running. When it's done, it'll tell you at the bottom of the Terminal.
4. Run the `gulp` command, and test your upgraded module.

# Major Changes


### ~~Codekit~~ Gulp!
We're killing CodeKit, and switching to Gulp. When it's time to work on a module, just run the following command on your Terminal:

```bash
gulp
```

That'll start watching and rebuilding your .coffee, .kit, and .scss files. It'll open a browser window to the right address. (TODO: Use the same URL/port as CodeKit).

### Asset Packs
The built-in styling is almost completely neutral. It is designed as an abstract styling interface. It includes a thin reference implementation, using our new company colors and Lato (and any other fonts or styles that are used in EVERY module). You can make and install Asset Packs to unlock other colors and fonts. Asset Packs build on the initial abstraction and override the reference implementation, or introduce new elements in addition to the built in ones.

```scss
// Eg: The base styling can provide a suite of colours by name and by role, with helper classes:

// By name
.blue-text // cdig blue text
.navy // LBS navy background

// By role
.primary // cdig blue background
.primary-text // cdig blue text
.secondary // LBS orange
.accent // LBS yellow
.accent-text // LBS pink

// Then, in a different Asset Pack, we can override the color SASS variables, helper classes, semantic names:

// By name
.blue-text // SLB blue text
.navy // LBS navy background (fallback if not specified)

// By role
.primary // white background
.primary-text // cdig blue text
.secondary // LBS orange
.accent // LBS yellow
.accent-text // LBS pink
```

Here's an outline of features we might want:

* Can contain CSS, JS, Fonts, SVGs. Maybe Images (depending on perf hit — might as well try it!). Eventually, HTML components (if we ever start using them). Should also be able to include SVGActivities.
* Assets live in specifically named folders
* Gulp adds the contents of these folders to the right compilation pipeline.
* Replaces _project and a lot of the "Russian doll"-style import setup from V1.
* Should be easy for the team to create on their own packs.
* Installed with something that lets us shrinkwrap (bundler?).
* In CSS and JS, must use a consistent theme for selectors. Maybe using attributes? Naming like: ap-lbs-caution-box or lbs-caution-box or trican-brown-text. Maybe, as a rule, disallow global styles?
* We want the ability to see diffs between versions when upgrading, so we know if any breaking changes occurred, and what changes to make to fix them. Manual changelogs would be a pain, but on "real" dev teams this is the norm.


### HUD's Dead
It's a usability nightmare. It did offer some nice functionality, though.
* Audio will be in-context. People will need to click on the little speaker buttons. If people are too lazy to do that, then they're too lazy to learn!
* Page navigation is going away. Sorry! It was nice, but not THAT nice.
* For getting "back" to the "menu", we'll figure out some sort of integration with LBS, perhaps at the top and bottom of modules.


### Improved Primitives
We need to revisit what primitives we're using, why, and how: cd-row / cd-map / center-block / etc.

Ideas for new primitives:
* Some sort of grid layout primitive, that supports stacking
* Some sort of drag-and-drop grid layout primitive



# Minor Changes


### Simplified Scoring
In preparation for our upcoming LBS scoring service, a lot of the existing scoring/points behavior has been reduced to a minimum.


### LBS Only
We don't support environments other than LBS. If we need to do another big content project, we'll extend cd-module to support that at that time.


### IE10+ only
We don't need Modernizr or UAParser. The LBS site will serve as gatekeeper.


### SWFs Considered Harmful
SWF support has been removed from cd-module. If you need to use a SWF in a module, please install [cd-swf-pack](/cdig/cd-swf-pack). If you try to use a SWF without the pack installed, we should issue a warning.


### Smartphone Support Dropped
As discussed.


### Merge cd-foundtaion into cd-module
If we have other projects that need to use Env or Ease or other features, they can grab those libs a la carte. A lot of those libs, though, are only of interest to cd-module, and should just be merged in. If we find we want to use them in a lot of other projects, we can duplicate the code for the time being (duplication hell > dependency hell), and extract what's needed when it would demonstrably save us pain.


### Better APIs

#### CSS
Classes should be for styling, and that's it. The naming scheme will be decided as I figure out the right interface for Asset Packs (see below).

#### JS
Attributes should be for JS, and that's it. This JS should enhance the element, but not do anything too crazy or introduce possibly conflicting styling. Attributes should adopt an `x-blah` naming scheme, so we don't need to use silly "cd-blah" prefixes. The exception to all this is attributes on a component (custom element) — they can use whatever names they want, and the meaning of those attributes is defined by the component.

#### Components
Custom elements should be for components (html + css + js), and that's it. All bets are off for anything inside a custom element — the JS has total freedom to wildly manipulate the element, restructure any internal DOM, introduce styling, etc.

A lot of the scripts available to cd-module v1 are implementation details (Pages, PageScrollWatcher, PageAudio, etc). We should go private by default, and only open things up for module developer's to use if need be.


### Progressive Enhancement
As I'm rewriting all the cd-module scripts, I should make sure things exhibit the load time and runtime characteristics I want.
* The initial time-to-first-page is crushed as far below 1 second as possible. Scripts that build-up fancy behaviour run after there's already content on the page. These scripts should be idempotent, so that pages/content can be freely added or removed at any time. These scripts should be well-targeted, so that non-module content can be dynamically added in and around module content, without conflict.
* Aggressively pursue better HTTP performance — better use of cache-friendly modules, balanced against the benefits of concat+min. Likewise, pursue CDN support.


### Runtime Performance
* Remove not-visible pages from the DOM and halt execution of their scripts (might need to establish special APIs around this; thus, breaking change), to see if it helps perf on low-power devices like A5 iPads.


### Crushing Issues
* Better page locking. Activities should lock on themselves (rather than the cd-page they're inside of). You should be able to move the lock point to a different place in the markup. You should be able to create a lock point and trigger, which can be controlled from module code (eg: you have to click a button 5 times to unlock the next bit of content — not something that warrants a full cd-activity).
* Etc (see issues added to the v2 milestone)

# Documentation

### Browser Support
We support: `last 2 Chrome versions, last 2 ff versions, IE >= 10, Safari >= 8, iOS >= 8`. We'll probably bump this spring 2016, depending on how Edge adoption goes.

# License
Copyright (c) 2015 CD Industrial Group Inc., released under MIT license.
