local Roact = require(script.Parent.Parent.Roact)

local function useCustomDispatch(context)
	local store = Roact.useContext(context)

	return function(action)
		return store:dispatch(action)
	end
end

return useCustomDispatch
