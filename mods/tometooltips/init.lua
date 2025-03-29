minetest.register_on_mods_loaded(function()
  for name, def in pairs(minetest.registered_items) do
    if def._tlcomment then
      local color = def._tlcolor or "grey"
      def.description = def.description.."\n"..core.colorize(color, def._tlcomment)

      core.override_item(name, {description = def.description})
    end
  end
end)
