local Roact = require(script.Parent.Parent.Roact)

local function defaultEqualityFn(newState, oldState)
	return newState == oldState
end

local function useCustomSelector(
	selector: (state: table) -> any,
	equalityFn: ((newState: table, oldState: table) -> boolean)?,
	context
)
	local store = Roact.useContext(context)
	local mappedState, setMappedState = Roact.useState(function()
		return selector(store:getState())
	end)
	local oldMappedState = Roact.useRef(mappedState)

	if equalityFn == nil then
		equalityFn = defaultEqualityFn
	end

	Roact.useEffect(function()
		local storeChanged = store.changed:connect(function(newState, _oldState)
			local newMappedState = selector(newState)

			if not equalityFn(newMappedState, oldMappedState.value) then
				oldMappedState.value = newMappedState
				setMappedState(newMappedState)
			end
		end)

		return function()
			storeChanged:disconnect()
		end
	end, {})

	return mappedState
end

return useCustomSelector
