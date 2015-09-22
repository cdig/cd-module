# cd-module v2

### WORK IN PROGRESS — DO NOT USE

A major revision is happening in this v2 branch. Master will be left alone to serve as the v1 branch. In the far future, when all existing modules are updated or abandoned, we can resume using master as the branch for ongoing development.

# Upgrade Path [Draft]

Here's how you'd upgrade a v1 module to v2. Note, be prepared for breaking changes to your module — they should be few, but they will happen. This will run a bower-update.

#### Step 1
In the Terminal, `cd` into your module folder, and run: `bower update && bower uninstall cd-module --save --force && rm -rf ./bower_components && bower install cdig/cd-module#v2 --save && bower update`

If it says `Unable to find a suitable version for cd-module, please choose one`, you need to choose the one that starts with `cd-module#v2` and type that prefixed with an exclamation point. For instance:

```bash
Unable to find a suitable version for cd-module, please choose one:
    1) cd-module#* which resolved to 7c41825bb1 and is required by q-n-eh#ef30a5e43e
    2) cd-module#v2 which resolved to 43df4e2827Prefix the choice with ! to persist it to bower.json
```

You'd type `!2` and hit enter.

#### Step 2
If you have `"_project": "cdig/lbs-project"` in your bower.json, run: `bower uninstall _project --save && bower install cdig/lbs-pack`

# Major Changes

### LBS Only
We won't worry about environments other than LBS. If we need to do another big content project, we'll extend cd-module to support that at that time.


### IE10+ only
We don't need Modernizr or UAParser. The LBS site will serve as gatekeeper.


### Deprecate SWFs
Remove SWFObject, and discourage use of SWFs. If a SWF needs to be used, cd-swf should be available as an add-on that includes SWFObject (if needed).


### Drop Smartphone Support
As discussed.


### Kill the HUD
It's a usability nightmare. It did offer some nice functionality, though.
* Audio will be in-context. People will need to click on the little speaker buttons. If people are too lazy to do that, then they're too lazy to learn!
* Page navigation is going away. Sorry! It was nice, but not THAT nice.
* For getting "back" to the "menu", we'll figure out some sort of integration with LBS, perhaps at the top and bottom of modules.


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


### Asset Packs [Draft]
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


### Codekit -> Gulp
We're killing CodeKit, and switching to Gulp. Sean will have a foundation for this on Monday.


### Progressive Enhancement
As I'm rewriting all the cd-module scripts, I should make sure things exhibit the load time and runtime characteristics I want.
* The initial time-to-first-page is crushed as far below 1 second as possible. Scripts that build-up fancy behaviour run after there's already content on the page. These scripts should be idempotent, so that pages/content can be freely added or removed at any time. These scripts should be well-targeted, so that non-module content can be dynamically added in and around module content, without conflict.
* Aggressively pursue better HTTP performance — better use of cache-friendly modules, balanced against the benefits of concat+min. Likewise, pursue CDN support.


### Improved Primitives
We need to revisit what primitives we're using, why, and how: cd-row / cd-map / center-block / etc.


### Runtime Performance
* Remove not-visible pages from the DOM and halt execution of their scripts (might need to establish special APIs around this; thus, breaking change), to see if it helps perf on low-power devices like A5 iPads.


### Crushing Issues
* Better page locking. Activities should lock on themselves (rather than the cd-page they're inside of). You should be able to move the lock point to a different place in the markup. You should be able to create a lock point and trigger, which can be controlled from module code (eg: you have to click a button 5 times to unlock the next bit of content — not something that warrants a full cd-activity).
* Etc (see issues added to the v2 milestone)


# License
Copyright (c) 2015 CD Industrial Group Inc., released under MIT license.
