local Symbol = getgenv().RoactWeb__Symbol

-- Marker used to specify that the value is nothing, because nil cannot be
-- stored in tables.
local None = Symbol.named("None")

return None