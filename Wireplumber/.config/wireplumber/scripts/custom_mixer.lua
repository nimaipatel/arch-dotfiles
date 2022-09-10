#!/usr/bin/wpexec
--luacheck: globals ObjectManager Interest Constraint Debug Core

local delta = tonumber((...)['delta'] / 100)
if delta == nil then
  delta = 0
end

local om = ObjectManager {
  Interest {
    type = "node",
    Constraint { "media.class", "matches", "*Stream*" },
    Constraint { "node.name", "not-equals", "buckle" },
    Constraint { "node.name", "not-equals", "Mechvibes" },
  }
}

om:connect("objects-changed", function ()
  Core.require_api("mixer", function(mixer)
    mixer.scale = "cubic"
    local new_vol = nil
    for obj in om:iterate() do
      local props = obj['global-properties']
      local id = props['object.id']
      if new_vol == nil then
        local curr = mixer:call("get-volume", id).volume
        new_vol = curr + delta
        if new_vol > 1 then new_vol = 1 end
        if new_vol < 0 then new_vol = 0 end
      end
      mixer:call("set-volume", id, new_vol)
    end
    print(math.ceil(new_vol * 100))
    Core.quit()
  end)
end)

om:activate()
