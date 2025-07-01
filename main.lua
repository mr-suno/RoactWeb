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

local query = `{search.domain}{search.owner}{search.repository}{search.branch}{search.folder}/`
getgenv().require = function(name)
    local _, issue = pcall(function()
        loadstring(game:HttpGet(`{query}{name}.lua`))
    end)

    if issue then
        warn(`[!] Error on file: {name}.lua`)
        error(issue)
    else
        print(`[•] Successfully loaded file: {name}.lua`)
    end
end

-- `getgenv().require` searches in the `./Roact` folder.

--

return loadstring(game:HttpGet("https://raw.githubusercontent.com/mr-suno/RoactWeb/refs/heads/main/Roact.lua"))()
