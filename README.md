# cdModule

A solid foundation for CDIG modules.

### What's included?

In a sense, this is like an anti-reset. It's an opinionated set of default styles and behaviours that should help standardize our modules. It's not a framework, per se. You don't use this to design your own modules. CD-Module should force your modules to look and act a certain way.

### What's not included?

Anything that is specific to a particular project or client is not to be included here. That belongs in an _project folder. TODO(Ivan): Explain how _project works.

## Dependencies

Assumes that cdReset is also included. Includes modernizr and jquery. Requires an _project folder.

## Documentation

### Z-indexes

* 10: call-out[open] (Call Outs)
* 1000: cd-modal (Modal Popup)
* 1001:	page-switcher (Switcher Container)
* 1002: cd-hud (HUD)
* 2000: score-area (Score Animation)
* 9999: .browser-support (Browser Support)
* 10000: editor-container textarea (Editor)

## License
Copyright (c) 2014 CD Industrial Group Inc., released under MIT license.
