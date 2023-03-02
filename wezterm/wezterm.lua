local utils = require 'utils'

require('status').enable()

local modules = utils.map(
                    {'window', 'font', 'theme', 'tab', 'misc', 'keybinds'},
                    utils.req)

return utils.merge(table.unpack(modules))
