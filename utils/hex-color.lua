function HEX(hex)
  assert(
    type(hex) == "string" and #hex == 7 and hex:sub(1, 1) == "#",
    "The HEX parameter must be a string in the #rrggbb format."
  )

  local r = tonumber(hex:sub(2, 3), 16) / 255
  local g = tonumber(hex:sub(4, 5), 16) / 255
  local b = tonumber(hex:sub(6, 7), 16) / 255

  return { r, g, b, 1 }
end
