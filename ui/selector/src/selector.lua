local Class = require("lib.class")
local colors = require("colors")

require("utils")

local SELECTOR_IMAGE = love.graphics.newImage("res/images/selector.png")
local SELECTOR_SHADER = love.graphics.newShader("res/shaders/selector.glsl")
local SELECTOR_SHADOW_OFFSET = 2
local SELECTOR_SIZE = 30
local SELECTOR_LENGTH = 10
local SELECTOR_THICKNESS = 3
local SELECTOR_MARGIN = 3 + SELECTOR_THICKNESS

---@class Selector
local Selector = Class:extend()

function Selector:new(x, y, w, h, s)
  print("selector -> new")
  self.image = SELECTOR_IMAGE

  self.x = x or love.graphics.getWidth() / 2
  self.y = y or love.graphics.getHeight() / 2
  self.w = w or 100
  self.h = h or 100
  self.s = s or 1

  self.targetX = x
  self.targetY = y
  self.targetW = w
  self.targetH = h

  self.shader = SELECTOR_SHADER
  self.shader:send("length", SELECTOR_LENGTH)
  self.shader:send("thickness", SELECTOR_THICKNESS)
end

function Selector:move(x, y)
  self.targetX = self.targetX + x
  self.targetY = self.targetY + y
end

function Selector:focus(button)
  if button:is(Button) then
    self.targetX = button.x - SELECTOR_MARGIN
    self.targetY = button.y - SELECTOR_MARGIN
    self.targetW = button.w + SELECTOR_MARGIN * 2
    self.targetH = button.h + SELECTOR_MARGIN * 2
  else
    error("Selector:focus expects a Button instance")
  end
end

function Selector:update(dt)
  local lerpFactor = 5 * dt -- Interpolation factor, larger values move faster
  self.x = lerp(self.x, self.targetX, lerpFactor)
  self.y = lerp(self.y, self.targetY, lerpFactor)
  self.w = lerp(self.w, self.targetW, lerpFactor)
  self.h = lerp(self.h, self.targetH, lerpFactor)
end

function Selector:draw()
  love.graphics.setShader(self.shader)
  self.shader:send("width", self.w)
  self.shader:send("height", self.h)
  self.shader:send("selector_color", { 0.0, 0.0, 0.0, 0.15 })
  local sx, sy = self.w / SELECTOR_SIZE, self.h / SELECTOR_SIZE

  -- Draw shadow
  love.graphics.draw(self.image, self.x + SELECTOR_SHADOW_OFFSET, self.y + SELECTOR_SHADOW_OFFSET, 0, sx, sy)
  self.shader:send("selector_color", { 236 / 255, 214 / 255, 148 / 255, 1.0 })

  -- Draw selector
  love.graphics.draw(self.image, self.x, self.y, 0, sx, sy)
  love.graphics.setShader()
end

return Selector
