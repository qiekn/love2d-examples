extern number width;
extern number height;
extern number length;
extern number thickness;
extern vec4 selector_color;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
  vec2 uv = texture_coords;
  vec2 pos = uv * vec2(width, height);

  bool isCorner = false;

  // top left
  if ((pos.x <= length && pos.y <= thickness) || 
    (pos.x <= thickness && pos.y <= length)) {
    isCorner = true;
  }

  // top right
  else if ((pos.x >= width - length && pos.y <= thickness) || 
    (pos.x >= width - thickness && pos.y <= length)) {
    isCorner = true;
  }

  // bottom left
  else if ((pos.x <= length && pos.y >= height - thickness) || 
    (pos.x <= thickness && pos.y >= height - length)) {
    isCorner = true;
  }

  // bottom right
  else if ((pos.x >= width - length && pos.y >= height - thickness) || 
    (pos.x >= width - thickness && pos.y >= height - length)) {
    isCorner = true;
  }

  if (isCorner) {
    return selector_color;
  }
  return vec4(0.0, 0.0, 0.0, 0.0);
}
