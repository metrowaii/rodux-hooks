local Context = require(script.Parent.Context)
local useCustomDispatch = require(script.Parent.useCustomDispatch)

local function useDispatch()
    return useCustomDispatch(Context)
end

return useDispatch
