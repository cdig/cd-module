# cdModule

A standard library for CDIG modules.

In the olden days, we used Dropbox to store and sync our standard library code. It was nice because I could write some code on my computer, and save the changes, and all other computers would automatically receive the updated code. But this was fragile. If I wanted to experimentally make some changes without shipping them out to the company at large, I'd need to make sure to work on a copy of the code, not the main files in Dropbox. And if I introduced a bug, everyone caught it. And if the changes I made broke existing projects, I had no way of knowing other than to wait until someone noticed. There was no opt-in/opt-out of changes.

So, now we have git and github. It's the new Dropbox "source" folder.

This project contains a whole bunch of common HTML, CSS, and JS files (well, Kit, SCSS, and Coffee files). You can use any or all of them in your modules. If I change these libraries, you can update your project with a simple `bower update`. But you don't have to. It's opt-in. And I get to work on changes safely, and only push them live once they're ready.

So, here's hoping this works as well as could be expected.

### Dependencies
Requires cdReset, I think?

## License
Copyright (c) 2014 CD Industrial Group Inc., released under MIT license.
