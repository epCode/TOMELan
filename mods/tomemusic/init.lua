tomemusic = {
  current = {} -- [1] = "soundname", [2] = `soundindex`
}

function tomemusic.play(player, name, channel)
  -- channel's are used for different types of sounds.
  -- 1 is set aside for music and 2 for ambient sound (eg. fireplace in character creation)
  channel = channel or 1
  tomemusic.current[channel] = tomemusic.current[channel] or {}
  
  local pname = player:get_player_name()
  local current = tomemusic.current[channel][pname]

  if current then
    if current[1] == name then return end
    core.sound_stop(current[2])
  end

  tomemusic.current[channel][pname] = {name, core.sound_play(name, {
    to_player = pname,
    loop = true,
    gain = 1.0,   -- default
    fade = 0.0,   -- default
    pitch = 1.0,  -- default

  })}
end
