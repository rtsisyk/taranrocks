TaranRocks
==========

**TaranRocks** is the Tarantool Package Manager based on LuaRocks.

**Status:** EARLY ALPHA, work in progress

**Prerequisites:**

 * Tarantool 1.5.1-1 or later
 * Lua headers (needed to build Lua shared libraries)

# Installation

    git clone --recursive https://github.com/rtsisyk/taranrocks.git
    cd taranrocks
    ./configure
    make install

By default `taranrocks` script is installed to `/usr/local/bin` directory. Do not forget to add `tarantool_box` to your PATH.

# Configuration
Add the following lines to your `init.lua` (order matters):

    -- Add Taranrocks pathes
    local home = os.getenv("HOME")
    package.path = [[/usr/local/share/tarantool/lua/?/init.lua;]]..package.path
    package.path = [[/usr/local/share/tarantool/lua/?.lua;]]..package.path
    package.path = home..[[/.tarantool/share/tarantool/lua/?/init.lua;]]..package.path
    package.path = home..[[/.tarantool/share/tarantool/lua/?.lua;]]..package.path
    package.cpath = [[/usr/local/lib/tarantool/lua/?.so;]]..package.cpath
    package.cpath = home..[[/.tarantool/lib/tarantool/lua/?.so;]]..package.cpath

# Usage

 * `taranrocks search name` - query the repository for packages
 * `taranrocks install name` - install a package
 * `taranrocks remove name` - uninstall a package

# Example

Query the repository for needed module:

```
$ taranrocks search queue

Search results:
===============


Rockspecs and source rocks:
---------------------------

tarantool-queue
   scm-1 (rockspec) - https://raw.github.com/rtsisyk/taranrocks-repo/master/
```

Install the module to the local tree (no root access is needed!):

```
$ taranrocks install tarantoool-queue --local 
Installing https://raw.github.com/rtsisyk/taranrocks-repo/master/tarantool-queue-scm-1.rockspec...
Using https://raw.github.com/rtsisyk/taranrocks-repo/master/tarantool-queue-scm-1.rockspec... switching to 'build' mode
Cloning into 'queue'...
Applying patch modularize...
successfully patched /tmp/luarocks_tarantool-queue-scm-1-2191/queue/init.lua
Updating manifest for /home/roman/.tarantool//share/tarantool/rocks

tarantool-queue scm-1 is now built and installed in /home/roman/.tarantool/ (license: Artistic)
```

Add to your init.lua:

```
-- Enable queue module
queue = require('tarantool.queue')
```

Restart Tarantool and connect to the admin console:

```
$ tarantool
---
- Tarantool 1.6.0-332-g8351f97
- 'Uptime: 2'
...

localhost> queue
---
- urgent: 'function: 0x4002c0f8'
  bury: 'function: 0x4003a500'
  put: 'function: 0x4002c0b0'
  -- // --
...
```

A queue server is up and running!

# Contacts

 * http://tarantool.org/
 * https://github.com/tarantool/tarantool
 * https://groups.google.com/forum/?fromgroups=#!forum/tarantool
 * irc://irc.freenode.net/#tarantool
 * roman@tsisyk.com
