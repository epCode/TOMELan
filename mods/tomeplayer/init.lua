tplayer = {}


---------- Meta Functions --




function tplayer.get_dmeta(player, key)
  return core.deserialize(player:get_meta():get_string(key))
end

function tplayer.set_dmeta(player, key, value)
  player:get_meta():set_string(key, core.serialize(value))
end


function tplayer.get_character(player)
  return tplayer.get_dmeta(player, "character")
end
