# RoactWeb
A version of Roact designed to be supported globally using **HTTP requests**, designed for Roblox executors.

> [!WARNING]
> This project **cannot be used in Roblox Studio**, because `game:HttpGet()` is an exploit function on the `game` metatable.

---

### Purpose 🔍
This version is intended to be ModuleScript-less, meaning it's fully available to use entirely on the client!

If you'd like to create a UI using Roact, however you don't want to use any "**Gui to Lua**" plugins or `Instance.new`, you can import Roact locally and create easily.

### Usage 🔗
```lua
local Roact = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/mr-suno/RoactWeb/refs/heads/main/RoactWeb.lua"
))()

-- ... Use Roact as you'd normally would.
```

---

# Credits

- [chipio - DevForum](https://devforum.roblox.com/t/roact-the-ultimate-ui-framework/796618)  –  Original Roact thread / creator
- [Roblox - GitHub](https://github.com/Roblox/roact)  –  Discontinued Roact source code
- [Suno - GitHub](https://github.com/mr-suno)  –  HTTP request conversion for Roact framework
