# Matches Selector
# TODO: This should be replaced with a polyfill

Make "MatchesSelector", (page, selector)->
	return page.matches(selector) if page.matches?
	return page.msMatchesSelector(selector) if page.msMatchesSelector?
	throw new Error("No supported Element.matches() implementation.")
