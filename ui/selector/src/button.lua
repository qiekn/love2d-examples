local Class = require("lib.class")

---@class Button
local Button = Class:extend()

function Button:new(x, y, w, h, callback)
  self.x = x or 0
  self.y = y or 0
  self.w = w or 100
  self.h = h or 50
  self.callback = callback or function() end
  self.color = { 0, 0, 0 } -- default color black
end

function Button:setColor(color)
  self.color = color
end

function Button:resize(w, h)
  self.w = w
  self.h = h
end

function Button:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Button
