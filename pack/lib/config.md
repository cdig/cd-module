# Config

Your one-stop shop for configuration information from "the outside world".

Here's how you use it in your code:

```coffee
Take "Config", (Config)->
  myVar = Config("myKey")
```

You call the `Config` function with the name of the config data you'd like.

## Where does the data come from?

#### 1. Params

First, it'll check in [Params](https://github.com/cdig/cd-library#params).
If the page was loaded with a query param like `.../blag/index.html?myKey=myVal` then when you call `Config("myKey")` you'll get `myVal`. Simple!

Values passed in to Params are converted from strings to native values in the following cases:

* Boolean: The string is an exact match for "true" or "false".
* Number: The string contains a valid number literal, including weird literals like "-1." and "0b10"

Otherwise, it's left as a string, and it's up to you to deal with it.

#### 2. Env

If there was no matching query param, it'll next check [Env](https://github.com/cdig/cd-library#env).
This works great if you're looking for info about the runtime environment — for instance, if you want to know if you're running on localhost:

`Config("localhost")` will return `true` or `false` accordingly, thanks to Env. And because we check Params before we check Env, you can "fake it" by setting, eg: `localhost:3000/blag/index.html?localhost=false`. `Config("localhost")` will return `false` in that case.

#### 3. window.config

If there's no match in Params, and no match in Env, we'll next check a global object at `window.config`.

`window.config` is just a convention — there's nothing technical behind it.
If you want to put a value in there, you should soft-initialize the config object.
We don't do this ourselves, because script load order is non-determinstic.

Here's how you initialize it:

```coffee
(window.config?={}).myKey = myVal
```

Note — normal JS scripts should NOT put data on `window.config`.
The *only* supported mechanism for passing data between scripts is Take & make.
`window.config` is to be used by compilers and servers.

## Caveats and Snark

Config executes synchronously. Calls to the `Config` function are synchronous, and the setup happens as soon as Params and Env are ready.
Because of this, data you put on `window.config` might not exist at the time `Config` starts executing. So don't do that.

If you want asynchrony, use Take & Make.

Also, we are intentionally not allowing normal running JS code to insert values into this system.
Config should be used to access data that exists before the page JS starts to execute —
data from the URL, or injected into the script by the compiler or by a server.
We do this for performance reasons, and to avoid complexity.
For instance, we deliberately didn't add support for loading JSON configuration data, because
that would delay execution of ALL code that wanted to use `Config()`, whether it needed the JSON data or not.
If you want to load some configuration data from a JSON file, that's the responsibility of your application,
NOT the responsibility of this low-level infrastructure.
