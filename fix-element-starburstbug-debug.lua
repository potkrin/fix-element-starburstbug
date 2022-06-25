local force_called = false

local ElementID = 1

function on_pre_forceRequestElement(args)

    log.debug("on_pre_forceRequestElement")
    local a0 = args[0]
    local a1 = args[1]
    local a2 = args[2]
    local a3 = args[3]
    local a4 = args[4]

    log.debug("force: arg 0"..tostring(args[0]))
    log.debug("force: arg 0"..tostring(args[1]))
    log.debug("force: arg 0"..tostring(args[2]))
    log.debug("force: arg 0"..tostring(args[3]))
    log.debug("force: arg 0"..tostring(args[4]))
    args[3] = sdk.to_ptr(ElementID)
    log.debug("force: elementID = "..tostring(ElementID))

    return sdk.PreHookResult.CALL_ORIGINAL
end

function on_post_forceRequestElement(retval)
    log.debug("on_post_forceRequestElement")
    force_called = true
    sdk.find_type_definition("snow.envCreature.Ec055")
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
