# RoactWeb DEV Build
A development, possibly unstable version of RoactWeb.
- **Head to the main branch [here](https://github.com/mr-suno/RoactWeb).**

> [!WARNING]
> This project **cannot be used in Roblox Studio**, because `game:HttpGet()` is an exploit function on the `game` metatable.

---

### Usage 🔗
```lua
local Roact = loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/mr-suno/RoactWeb/refs/heads/dev/RoactWeb.lua"
))()

-- ... Use Roact as you'd normally would.
```

---

# Credits

- [chipio - DevForum](https://devforum.roblox.com/t/roact-the-ultimate-ui-framework/796618)  –  Original Roact thread / creator
- [Roblox - GitHub](https://github.com/Roblox/roact)  –  Discontinued Roact source code
- [Suno - GitHub](https://github.com/mr-suno)  –  HTTP request conversion for Roact framework
