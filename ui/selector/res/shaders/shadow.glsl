extern number radius;       // 发光半径（像素）
extern vec4 glowColor;      // 发光颜色

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    float glow = 0.0;
    float alpha = Texel(tex, texture_coords).a;

    if (alpha > 0.0) {
        return color * Texel(tex, texture_coords); // 原图像素
    }

    // 做一个简单的周围 alpha 模糊采样
    float samples = 8.0;
    for (float x = -radius; x <= radius; x += radius / samples) {
        for (float y = -radius; y <= radius; y += radius / samples) {
            vec2 offset = vec2(x, y) / love_ScreenSize.xy;
            glow += Texel(tex, texture_coords + offset).a;
        }
    }

    glow = clamp(glow / (samples * samples), 0.0, 1.0);
    return vec4(glowColor.rgb, glow * glowColor.a);
}
