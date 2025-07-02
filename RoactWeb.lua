local function browse()
    local search = {
        domain = "https://raw.githubusercontent.com/",
        owner = "mr-suno/",
        repository = "RoactWeb/",
        branch = "refs/heads/main/",
        folder = "Roact/"
    }

    return {
        search = search,
        load = `{search.domain}{search.owner}{search.repository}{search.branch}{search.folder}`
    }
end

local function canProvide()
    return listfiles and type(listfiles("RoactWeb")) == "table"
end

makefolder("RoactWeb")
local function loadCached()
    if canProvide() then
        local cachedModules = {}
        for _, found in listfiles("RoactWeb") do
            table.insert(cachedModules, {
                file = found:gsub("RoactWeb\\", ""):gsub(".lua", ""),
                localSource = readfile(found)
            })
        end

        return cachedModules
    else
        return {}
    end
end

local cachedModules = loadCached()
getgenv().require = function(name)
    local cleansedName = name
    if name:find(".") then
        cleansedName = name:gsub("%.", "/")
    end

    local foundSource
    for index, _ in cachedModules do
        if cachedModules[index].file == name then
            print(`[•] Successfully loaded cached file: {name}.lua`)

            foundSource = cachedModules[index].localSource
            break
        end
    end

    if not foundSource then
        local source, issue = loadstring(game:HttpGet(`{browse().load}{cleansedName}.lua`))
        if source then
            print(`[•] Successfully loaded file: {name}.lua`)

            if canProvide() then
                writefile(`RoactWeb//{name}.lua`, game:HttpGet(`{browse().load}{cleansedName}.lua`))
            end
            return source()
        else
            warn(`[!] Error on file: {name}.lua`)
            error(issue)
        end
    else
        return loadstring(foundSource)()
    end
end