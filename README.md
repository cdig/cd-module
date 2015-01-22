# cdModule
A standard library for CDIG modules.


#### What's included?
cdModule gives you a carefully chosen set of styles, scripts, and HTML components, to make all our modules look and act consistently.


#### What's not included?
* Anything specific to an individual project or client belongs in an _project, to be shared by all modules in the project.
* cdFoundation stuff. It's listed as a bower dependency, but you need to make sure to include it in your module. The [module template](https://github.com/cdig/cd-module-template) covers this.

#### How do I use it?
Consult the [module template](https://github.com/cdig/cd-module-template) and seek the wisdom of its way.


## Tutorial

Here's a brief overview of how to use some of the features in cd-module. First, I'll present the markup for a typical page in a module. Below, [Lisa](https://www.youtube.com/watch?v=Plz-bhcHryc) will tear it apart.

```html
<cd-page id="my-amazing-page">
  <main>
    <h1>My Amazing Page</h1>
    
    <p>On this page, we'll look at things that are amazing. Let's start with puppies.</p>
    
    <cd-row>
      <img src="image/puppy-1.jpg">
      <img src="image/puppy-2.jpg">
      <img src="image/puppy-3.jpg">
    </cd-row>
    
    <p>That was pretty great. Now, let's play a game with kittens.</p>
    
    <cd-activity name="kittens-are-great" type="tile-game" points="100">
      <img src="image/kitten-1.jpg">
      <img src="image/kitten-2.jpg">
      <img src="image/kitten-3.jpg">
    </cd-activity>
    
    <p>Phew. Now I'm all cute-ed out. Let's look at something ugly: Flash. How do you deal with old Flash content?</p>
    
    <object cd-swf="flash/ugly-old.swf"></object>
    
    <p>What if that Flash needs to award points?</p>
    
    <cd-activity name="i-get-the-point" points="1"></cd-activity>
    <object cd-swf="flash/i-get-the-point.swf"></object>
    
  </main>
  
</cd-page>

```

Alright, let's dig in!

```html
<cd-page id="my-amazing-page">
```

First of all, we open up a new page.
We give this page an id, which must be unique within the module.
This id is used as the display name of the page in the [page-switcher](#page-switcher), so make it nice.


```html
  <main>
    <h1>My Amazing Page</h1>
    
    <p>On this page, we'll look at things that are amazing. Let's start with puppies.</p>
    
    <cd-row>
      <img src="image/puppy-1.jpg">
      <img src="image/puppy-2.jpg">
      <img src="image/puppy-3.jpg">
    </cd-row>
    
    <p>That was pretty great. Now, let's play a game with kittens.</p>
    
    <cd-activity name="kittens-are-great" type="tile-game" points="100">
      <img src="image/kitten-1.jpg">
      <img src="image/kitten-2.jpg">
      <img src="image/kitten-3.jpg">
    </cd-activity>
    
    <p>Phew. Now I'm all cute-ed out. Let's look at something ugly: Flash. How do you deal with old Flash content?</p>
    
    <object cd-swf="flash/ugly-old.swf"></object>
    
    <p>What if that Flash needs to award points?</p>
    
    <cd-activity name="i-get-the-point" points="1"></cd-activity>
    <object cd-swf="flash/i-get-the-point.swf"></object>
    
  </main>
  
</cd-page>

```


## Documentation of Decisions

### Z-indexes

* 10: `call-out[open]` (Call Outs)
* 1000: `cd-modal` (Modal Popup)
* 1001:	`page-switcher` (Switcher Container)
* 1002: `cd-hud` (HUD)
* 2000: `score-area` (Score Animation)
* 9999: `.browser-support` (Browser Support)
* 10000: `editor-container` textarea (Editor)




## Included Features


### Libs

#### [Modernizr](https://modernizr.com)
Modernizr works with browser-support to warn users when they're using an unsupported browser.

#### [SwfObject](https://github.com/swfobject/swfobject)
SwfObject gives us a standards-compliant way to embed SWFs, with the help of cd-swf (see below).

Note: At some point in the future, we need to figure out how to (automatically?) use CDN-hosted libs in production, for the sake of caching.


### Components

#### backend-reset-button
If you're using BackendLocalStorage, shows a Reset button in the HUD, which clears LocalStorage.

#### browser-support

#### call-outs

#### cd-swf
Add this attribute to an `<object>` tag. It'll get picked up by [SwfObject](#SwfObject) and embed the SWF in a standards-compliant way. Your SWF will also be wrapped for easy 2-way communication with JS, and support for awarding points will be added automatically.

```html
<object cd-swf="flash/media.swf"></object>
```

Notes:

* Your SWF ***MUST*** have the CDIG class (or a subclass, like Schematic).
* You must include `js-wrapper.swf` in your `public/flash` folder. Find it here: `Dropbox/Assets and Resources/Tools/js-wrapper/js-wrapper.swf`.
* If you are using `<cd-activity>` to award points from a SWF, you need to make the activity name match the name of the SWF. The object and the cd-activity just have to appear on the same page; they don't need to be nested. See the [Tutorial](#Tutorial) for an example.

#### hud

#### modal-popup

#### page-locking

#### page-switcher

#### score-animation

#### scroll-hint


### Scripts

#### Backend: LocalStorage

#### Backend: SCORM 2004

#### Easing

#### Flash Interface

#### KV Store

#### Matches Selector

#### Page Audio

#### Page Manager

#### Page Scroll Watcher

#### Page Title

#### Pages

#### Params Service

#### Save Before Unload

#### Save With Popup

#### Scoring

#### Scroll Regions

#### Scroll To

#### Welcome Popup


### Styles: Custom
TODO: These are an awful lot like components... but they're different from *real components. They're to be used in the content; they're not part of the foundational system. We may have a crisis of naming here.

**cd-activity

**cd-flow-arrow

**cd-page

**cd-row

**cd-text-bubble


### Styles: Elements

**body

**figure

**headings

**img

**lists

**main

**object

**p


### Styles: Mixins

**magic-underlines


## License
Copyright (c) 2014-2015 CD Industrial Group Inc., released under MIT license.
