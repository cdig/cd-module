# cdModule
A framework and standard library to help you make gorgeous, consistent modules. We take care of the look-and-feel, so you can focus on the content.

To get started, grab the [module template](https://github.com/cdig/cd-module-template). You'll also need an [_project folder](#_project-folder). Read on for *extensive* documentation. Grab a drink!


### Table of Contents

- [Overview](#overview)
  - [Battle Plan](#battle-plan)
- [Skin Deep: The Standard Library](#skin-deep-the-standard-library)
  - [call-out](#call-out)
  - [cd-activity](#cd-activity)
  - [cd-flow-arrow](#call-flow-arrow)
  - [cd-page](#cd-page)
  - [cd-row](#cd-row)
  - [cd-swf](#cd-swf)
  - [cd-text-bubble](#cd-text-bubble)
  - [h1](#h1)
  - [headings](#headings)
  - [img](#img)
  - [lists](#lists)
  - [main](#main)
  - [object](#object)
  - [p](#p)
  - [template](#template)
- [Beneath The Surface: The Framework](#beneath-the-surface-the-framework)
  - [BackendResetButton](#backendresetbutton)
  - [browser-support](#browser-support)
  - [cdHUD](#cdhud)
  - [FlashInterface](#flashinterface)
  - [KVStore](#kvstore)
  - [LoadingScreen](#loadingscreen)
  - [magic-underlines](#magic-underlines)
  - [ModalPopup](#modalpopup)
  - [PageAudio](#pageaudio)
  - [PageScrollWatcher](#pagescrollwatcher)
  - [PageLocking](#pagelocking)
  - [PageSwitcher](#pageswitcher)
  - [PageTitle](#pagetitle)
  - [Pages](#pages)
  - [SaveBeforeUnload](#savebeforeunload)
  - [SaveWithPopup](#savewithpopup)
  - [ScoreAnimation](#scoreanimation)
  - [Scoring](#scoring)
  - [ScrollHint](#scrollhint)
  - [ScrollRegions](#scrollregions)
  - [ScrollTo](#scrollto)
  - [WelcomePopup](#welcomepopup)
  - [Warnings](#warnings)
- [Scraping The Bottom: The Foundations](#scraping-the-bottom-the-foundations)
  - [cdFoundation](#cdfoundation)
  - [Backend](#backend)
  - [Modernizr](#modernizr)
  - [SWFObject](#swfobject)
- [Design Decisions](#design-decisions)
  - [_project folder](#_project-folder)
  - [z-index values](#z-index-values)


### Naming and Writing Style
| Name       | Type            | Written As | Example      |
|------------|-----------------|------------|--------------|
| Component  | HTML, CSS, & JS | kebab-case | call-out     |
| Element    | HTML Only       | singleword | figcaption   |
| Mixin      | CSS Only        | kebab-case | magic-unders |
| Service    | JS Only         | CamelCase  | PageLocking  |
| Style Rule | CSS Only        | Selector   | .text-center |

#### Namespaces
Some services or components might include a namespace, eg: `cdFoundation` or `cd-row`. The namespace is always lowercase.

#### Acronyms
When writing CamelCase, acronyms should be written with a leading capital, eg: `JsonParser`, `XmlNightmare`, `productId`. This guideline may be liberally broken to aid clarity, eg: `tooManyTLAs` is preferable to `tooManyTlas`.








# Overview

cdModule is *huge*.

It starts with [cdFoundation](#cdfoundation), in-house libs like [Backend](#backend), and 3rd party libs like [Modernizr](#modernizr) and (SWFObject)[#swfobject]. On top of this, it adds half-a-hundred of its own tools, with hundreds of features

Despite this, there's not much you need to know to make a basic module. If you're starting with the [module template](https://github.com/cdig/cd-module-template) and
an existing [_project folder](#_project-folder), you can pretty much write whatever HTML and CSS you want. Almost all of the fancy module-goodness is applied for you automatically. However, there are a lot of optional tools to be used, should you opt to use them. Read on to learn about them, so you can make the most amazing modules possible. Or leave now, and come back in anger when something breaks. That's what I do.

#### Battle Plan

We're going to look at cdModule in three pieces.

First, we'll look at the tools you will use when making a module — the [standard library](#skin-deep-the-standard-library).
These are primarily HTML components, but there are also a few special styles and scripts to help you make gorgeous content.

Afterward, we'll look at the network of systems that sit underneath — the [framework](#beneath-the-surface-the-framework). These systems extend cdFoundation, adding all sorts of special behaviour to your modules; from responsiveness, to score animations, to the HUD.

Finally, we'll comment briefly on the underlying [foundations](#scraping-the-bottom-the-foundations) — cdFoundation, first party libs, and third party libs.

For each item we look at, there'll be a full explanation of features, gotchas, secrets, suggestions, with links to the source code and related items. The source code links are particularly handy, since the source code is the *definitive* documentation.

Now, let's tear it apart, [Lisa](https://www.youtube.com/watch?v=Plz-bhcHryc).








# Skin Deep: The Standard Library







## call-out

**Source Code:**
[Coffee](https://github.com/cdig/cd-module/blob/master/dist/components/call-outs.coffee)
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/components/call-outs.scss)

**Usage:**

```html
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO






## cd-activity

**Source Code:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/custom/cd-activity.scss)

**Usage:**
The `cd-activity` element helps you include an activity in your page.
It provides the information needed to facilitate scoring, such as a unique name, and the number of points to award.

Usually, you need to put the activity inside the `cd-activity` element, like this:

```html
<cd-activity name="kittens-are-cute" points="100">
  <kitten-game>
    <img src="image/kitten-1.jpg">
    <img src="image/kitten-2.jpg">
    <img src="image/kitten-3.jpg">
  </kitten-game>
</cd-activity>
```

You are free to apply whatever styling you need to make this work with your page layout.

Alternatively, some activities can just sit beside the `cd-activity` element, like this:

```html
<cd-activity name="puppy-game" points="100"></cd-activity>
<object cd-swf="puppy-game.swf"></object>
```

This is a bit nicer because it shouldn't mess with your styling as much.
Activities that support this "side-by-side" arrangement will mention this in their documentation.

**Requirements:**
* You must provide a `name` that is unique within the page
* You specify the number of `points` available to be awarded

**Behaviour:**
It's just a marker that lets the Scoring service know that something nearby will be awarding some points.
It doesn't provide any styling or script behaviour on its own.
It's just a placeholder for data.

**Related**
[Scoring](#scoring), [cd-swf](#cd-swf)










## cd-flow-arrow

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

```html
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO








## cd-page

**Source Code:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/custom/cd-page.scss)

**Usage:**
This custom element is the highest-level grouping of content within a module.
Following the example of the [module template](https://github.com/cdig/cd-module-template),
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

**Related:**
[Pages](#pages), [PageLocking](#pagelocking), [PageSwitcher](#pageswitcher), [PageAudio](#pageaudio), [PageTitle](#pagetitle), [PageScrollWatcher](#pagescrollwatcher).















## cd-row

**Source Code:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/custom/cd-row.scss)

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

**Related:**
TODO















## cd-swf

**Source Code:**
[Coffee](https://github.com/cdig/cd-module/blob/master/dist/components/cd-swf.coffee)
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/elements/object.scss)

**Usage:**
When embedding a SWF using an `<object>` tag, normally you'd use the `data` attribute to specify the path to your file. Instead, you should use the `cd-swf` attribute. We'll grab the SWF file, wrap it with the js-wrapper.swf, and feed it to [SwfObject](#SwfObject), which will embed your wrapped SWF in a standards-compliant way.

```html
<object cd-swf="flash/ugly-old.swf"></object>
```

If you add a cd-activity with the same name as the SWF file, that activity will translate the points from the SWF into points for the module.

```html
<cd-activity name="thirsty-and-miserable" points="1">
<object cd-swf="flash/thirsty-and-miserable.swf"></object>
```

**Requirements:**
* Your SWF ***MUST*** have the CDIG class (or a subclass, like Schematic).
* You must include `js-wrapper.swf` in your `public/flash` folder. It's included as part of the [module template](https://github.com/cdig/cd-module-template), or you can find it here: `Dropbox/Assets and Resources/Tools/js-wrapper/js-wrapper.swf`.
* If you are using `<cd-activity>` to award points from a SWF, you need to make the activity name match the name of the SWF. The object and the cd-activity just have to appear on the same page; they don't need to be nested.
* Currently designed to work with SWFObject 2.3beta.

**Behaviour:**
TODO

**Related:**
TODO







## cd-text-bubble

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

```html
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO










## h1

**Source Code:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/elements/headings.scss)

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

**Related:** [Headings](#headings), [Magic Underlines](#magic-underlines)














## Headings

**Source Code:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/elements/headings.scss)

**Usage:**
Heading elements (other than [h1](#h1)) may be used as normal for HTML.
Feel free to style them however you want.

```html
<h2>Nothing Special</h2>
<h3>But that's okay.</h3>
```

**Requirements:**
* [h1](#h1) has its own special behaviour and should only be used as intended

**Behaviour:**
Some default styling is applied for h2 and h3; h4 through h6 are unstyled.

**Related:** [#h1](#h1)









## img

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**
Image tags, by default have a style of `width: 100%;` applied to them. Just.. watch out for this. In practice, it means you can drop an image into your page and not have to worry about it either being too small, or blowing out your layout.

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO









## lists

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

```html
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## main

**Source Code:**
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

**Requirements:**
* The main element must be a direct child of a cd-page.

**Behaviour:**
The default styling creates a white padded background behind the content.

**Related:**
[cd-page](#cd-page), [img](#img)










## object

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

```html
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## p

**Source Code:**
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/styles/elements/p.scss)

**Usage:**
Because cdModule includes the [cd-reset](https://github.com/cdig/cd-reset), paragraph tags are selectable, and all other tags are not.
So, use them for text that the user might like to select and copy-paste,
and don't use them for things that shouldn't be selectable — interactive elements, UI, or parts of a graphic.


```html
    <p>On this page, we'll look at things that are cute!</p>
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO






## template

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

```html
```

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO













# Beneath The Surface: The Framework
Above, we looked at the parts of cdModule that you will work with directly. Now, we'll dig in to the systems that make up the foundational framework of cdModule. Most of these systems will be invisible to you, applying their logic seamlessly behind the scenes. A few of them will offer a Public API that you are able to use from your own JS code, or provide a visible component that you can see in the browser, or even offer styling hooks to integrate with your CSS.










## backend-reset-button

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**
If you're using BackendLocalStorage, shows a Reset button in the HUD, which clears LocalStorage.

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## cdHud

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## Flash Interface

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## KVStore

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO









## LoadingScreen
**Source Code:**
[Coffee](https://github.com/cdig/cd-module/blob/master/dist/components/loading-screen.coffee)
[HTML](https://github.com/cdig/cd-module/blob/master/dist/components/loading-screen.html)
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/components/loading-screen.scss)

**Usage:**

**Requirements:**

**Behaviour:**
Automatically shows a loading indicator if the download is taking a while.
This solves the problem of people seeing brokenness while images download.
However, it doesn't have any way of showing a progress indicator.
If the download takes a really long time, it successively offers more of an appology to the user,
and finally asks them to check their internet connection.

**Related:**
TODO









## magic-underlines

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**
This special mixin uses a bunch of crazy SCSS to create an iOS-style underline on all browsers/devices.

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## ModalPopup

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO





















## Page Audio

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO





















## Page Scroll Watcher

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## PageLocking

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
* Add a URL param `locking=false` to disable locking

**Related:**
TODO











## PageSwitcher

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## PageTitle

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## Pages

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## SaveBeforeUnload

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## SaveWithPopup

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## ScoreAnimation

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## Scoring

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## ScrollHint

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## ScrollRegions

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO












## ScrollTo

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## WelcomePopup

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO











## Warnings

**Source Code:**
[Coffee](https://github.com/cdig/cd-module/blob/master/dist/components/warnings.coffee)
[SCSS](https://github.com/cdig/cd-module/blob/master/dist/components/warnings.scss)

**Usage:**

**Requirements:**
TODO

**Behaviour:**
This service scans the page for common errors in the content.
If it finds an error, it notifies the developer via a "Warning" indicator in the HUD,
and lists details in the browser console.

**Related:**
TODO












# Scraping The Bottom: The Foundations
cdModule builds on top of the hard work of Ivan, Sean, and a bunch of other people who know more about Internet Explorer bugs than they do, that's for sure.


## cdFoundation

[Github Repo](https://github.com/cdig/cd-foundation)


## First Party Libs

### Backend
[Github Repo](https://github.com/cdig/backend)

### browser-support
[Github Repo](https://github.com/cdig/browser-support)

**Related:**
[Modernizr](#modernizr)


## Third Party Libs

### Modernizr

[Website](https://modernizr.com)

Modernizr works with browser-support to warn users when they're using an unsupported browser.

**Related:**
[browser-support](#browser-support)





### [SwfObject](https://github.com/swfobject/swfobject)

**Source Code:**
[Type](https://github.com/cdig/cd-module/blob/master/dist/PATH)

**Usage:**
SwfObject gives us a standards-compliant way to embed SWFs, with the help of cd-swf (see below).

**Requirements:**
TODO

**Behaviour:**
TODO

**Related:**
TODO









# Design Decisions

In building cdModule, we've had to make a few judgement calls about how you should make your modules.
We're documenting these decisions here, so you don't accidentally run into their sharp edges.








## _project Folder

For the time being, it's assumed that **modules** belong to a **chapter**,
chapters belong to a **project**, and that your folder structure will reflect this.

    project folder
    ├── chapter folder
    │   ├── module folder
    │   └── module folder
    └── chapter folder
        ├── module folder
        └── module folder

It's also assumed that within the project folder, you'll have a folder named **_project**.

    project folder
    ├── _project
    ├── chapter folder
    │   ├── module folder

The _project folder includes special HTML and styling, to be imported into each module in your project.
This makes it easy to have standardized title pages, client-specific branding,
and easily tweakable settings shared by all the modules in your project.

    project folder
    ├── _project
    │   ├── pages
    │   │   └── ...
    │   ├── styles
    │   │   └── ...
    │   ├── styles.scss
    │   └── vars.scss


### "But my module doesn't belong to a big project!"

Even if your module doesn't really fit this model, you might want to pretend that it does, to make things easier.
This setup might not be ideal, but it's probably easier to go with the grain, for the time being.

*The restrictions that lead to this structure will be relaxed once [this issue](https://github.com/cdig/imagineering/issues/1) is addressed, and we have a more formal build system.*

Until then, if your module doesn't belong to a "project" as described above, you'll need to use one of the following workarounds.


### Option 1: Fake It!
Just wrap a few extra "fake" folders around your actual module, and put the _project folder in the right place.

    fake project folder
    ├── _project
    └── fake chapter folder
        └── module folder

You'll have to go a few steps deeper to reach your module, but everything should *just work*™.


### Option 2: Move It!
You can keep the _project folder outside of your module, but ditch the fake chapters.

    fake project folder
    ├── _project
    └── module folder

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

    module folder
    └── source
        ├── _project
        ├── index.html
        └── styles.scss

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

z-index | CSS Selector              | System
-------:| ------------------------- | ------
100     | call-out[open]            | [call-out](#callout)
101     | call-out-point            | [call-out](#callout)
1000    | cd-modal                  | [ModalPopup](#modalpopup)
1001    | page-switcher             | [PageSwitcher](#pageswitcher)
1002    | cd-hud                    | [cdHUD](#cdhud)
1003    | scroll-hint               | [ScrollHint](#scrollhint)
2000    | score-area                | [ScoreAnimation](#scoreanimation)
5000    | loading-screen            | [LoadingScreen](#loadingscreen)
9999    | .browser-support          | [browser-support](#browser-support)
10000   | editor-container textarea | [EditorContainer](https://github.com/cdig/editor)

* 0-999 is reserved for you to use in your content.
* 1000-9999 is reserved for [the framework](#beneath-the-surface-the-framework).
* 10000+ is reserved for [cdFoundation](https://github.com/cdig/cd-foundation).

`<call-out>`s are a part of [the standard library](#skin-deep-the-standard-library),
and have been given a z-index of 100 so that you can layer content above or below them.















# License
Copyright (c) 2014-2015 CD Industrial Group Inc., released under MIT license.
