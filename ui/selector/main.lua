package.path = "src/?.lua;" .. package.path
require("global")

local Colors = require("colors")
Button = require("button")
Selector = require("selector")

local buttons = {}

---@type Selector
local selector = Selector(100, 100, 100, 100, 1)
local currentFoucsIndex = 0

------------------------------------------------------------------------
--                           Löve Callbacks                           --
------------------------------------------------------------------------
function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.setBackgroundColor(Colors.WHITE)

  -- Add buttons
  table.insert(buttons, Button(100, 100, 300, 50))
  table.insert(buttons, Button(500, 300, 100, 150))
  table.insert(buttons, Button(200, 200, 100, 50))
  buttons[1]:setColor(Colors.GREEN)
  buttons[2]:setColor(Colors.RED)
  buttons[3]:setColor(Colors.BLUE)

  selector:focus(buttons[1]) -- Set initial focus on the first button
end

function love.update(dt)
  selector:update(dt)
end

function love.draw()
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  -- Draw Buttons
  for _, button in pairs(buttons) do
    button:draw()
  end
  -- Draw Selector
  selector:draw()
end

function love.keypressed(key)
  if key == "tab" then
    currentFoucsIndex = (currentFoucsIndex + 1) % #buttons
    if #buttons > 0 then
      selector:focus(buttons[currentFoucsIndex + 1])
    end
  end
end
