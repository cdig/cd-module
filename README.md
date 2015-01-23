# cdModule
HTML, styles, and scripts that build on top of [cdFoundation](https://github.com/cdig/cd-foundation).
We take care of the look-and-feel, so you can focus on the content.

To get started, grab the [module template](https://github.com/cdig/cd-module-template).
You'll also need a [_project folder](#_project).

- [Overview](#overview)
- [Design Decisions](#design-decisions)
  - [_project](#_project)
  - [Z-indexes](#z-indexes)
- [Features](#features)
  - [Components](#components)
  - [Scripts](#scripts)
  - [Styles](#styles)
  - [Libs](#libs)

# Overview
Let's look at the markup for a typical page in a module.

```html
<cd-page id="my-amazing-page">
  <main>
    <h1>My Amazing Page</h1>
    
    <p>On this page, we'll look at things that are cute!</p>
    
    <cd-row>
      <img src="image/puppy-1.jpg">
      <img src="image/puppy-2.jpg">
      <img src="image/puppy-3.jpg">
    </cd-row>
    
    <cd-activity name="kittens-are-great" type="tile-game" points="100">
      <img src="image/kitten-1.jpg">
      <img src="image/kitten-2.jpg">
    </cd-activity>
    
    <h2>Phew. Now I'm all cute-ed out. Let's look at something ugly: Flash.</h2>
    
    <object cd-swf="flash/ugly-old.swf"></object>
  </main>
</cd-page>
```

Now, let's tear it apart, [Lisa](https://www.youtube.com/watch?v=Plz-bhcHryc).

#### cd-page

```html
<cd-page id="my-amazing-page">
```

First of all, we open up a new page.
Pages include their own default styling that puts them in a centred column with lots of top and bottom margin.
They are also used by some of the [scripts](#scripts) to add special behaviour.
We give this page an id, which must be unique within the module.
This id is used as the display name of the page in the [Page Switcher](#page-switcher), so make it nice.

#### main

```html
  <main>
```

Inside the page, we have a main element.
This element creates a grouping of content, and visually establishes the white padded background behind the content.
You may include as many main elements within the page as you'd like, to break up the flow of the page into nice units.
You are also free to place content — in particular, images — outside of the main element.
This can be nice to create full-width image, which will stretch edge-to-edge on mobile.

```html
    <h1>My Amazing Page</h1>
```

Within a module, h1 elements get special styling, with [Magic Underlines](#magic-underlines).
You should only use h1 for the title of a page.

```html
    <p>On this page, we'll look at things that are cute!</p>
```

As with all content incorporating the [cd-reset](https://github.com/cdig/cd-reset), paragraph tags are selectable.
So, use them for text that the user might like to select and copy-paste,
and don't use them for things that shouldn't be selectable — interactive elements, UI, or parts of a graphic.

```html
    <cd-row>
      <img src="image/puppy-1.jpg">
      <img src="image/puppy-2.jpg">
      <img src="image/puppy-3.jpg">
    </cd-row>
```

Under the hood, cdRow uses flexbox to create a multi-column layout.
In this example, the three images will all appear side-by-side.
Check out the section on [cdRow](#cdrow) for more info.

```html
    <cd-activity name="kittens-are-great" type="tile-game" points="100">
      <img src="image/kitten-1.jpg">
      <img src="image/kitten-2.jpg">
      <img src="image/kitten-3.jpg">
    </cd-activity>
```


```html
    <object cd-swf="flash/ugly-old.swf"></object>
```


# Design Decisions

## _project

For the time being, it's assumed that **modules** belong to a **chapter**, and chapters belong to a **project**.
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

* 10: `call-out[open]` ([Call-Outs](#call-outs))
* 1000: `cd-modal` ([Modal Popup](#modal-popup))
* 1001:	`page-switcher` ([Switcher Container](#switcher-container))
* 1002: `cd-hud` ([cdHUD](#cdhud])
* 2000: `score-area` ([Score Animation](#score-animation))
* 9999: `.browser-support` ([Browser Support](#browser-support))
* 10000: `editor-container` textarea ([Editor Container](#editor-container))




# Features


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
* If you are using `<cd-activity>` to award points from a SWF, you need to make the activity name match the name of the SWF. The object and the cd-activity just have to appear on the same page; they don't need to be nested. See the [Overview](#Overview) for an example.

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

A major grouping of content within a page. See the [Overview](#main) for more detail.

### object

### p


## Styles: Mixins

### magic-underlines


# License
Copyright (c) 2014-2015 CD Industrial Group Inc., released under MIT license.

Table of contents generated with [DocToc](http://doctoc.herokuapp.com/), so thanks to whoever made that.
