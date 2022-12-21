local Roact = require(script.Parent.Parent.Roact)

local function defaultEqualityFn(newState, oldState)
	return newState == oldState
end

local function useCustomSelector<R, S>(selector: (S) -> R, equalityFn: ((S, S) -> boolean)?, context): R
	local store = Roact.useContext(context)
	local mappedState, setMappedState = Roact.useState(function()
		return selector(store:getState())
	end)
	local oldMappedState = Roact.useRef(mappedState)

	if equalityFn == nil then
		equalityFn = defaultEqualityFn
	end
	assert(equalityFn, "should exist")

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
