local wezterm = require 'wezterm'
local utils = require 'utils'

local CONFIG = {
   padding = 1,
   use_icons = true,
   colorize_icons = false,
}

--- @type table<number, string>
local tab_icons = {}

local function ansi(c)
   return { AnsiColor = c }
end

local function css(c)
   return { Color = c }
end

local icon_variants = utils.map({
   { 'cod_telescope', ansi('Teal') },
   { 'dev_coda',      css('#3A5F0B') },
   'dev_onedrive',
   'fa_bath',
   'fa_bug',
   'fa_eye',
   'fa_flask',
   'fa_fort_awesome',
   { 'fa_magic',  css('#7fcedc') },
   { 'fa_magnet', ansi('Grey') },
   'fa_microchip',
   'fa_plane',
   { 'fa_snowflake_o',  css('#002553') },
   'fa_subway',
   { 'fa_usd',          css('#118C4F') },
   { 'fae_apple_fruit', css('#4CBB17') },
   { 'fae_biohazard',   css('#EADF0C') },
   { 'fae_carot',       css('#F88017') },
   { 'fae_cherry',      ansi('Red') },
   { 'fae_crown',       css('#ffd700') },
   { 'fae_comet',       css('#61667D') },
   'fae_dna',
   { 'fae_donut',     css('#FAAFBE') },
   { 'fae_ice_cream', css('#FDB6D0') },
   'fae_popcorn',
   'fae_poison',
   { 'fae_planet',       css('#A49B72') },
   { 'fae_ruby',         css('#E0115F') },
   { 'fae_tooth',        ansi('White') },
   { 'linux_ferris',     css('#F13408') },
   { 'mdi_basketball',   css('#F88158') },
   { 'mdi_clover',       css('#3EA055') },
   { 'mdi_currency_eth', css('#7095F7') },
   { 'mdi_ghost',        ansi('White') }
}, function(i)
   if type(i) == 'string' then
      return wezterm.nerdfonts[i]
   end

   if type(i) == 'table' then
      if CONFIG.use_icon_colors then
         return wezterm.format {
            { Foreground = i[2] },
            { Text = wezterm.nerdfonts[i[1]] },
         }
      else
         return wezterm.nerdfonts[i[1]]
      end
   end

   error('unexpected type')
end)

wezterm.on(
   'format-tab-title',
   function(tab)
      -- start indexing tabs from 1
      local index = tab.tab_index + 1
      local id = tab.tab_id
      local pad = string.rep(' ', CONFIG.padding)

      if CONFIG.use_icons then
         if tab_icons[id] == nil then
            tab_icons[id] = icon_variants[math.random(#icon_variants)]
         end

         local icon = tab_icons[id]
         return string.format('%s%s %d%s', pad, icon, index, pad)
      end

      return string.format('%s %d %s', pad, index, pad)
   end
)


return {
   enable_tab_bar = true,
   use_fancy_tab_bar = false,
   tab_bar_at_bottom = true,
   show_new_tab_button_in_tab_bar = false,
}
