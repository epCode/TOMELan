tomecc = {
  localchar = {}
}



function findlist(tbl, str)
  for _, element in ipairs(tbl) do
    if string.find(element, str) then
      return element
    end
  end
end

function get_keys(t)
    local keys = {}
    for k, v in pairs(t) do
        keys[#keys+1] = k
    end
    return keys
end



local b_classs = {
  warrior = {name = "Warrior", pos = {x=2,y=10}},
  archer = {name = "Archer", pos = {x=2,y=12}},
  paladin = {name = "Paladin", pos = {x=5,y=10}},
  rouge = {name = "Rouge", pos = {x=5,y=12}},
  adventurer = {name = "Adventurer", pos = {x=8,y=10}},
  ranget = {name = "Ranger", pos = {x=8,y=12}},
}



function tomecc.show_joinspec(player)
  local formspec = [[
  size[25,13]
  background[-50,-50;100,100;tomeui_button_darker.png]
  animated_image[0,-4;20,20;fireanim;tomecharactercreation_fireplace_anim.png;8;300;1]
  hypertext[0,0;20,10;firstjointext;Hey! Looks like you are new to this server.
  This is the Tales of Middle Earth, a rouge-like adventure game.
  Explore, build your stats and equipment, learns ancient secrets and so much more
  To win the game you must find and defeat Morgoth, Lord of Darkness...

  But before then you need to create your character.]

  ]]..
  tomeui.style({type = "image_button", pos = {x=9,y=4}, size = {x=3.7,y=1}, image = "4x1", name = "CreateChar", label = "Create Character"})


  core.show_formspec(player:get_player_name(), "charactercreation_join", formspec)
end


function tomecc.create_char(player, step, ooptions)

  ooptions = ooptions or {}

  local charchooses = ""

  for id,def in pairs(b_classs) do
    if "choose_class_"..id == ooptions.selected_element then
      charchooses = charchooses..
      "image[".. def.pos.x-0.2 .. "," .. def.pos.y+1.5 .. ";4,0.3;tomeui_button_light.png^[colorize:#393]]"
      print("s")
    end
    charchooses = charchooses..
    tomeui.style({type = "image_button", pos = def.pos, size = {x=3,y=1.5}, image = "2x1", name = "choose_class_"..id, label = def.name})
  end

  local formspec = [[
  size[25,13]
  background[-50,-50;100,100;tomeui_button_darker.png]
  label[0,0;Please Choose a class:]
  ]]..charchooses



  core.show_formspec(player:get_player_name(), "charactercreation", formspec)
end



core.register_on_player_receive_fields(function(player, formname, fields)
  if formname == "charactercreation_join" then
    if fields.CreateChar then
      tomecc.create_char(player, 1)
    end
  end
  if formname == "charactercreation" then
    tomecc.localchar[player:get_player_name()] = tomecc.localchar[player:get_player_name()] or {}
    local choose = findlist(get_keys(fields), "choose_class_")
    if choose then
      tomecc.create_char(player, 1, {selected_element = choose})
    else
      tomecc.create_char(player, 1, {})
    end
  end
end)






core.register_on_joinplayer(function(player)

  if not tplayer.get_character(player) then
    tomemusic.play(player, "generic")
    tomemusic.play(player, "fireplace", 2)

    tomecc.show_joinspec(player)
  end

end)
