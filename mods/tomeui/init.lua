tomeui = {}



-- Element: {type = "button/label/image/etc", pos = {x=0,y=0}, size = {x=2,y=1}}

function tomeui.style(element)

  local image = "tomeui_button_default.png"

  local precursor = ""

  local finalel = element.type .. "[" .. element.pos.x .. "," .. element.pos.y

  if element.size then
    finalel = finalel .. ";" .. element.size.x .. "," .. element.size.y
  end

  if element.type == "image" or element.type == "image_button" or element.type == "image_button_exit" then
    local pressable
    if not element.image then
      image = "tomeui_button_default.png"
      finalel = finalel .. ";" .. image
    elseif not string.find(element.image, ".png") then
      pressable = true
      image = "tomeui_button_" .. element.image .. ".png"
      -- certain dimension eg: "2x1", "1x1", "1x2", "dark", "light" etc.
      finalel = finalel .. ";" .. image
    else
      image = element.image
      finalel = finalel .. ";" .. image
    end

    if pressable then
      local pimage = image:gsub(".png", "_pressed.png")
      precursor = precursor .. --"image[" .. element.pos.x-2 .. "," .. element.pos.y-0.2 .. ";" .. element.size.x+0.4 .. "," .. element.size.y+0.4 .. ";tomeui_button_darker.png]"..
      "style["..element.name..":pressed;size=2,2;fgimg="..pimage..";border=false]"
    end
  end

  if element.type == "image_button" or element.type == "image_button_exit" then
    finalel = finalel .. ";" .. element.name .. ";" .. element.label
  end

  if type == "label" then
    finalel = finalel .. ";" .. element.label
  end


  return precursor .. finalel .. "]"
end

--[[
function tomeui.basic(name, elements)
  local formspec = ""

  for element in elements do
  end

end]]
