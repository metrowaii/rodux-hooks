local Roact = require(script.Parent.Parent.Roact)
local Context = require(script.Parent.Context)

local function useStore()
    return Roact.useContext(Context)
end

return useStore
