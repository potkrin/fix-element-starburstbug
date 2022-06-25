local ElementID = 1

function on_pre_forceRequestElement(args)
    args[3] = sdk.to_ptr(ElementID)
    return sdk.PreHookResult.CALL_ORIGINAL
end

function on_post_forceRequestElement(retval)
    return retval
end

-- this fuction is called on quest start
sdk.hook(sdk.find_type_definition("snow.envCreature.Ec055"):get_method("forceRequestElement"), 
	on_pre_forceRequestElement,
	on_post_forceRequestElement)

local StarBurstElement = {"Fire", "Thunder", "Water", "Ice"}
local ElementSelection = 1

re.on_draw_ui(function()
	local changed = false
    changed, value = imgui.combo('Set Element(StarBurst)', ElementSelection, StarBurstElement)
    if changed then
        ElementSelection = value
        ElementID = value
    end
end)
