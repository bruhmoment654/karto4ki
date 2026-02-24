#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;   // float 0, 1
uniform float uTime;  // float 2
uniform vec3 uAccent;  // float 3, 4, 5

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;

    vec2 dir = normalize(vec2(-0.4226, 0.9063));
    float t = dot(uv - 0.5, dir) + 0.5;

    float shift = uTime;
    float st = fract(t - shift);

    vec3 baseDark = vec3(0.07);
    vec3 dark   = mix(baseDark, uAccent, 0.02);
    vec3 accent = mix(baseDark, uAccent, 0.14);

    float peak = 0.5;
    float w = 0.25;
    float blend = exp(-pow((st - peak) / w, 2.0));

    vec3 col = mix(dark, accent, blend);

    col += uAccent * 0.01 * blend;

    vec2 seed = FlutterFragCoord().xy;
    float noise = fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453);
    col += (noise - 0.5) / 255.0;

    fragColor = vec4(col, 1.0);
}
