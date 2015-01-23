# cdModule
A framework and standard library to help you make gorgeous, consistent modules.
We take care of the look-and-feel, so you can focus on the content.

To get started, grab the [module template](https://github.com/cdig/cd-module-template).
You'll also need an [_project folder](#_project-folder). Read on for *extensive* documentation. Grab a drink!






### Table of Contents

- [Overview](#overview)
- [Skin Deep: The Standard Library](#skin-deep-the-standard-library)
  - [cd-page](#cd-page)
  - [main](#main)
  - [h1](#h1)
  - [magic-underlines](#magic-underlines)
  - [p](#p)
  - [cd-row](#cd-row)
  - [img](#img)
  - [cd-activity](#cd-activity)
  - [cd-swf](#cd-swf)
  - [thing](#thing)
  - [thing](#thing)
- [Beneath The Surface: The Framework](#beneath-the-surface-the-framework)
  - [swfobject](#swfobject)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
  - [thing](#thing)
- [Design Decisions](#design-decisions)
  - [_project folder](#_project-folder)
  - [z-index values](#z-index-values)












# Overview

cdModule is *huge*.
It starts with everything in [cdFoundation](https://github.com/cdig/cd-foundation),
then adds hundreds of its own tools, features, and a little sprinkling of magic.

We're going to look at cdModule in two separate halves.
First, we'll look at the tools you will use when making a module — the [standard library](#skin-deep-the-standard-library).
These are primarily HTML components, but there are also a few special styles and scripts to help you make gorgeous content.

Afterward, we'll look at the network of systems that sit underneath — the [framework](#beneath-the-surface-the-framework).
These systems extend cdFoundation, adding all sorts of special behaviour to your modules; from responsiveness, to score animations, to the HUD.

For each item we look at, there'll be a full explanation of features, gotchas, secrets, suggestions, with links to the source code and related items.
The source code links are particularly handy, since the source code is the *definitive* documentation.










# Skin Deep: The Standard Library

Here's the markup for a typical page in a module.
Well, not quite typical — this one includes an example of *everything* in the standard library.
Below, we'll examine each of the components that make up this markup.


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
    
    <h3>Welp, that was fun. What's next?</h3>
    
  </main>
  
  <img src="image/hero.png">
  
  <main>
    <h2>More content</h2>
    <figure>
      <cd-flow-arrow class="cyan"></cd-flow-arrow>
      <cd-flow-arrow class="magenta"></cd-flow-arrow>
      <cd-flow-arrow class="yellow"></cd-flow-arrow>
      <cd-flow-arrow class="dance"></cd-flow-arrow>
    </figure>
    <figcaption>It's a collection of flow arrows. CUTE!</figcaption>
  </main>
  
</cd-page>
```


Now, let's tear it apart, [Lisa](https://www.youtube.com/watch?v=Plz-bhcHryc).



## cd-page

**Source:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/custom/cd-page.scss)

**Usage:**
This custom element is the highest-level grouping of content within a module.
Typically, you'll have one cd-page per file, and import all of these files the `<body>` in
the `index.kit` for your module, as per the [template](https://github.com/cdig/cd-module-template).
The file should have the same name as the `id` of the cd-page.

```html
<cd-page id="my-amazing-page">
  <!-- page content -->
</cd-page>
```

* You must give each page an `id`, which must be unique within the module.

**Behaviour:**
The default styling creates a centred column with lots of top and bottom margin,
with a nice shadow poking out from the corners to establish the vertical flow of the module.
The ID is used for the title of the page in the Page Switcher, and the filename for Page Audio.

**Related:**
[Pages](#pages), [Page Locking](#page-locking), [Page Switcher](#page-switcher),
[Page Audio](#page-audio), [Page Title](#page-title), [Page Scroll Watcher](#page-scroll-watcher).



## main

**Source:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/elements/main.scss)

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

* The main element must be a direct child of a cd-page.

**Behaviour:**
The default styling creates a white padded background behind the content.

**Related:**
[cd-page](#cd-page), [img](#img)



### h1

**Source:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/elements/h1.scss)

**Usage:**
This heading element is used for the title of the page.
It should almost always be the first child of the first `<main>` element in the page.

```html
<cd-page id="my-amazing-page">
  <main>
  
    <h1>My Amazing Page</h1>
  
  </main>
</cd-page>
```

* You should not apply your own styling to the h1 within the module. The styling should come from the [_project folder](#_project-folder).

**Behaviour:**
Within a module, h1 elements get special styling, with [Magic Underlines](#magic-underlines).
You should only use h1 for the title of a page.

Related: [Magic Underlines][#magic-underlines]

### p

```html
    <p>On this page, we'll look at things that are cute!</p>
```

Because cdModule includes the [cd-reset](https://github.com/cdig/cd-reset), paragraph tags are selectable, and all other tags are not.
So, use them for text that the user might like to select and copy-paste,
and don't use them for things that shouldn't be selectable — interactive elements, UI, or parts of a graphic.

### cd-row

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

### img

Image tags, by default have a style of `width: 100%;` applied to them.
Just.. watch out for this.
In practice, it means you can drop an image into your page and not have to worry about it either being too small, or blowing out your layout.

### cd-activity

```html
    <cd-activity name="kittens-are-great" type="tile-game" points="100">
      <img src="image/kitten-1.jpg">
      <img src="image/kitten-2.jpg">
      <img src="image/kitten-3.jpg">
    </cd-activity>
```

### cd-swf

```html
    <object cd-swf="flash/ugly-old.swf"></object>
```

Add this attribute to an `<object>` tag. It'll get picked up by [SwfObject](#SwfObject) and embed the SWF in a standards-compliant way. Your SWF will also be wrapped for easy 2-way communication with JS, and support for awarding points will be added automatically.

Notes:

* Your SWF ***MUST*** have the CDIG class (or a subclass, like Schematic).
* You must include `js-wrapper.swf` in your `public/flash` folder. Find it here: `Dropbox/Assets and Resources/Tools/js-wrapper/js-wrapper.swf`.
* If you are using `<cd-activity>` to award points from a SWF, you need to make the activity name match the name of the SWF. The object and the cd-activity just have to appear on the same page; they don't need to be nested. See the [Overview](#Overview) for an example.


### call-outs

### cd-flow-arrow

### cd-text-bubble

### body

### headings

### lists











# Beneath The Surface: The Framework

Above, we looked at the parts of cdModule that you will work with directly.
Now, we'll dig in to the systems that make up the foundational framework of cdModule.


### [SwfObject](https://github.com/swfobject/swfobject)
SwfObject gives us a standards-compliant way to embed SWFs, with the help of cd-swf (see below).




### backend-reset-button
If you're using BackendLocalStorage, shows a Reset button in the HUD, which clears LocalStorage.

### browser-support

### [Modernizr](https://modernizr.com)
Modernizr works with browser-support to warn users when they're using an unsupported browser.


### hud

### modal-popup

### page-locking

### page-switcher

### score-animation

### scroll-hint

### Backend: LocalStorage

### Backend: SCORM 2004

### Easing

### KV Store

### Matches Selector

### Page Audio

### Page Manager

### Page Scroll Watcher


### Flash Interface

### Page Title

### Pages

### Params Service

### Save Before Unload

### Save With Popup

### Scoring

### Scroll Regions

### Scroll To

### Welcome Popup

### magic-underlines

This special mixin uses a bunch of crazy SCSS to create an iOS-style underline on all browsers/devices.














# Design Decisions

In building cdModule, we've had to make a few judgement calls about how you should make your modules.
We're documenting these decisions here, so you don't accidentally run into their sharp edges.








## _project Folder

For the time being, it's assumed that **modules** belong to a **chapter**,
chapters belong to a **project**, and that your folder structure will reflect this.

```
project folder
├── chapter folder
│   ├── module folder
│   └── module folder
└── chapter folder
    ├── module folder
    └── module folder
```

It's also assumed that within the project folder, you'll have a folder named **_project**.

```
project folder
├── _project
├── chapter folder
│   ├── module folder
```

The _project folder includes special HTML and styling, to be imported into each module in your project.
This makes it easy to have standardized title pages, client-specific branding,
and easily tweakable settings shared by all the modules in your project.

```
project folder
├── _project
│   ├── pages
│   │   └── ...
│   ├── styles
│   │   └── ...
│   ├── styles.scss
│   └── vars.scss
```


### "But my module doesn't belong to a big project!"

Even if your module doesn't really fit this model, you might want to pretend that it does, to make things easier.
This setup might not be ideal, but it's probably easier to go with the grain, for the time being.

*The restrictions that lead to this structure will be relaxed once [this issue](https://github.com/cdig/imagineering/issues/1) is addressed, and we have a more formal build system.*

Until then, if your module doesn't belong to a "project" as described above, you'll need to use one of the following workarounds.


### Option 1: Fake It!
Just make your folder structure look like this:

```
fake project folder
├── _project
└── fake chapter folder
    └── module folder
```

You'll have to go a few steps deeper to reach your module, but everything should *just work*™.


### Option 2: Move It!
You can keep the _project folder outside of your module, but ditch the fake chapters.

```
fake project folder
├── _project
└── module folder
```

Now, change the import paths used by your module, in the `index.kit` and `styles.scss` files.

Anywhere that you see something like...

```html
<!-- @import ../../../_project/[...].kit -->
```

Or...

```scss
@import '../../../_project/[...].scss';
```

...replace the `../../../_project` part with the relative path from the current file to your _project folder: `../../_project`

This is a nice setup to use if you want to make a handful of modules that share styling.


### Option 3: Own It!
Technically, you don't need to have a separate _project folder at all. You could set up your module like so:

```
module folder
└── source
    ├── _project
    ├── index.html
    └── styles.scss
```

Then, change your import statements like so:

```html
<!-- @import _project/[...].kit -->
```

And...

```scss
@import '_project/[...].scss';
```

This is a nice option to use if you want to make a one-off module that doesn't share its styling with any other modules.









## Z-Index Values

A number of systems in cdModule and cdFoundation use CSS z-index to establish a visual hierarchy.
These values are documented here.

* 100: `call-out[open]` ([Call-Outs](#call-outs))
* 101: `call-out-point` ([Call-outs](#call-outs))
* 1000: `cd-modal` ([Modal Popup](#modal-popup))
* 1001:	`page-switcher` ([Switcher Container](#switcher-container))
* 1002: `cd-hud` ([cdHUD](#cdhud])
* 2000: `score-area` ([Score Animation](#score-animation))
* 9999: `.browser-support` ([Browser Support](#browser-support))
* 10000: `editor-container` textarea ([Editor Container](#editor-container))

The values 0-999 have been reserved for you to use in your content. `<call-out>` has been given an
index of 100 specifically so that you can layer content below or above it, because it's a part of the
[standard library](#skin-deep-the-standard-library) and it's expected that it will live alongside other content that you make.
The rest of the items here are part of [the framework](#beneath-the-surface-the-framework), and it's expected that
they will sit on top of your content.





# License
Copyright (c) 2014-2015 CD Industrial Group Inc., released under MIT license.
