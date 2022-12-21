local Context = require(script.Parent.Context)
local useCustomSelector = require(script.Parent.useCustomSelector)

local function useSelector<R, S>(selector: (S) -> R, equalityFn: ((S, S) -> boolean)?): R
	return useCustomSelector(selector, equalityFn, Context)
end

return useSelector
