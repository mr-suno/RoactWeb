--[[

    Since I'm lazy, I'm going to create a new global called `require` so I don't have

    to type out the loadstring stuff all the time :3

]]

local search = {
    domain = "https://raw.githubusercontent.com/",
    owner = "mr-suno/",
    repository = "RoactWeb/",
    branch = "refs/heads/main/",
    folder = "Roact/"
}

local query = `{search.domain}{search.owner}{search.repository}{search.branch}{search.folder}`
getgenv().require = function(name)
    local source, issue = loadstring((game:HttpGetAsync(`{query}{name}.lua`)))
    if source then
        print(`[•] Successfully loaded file: {name}.lua`) do
            return source()
        end
    else
        warn(`[!] Error on file: {name}.lua`)
        error(issue)
    end
end

-- `getgenv().require` searches in the `./Roact` folder.

--

return loadstring(game:HttpGet("https://raw.githubusercontent.com/mr-suno/RoactWeb/refs/heads/main/Roact.lua"))()
