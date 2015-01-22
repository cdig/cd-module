# cdModule
A framework and standard library for CDIG modules, to make our modules look nice and act consistently.

### Table of Contents

- [Quick Start](#)
- [Tutorial](#)
- [Documentation of Decisions](#)
  - [_project](#)
  - [Z-indexes](#)
- [Included Features](#)
  - [Libs](#)
  - [Components](#)
  - [Scripts](#)
  - [Styles: Custom](#)
  - [Styles: Elements](#)
  - [Styles: Mixins](#)

# Quick Start

### How do I use it?
Grab the [module template](https://github.com/cdig/cd-module-template) and rock out. Or, if you want a more thorough introduction, keep reading.

### What's included?
A carefully chosen set of HTML, styles, scripts that build on top of [cdFoundation](https://github.com/cdig/cd-foundation). We take care of the look-and-feel, so you can focus on the content.

### What's not included?
* Anything specific to an individual client belongs in an `_project` folder, outside your module. More details [here](#_project).
* cdFoundation itself. It's listed as a bower dependency, but you need to make sure to include it in your module. The [module template](https://github.com/cdig/cd-module-template) covers this.


# Tutorial

Here's a brief overview of how to use some of the features in cd-module.
First, I'll present the markup for a typical page in a module.
Following that, [Lisa](https://www.youtube.com/watch?v=Plz-bhcHryc) will tear it apart.

#### Example Page

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

#### cd-page

```html
<cd-page id="my-amazing-page">
```

First of all, we open up a new page.
Pages include their own default styling, and are used by some of the [scripts](#Scripts) to add special behaviour.
We give this page an id, which must be unique within the module.
This id is used as the display name of the page in the [page-switcher](#), so make it nice.

#### main

```html
  <main>
```

Inside the page, we have a `main` element.
This element creates a grouping of content within the page, and visually establishes the white padded background behind the content.
You are free to place content — in particular, images — outside of the `<main>` element.
This can be nice to create full-width image, which will stretch edge-to-edge on mobile.
You may include as many `<main>` elements within the page as you'd like.


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


# Documentation of Decisions

## _project

For the time being, it's assumed that **modules** belong to a **chapter**, which belongs to a **project**.
Even if your module doesn't really fit this model, you might want to pretend that it does, to make things easier.
*This constraint will be lifted once [this issue](https://github.com/cdig/imagineering/issues/1) is addressed.*

For the time being, you'll need to do one of two things.

### Option A: fake the folder structure
Make your folder structure look like this:

```
.
├── _project
└── fake-chapter-folder
    ├── your-module
    └── your-other-module
```

### Option B: change the import paths
If you don't want to use the above folder structure, you can change the import paths used by your module. You'll need to change imports in the `index.html` and `styles.scss` files.

Anywhere that you see something like...

```html
<!-- @import ../../../_project/[...].kit -->
```

Or...

```scss
@import '../../../_project/[...].scss';
```

Replace the `../../../_project` part with the relative path from the current file to your _project folder. For instance, if your module folder is next to your _project folder, you'll use `../../_project`


## Z-indexes

* 10: `call-out[open]` (Call Outs)
* 1000: `cd-modal` (Modal Popup)
* 1001:	`page-switcher` (Switcher Container)
* 1002: `cd-hud` (HUD)
* 2000: `score-area` (Score Animation)
* 9999: `.browser-support` (Browser Support)
* 10000: `editor-container` textarea (Editor)




# Included Features


## Libs

### [Modernizr](https://modernizr.com)
Modernizr works with browser-support to warn users when they're using an unsupported browser.

### [SwfObject](https://github.com/swfobject/swfobject)
SwfObject gives us a standards-compliant way to embed SWFs, with the help of cd-swf (see below).

Note: At some point in the future, we need to figure out how to (automatically?) use CDN-hosted libs in production, for the sake of caching.


## Components

### backend-reset-button
If you're using BackendLocalStorage, shows a Reset button in the HUD, which clears LocalStorage.

### browser-support

### call-outs

### cd-swf
Add this attribute to an `<object>` tag. It'll get picked up by [SwfObject](#SwfObject) and embed the SWF in a standards-compliant way. Your SWF will also be wrapped for easy 2-way communication with JS, and support for awarding points will be added automatically.

```html
<object cd-swf="flash/media.swf"></object>
```

Notes:

* Your SWF ***MUST*** have the CDIG class (or a subclass, like Schematic).
* You must include `js-wrapper.swf` in your `public/flash` folder. Find it here: `Dropbox/Assets and Resources/Tools/js-wrapper/js-wrapper.swf`.
* If you are using `<cd-activity>` to award points from a SWF, you need to make the activity name match the name of the SWF. The object and the cd-activity just have to appear on the same page; they don't need to be nested. See the [Tutorial](#Tutorial) for an example.

### hud

### modal-popup

### page-locking

### page-switcher

### score-animation

### scroll-hint


## Scripts

### Backend: LocalStorage

### Backend: SCORM 2004

### Easing

### Flash Interface

### KV Store

### Matches Selector

### Page Audio

### Page Manager

### Page Scroll Watcher

### Page Title

### Pages

### Params Service

### Save Before Unload

### Save With Popup

### Scoring

### Scroll Regions

### Scroll To

### Welcome Popup


## Styles: Custom
TODO: These are an awful lot like components... but they're different from *real components. They're to be used in the content; they're not part of the foundational system. We may have a crisis of naming here.

### cd-activity

### cd-flow-arrow

### cd-page

### cd-row

### cd-text-bubble


## Styles: Elements

### body

### figure

### headings

### img

### lists

### main

A major grouping of content within a page. See the [Tutorial](#main) for more detail.

### object

### p


## Styles: Mixins

### magic-underlines


# License
Copyright (c) 2014-2015 CD Industrial Group Inc., released under MIT license.

Table of contents generated with [DocToc](http://doctoc.herokuapp.com/), so thanks to whoever made that.
