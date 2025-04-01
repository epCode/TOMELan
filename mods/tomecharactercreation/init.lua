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





local b_classes = {
  warrior = {name = "Warrior", pos = {x=0,y=10}},
  archer = {name = "Archer", pos = {x=0,y=12}},
  ranger = {name = "Ranger", pos = {x=3,y=10}},
  rouge = {name = "Rouge", pos = {x=3,y=12}},
  adventurer = {name = "Adventurer", pos = {x=6,y=10}},
}

local b_races = {
  human = {name = "Human", pos = {x=0,y=4}},
  half_elf = {name = "Half-Elf", pos = {x=3,y=4}},
  elf = {name = "Elf", pos = {x=0,y=6}},
  hobbit = {name = "Hobbit", pos = {x=3,y=6}},
  dwarf = {name = "Dwarf", pos = {x=0,y=8}},
  dark_elf = {name = "Dark Elf", pos = {x=3,y=8}},
  dunadan = {name = "Dunadan", pos = {x=0,y=10}},
  half_troll = {name = "Half-Troll", pos = {x=3,y=10}},
  goblin = {name = "Goblin", pos = {x=0,y=12}},
  noldor_elf = {name = "Noldor Elf", pos = {x=3,y=12}},
}

local b_character_stats = {
  STR = {name = "Strength", pos = {x=11,y=2}},
  DEX = {name = "Dexterity", pos = {x=11,y=3.4}},
  INT = {name = "Intelligence", pos = {x=11,y=4.8}},
  WIS = {name = "Wisdom", pos = {x=11,y=6.2}},
  CON = {name = "Constitution", pos = {x=11,y=7.6}},
  CHA = {name = "Charisma", pos = {x=11,y=9}},
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

  local name = player:get_player_name()

  core.sound_play("tomui_button", {
    gain = 1.0,
    to_player = name
  })




  ooptions = ooptions or {}
  local formspec = [[
  size[25,13]
  background[-50,-50;100,100;tomeui_button_darker.png]
  style_type[label,button,image_button;textcolor=#888]
  style_type[label;font_size=20]
  ]]

  local tracked_stats = {[1] = "sex", [2] = "class", [3] = "race"}
  for i,stat in pairs(tracked_stats) do
    formspec = formspec .. "style_type[label;textcolor=#fff]"

    formspec = formspec .. "label[0,"..(i-1)..";"..stat..": ]"
    if ooptions.currentchar and ooptions.currentchar[stat] then
      formspec = formspec .. "label[1.3,"..(i-1)..";"..ooptions.currentchar[stat]:gsub("_", " ").."]"
    end
    formspec = formspec .. "style_type[label;textcolor=#888]"
  end


  if step == 0 then -- class

    formspec = formspec ..
    tomeui.style({type = "image_button", pos = {x=8,y=10}, size = {x=4,y=2}, image = "2x1", name = "choose_sex_male", label = "Male"})..
    tomeui.style({type = "image_button", pos = {x=12,y=10}, size = {x=4,y=2}, image = "2x1", name = "choose_sex_female", label = "Female"})

  end


  if step == 1 then -- class

    local charchooses = ""

    for id,classinfo in pairs(tomeinfo.classes) do
      local def = b_classes[id]
      if "choose_class_"..id == ooptions.selected_element then
        charchooses = charchooses..
        "background[13,-0.5;13.5,20;tomeui_button_light.png^[colorize:#000:200]]"..
        "hypertext[14,0;10,9;classdesc;"..classinfo.cc.."]"..
        "image[".. def.pos.x-0.2 .. "," .. def.pos.y+1.5 .. ";4,0.3;tomeui_button_light.png^[colorize:#393]]"..
        tomeui.style({type = "image_button", pos = {x=15,y=10}, size = {x=4,y=2}, image = "2x1", name = "select_class", label = "Select Class"})
      end
      charchooses = charchooses..
      tomeui.style({type = "image_button", pos = def.pos, size = {x=3,y=1.5}, image = "2x1", name = "choose_class_"..id, label = def.name})
    end

    formspec = formspec .. [[
    label[0,9;Please Choose a class:]
    ]]..charchooses
  end

  if step == 2 then -- race

    local charchooses = ""

    for id,raceinfo in pairs(tomeinfo.races) do
      local def = b_races[id]
      if "choose_race_"..id == ooptions.selected_element then
        charchooses = charchooses..
        "background[13,-0.5;13.5,20;tomeui_button_light.png^[colorize:#000:200]]"..
        "hypertext[14,0;10,9;racedesc;"..raceinfo.cc.."]"..
        "image[".. def.pos.x-0.2 .. "," .. def.pos.y+1.5 .. ";4,0.3;tomeui_button_light.png^[colorize:#393]]"..
        tomeui.style({type = "image_button", pos = {x=15,y=10}, size = {x=4,y=2}, image = "2x1", name = "select_race", label = "Select Class"})
      end
      charchooses = charchooses..
      tomeui.style({type = "image_button", pos = def.pos, size = {x=3,y=1.5}, image = "2x1", name = "choose_race_"..id, label = def.name})
    end

    formspec = formspec .. [[
    label[0,3.4;Please Choose a race:]
    ]]..charchooses
  end

  if step == 3 then -- race

    formspec = formspec .. [[
    label[0,3.4;Please:]
    ]]

    for id,statdef in pairs(b_character_stats) do
      formspec = formspec .. tomeui.statchanger({name = statdef.name, id = id, pos = statdef.pos, value = ooptions.currentchar[id]})
    end

    formspec = formspec .. "label[7,1;"..tomecc.localchar[name].points.."]"

  end



  core.show_formspec(name, "charactercreation", formspec)
end



core.register_on_player_receive_fields(function(player, formname, fields)
  if formname == "charactercreation_join" then -- Jointext Begin
    if fields.CreateChar then
      tomecc.create_char(player, 0)
    end
  end


  if formname == "charactercreation" then -- CC process

    local name = player:get_player_name()

    tomecc.localchar[name] = tomecc.localchar[name] or {current_step = 0, STR=10,DEX=10,WIS=10,INT=10,CON=10,CHA=10, points = 30}

    local chooseclass = findlist(get_keys(fields), "choose_class_")
    local chooserace = findlist(get_keys(fields), "choose_race_")
    local choosesex = findlist(get_keys(fields), "choose_sex_")

    if choosesex then -- step 0: Sex
      tomecc.localchar[name].sex = choosesex:gsub("choose_sex_", "")
      tomecc.localchar[name].current_step = 1
      tomecc.create_char(player, 1, {selected_element = chooseclass, currentchar = tomecc.localchar[name]})
      return
    end

    if chooseclass then -- step 1: Class
      tomecc.localchar[name].class = chooseclass:gsub("choose_class_", "")
      tomecc.create_char(player, 1, {selected_element = chooseclass, currentchar = tomecc.localchar[name]})
      return
    elseif chooserace then -- step 2: Race
      tomecc.localchar[name].race = chooserace:gsub("choose_race_", "")
      tomecc.create_char(player, 2, {selected_element = chooserace, currentchar = tomecc.localchar[name]})
      return
    end

    local selectclass = fields.select_class
    local selectrace = fields.select_race

    if selectclass then
      tomecc.localchar[name].current_step = 2
      tomecc.create_char(player, 2, {currentchar = tomecc.localchar[name]})
      return
    elseif selectrace then
      tomecc.localchar[name].current_step = 3
      tomecc.create_char(player, 3, {currentchar = tomecc.localchar[name]})
      return
    end

    local upstat = findlist(get_keys(fields), "_up")
    local downstat = findlist(get_keys(fields), "_down")


    if upstat and tomecc.localchar[name].points > 0 then -- step 1: Class
      print(upstat)
      tomecc.localchar[name].points = tomecc.localchar[name].points - 1
      tomecc.localchar[name][upstat:gsub("_up", "")] = tomecc.localchar[name][upstat:gsub("_up", "")] + 1
      tomecc.create_char(player, 3, {selected_element = upstat:gsub("_up", ""), currentchar = tomecc.localchar[name]})
      return
    elseif downstat and tomecc.localchar[name][downstat:gsub("_down", "")] > 5 then
      tomecc.localchar[name].points = tomecc.localchar[name].points + 1
      tomecc.localchar[name][downstat:gsub("_down", "")] = tomecc.localchar[name][downstat:gsub("_down", "")] - 1
      tomecc.create_char(player, 3, {selected_element = downstat:gsub("_down", ""), currentchar = tomecc.localchar[name]})
      return
    elseif upstat or downstat then return end


    if tomecc.localchar[name].current_step > 0 then -- if any other signal has been recieved, go to previous step.
      print(tomecc.localchar[name].current_step)
      tomecc.localchar[name].current_step = tomecc.localchar[name].current_step - 1
      tomecc.create_char(player, tomecc.localchar[name].current_step, {currentchar = tomecc.localchar[name]})
    end
  end
end)






core.register_on_joinplayer(function(player)

  if not tplayer.get_character(player) then
    --tomemusic.play(player, "generic")
    tomemusic.play(player, "fireplace", 2)

    tomecc.show_joinspec(player)
  end

end)
