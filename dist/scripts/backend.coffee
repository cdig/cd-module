# Backend
# I got tired of manually switching out which backend is the correct one. So just.. do it based on
# whether we're inside codekit or pow or not.

Take ["BackendLocalStorage", "BackendScorm2004"], (LocalStorage, Scorm2004)->
	
	parts = location.hostname.split(".")
	tld = parts[parts.length-1]
	ck = tld is "local" or parts.length is 1
	pow = tld is "dev"
	Backend = if ck or pow then LocalStorage else Scorm2004
	Make("Backend", Backend)
		
