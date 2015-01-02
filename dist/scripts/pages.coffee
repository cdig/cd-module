# Pages
# Frozen (immutable-ish) array of the pages in the module.

Take ["PureDom", "load"], (PureDom)->
	
	pagesNodeList = document.querySelectorAll("cd-page")
	pages = PureDom.nodeListToArray(pagesNodeList)
	Object.freeze(pages)
	
	Make("Pages", pages)
