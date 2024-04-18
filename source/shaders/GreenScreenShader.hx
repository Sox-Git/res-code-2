package shaders;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;

// https://www.youtube.com/watch?v=RFRmlPC8Ujo
// TODO: maybe make a GreenScreenSprite or whatever
// https://www.shadertoy.com/view/4dX3WN
class GreenScreenShader extends FlxShader {
	#if mobile
		@:glFragmentSource('
			#pragma header
			
			vec3 rgb2hsv(vec3 rgb) {
				float Cmax = max(rgb.r, max(rgb.g, rgb.b));
				float Cmin = min(rgb.r, min(rgb.g, rgb.b));
				float delta = Cmax - Cmin;
				vec3 hsv = vec3(0.0, 0.0, Cmax);
				if (Cmax > Cmin) {
					hsv.y = delta / Cmax;
					if (rgb.r == Cmax) {
						hsv.x = (rgb.g - rgb.b) / delta;
					} else {
						if (rgb.g == Cmax) {
							hsv.x = 2.0 + (rgb.b - rgb.r) / delta;
						} else {
							hsv.x = 4.0 + (rgb.r - rgb.g) / delta;
						}
					}
					hsv.x = fract(hsv.x / 6.0);
				}
				return hsv;
			}
			
			float chromaKey(vec3 color) {
				vec3 backgroundColor = vec3(0.0, 1.0, 0.0);
				vec3 weights = vec3(6.0, 216.0 / 225.0, 1.0);
				vec3 hsv = rgb2hsv(color);
				vec3 target = rgb2hsv(backgroundColor);
				float dist = length(weights * (target - hsv));
				return 1.0 - clamp(3.0 * dist - 1.5, 0.0, 1.0);
			}
			
			vec3 changeSaturation(vec3 color, float saturation) {
				float luma = dot(vec3(0.213, 0.715, 0.072) * color, vec3(1.0));
				return mix(vec3(luma), color, saturation);
			}
			
			void main() {
				vec2 uv = openfl_TextureCoordv;
				vec4 rColor = flixel_texture2D(bitmap, uv);
				vec3 color = rColor.rgb * rColor.a;
				float incrustation = 1.0 - chromaKey(color);
				gl_FragColor = vec4(color * incrustation, incrustation);
			}
		') //I JUST COPIED IT, ITS THE SAME LOL
	#else
		@:glFragmentSource('
			#pragma header
			
			vec3 rgb2hsv(vec3 rgb) {
				float Cmax = max(rgb.r, max(rgb.g, rgb.b));
				float Cmin = min(rgb.r, min(rgb.g, rgb.b));
				float delta = Cmax - Cmin;
				vec3 hsv = vec3(0.0, 0.0, Cmax);
				if (Cmax > Cmin) {
					hsv.y = delta / Cmax;
					if (rgb.r == Cmax) {
						hsv.x = (rgb.g - rgb.b) / delta;
					} else {
						if (rgb.g == Cmax) {
							hsv.x = 2.0 + (rgb.b - rgb.r) / delta;
						} else {
							hsv.x = 4.0 + (rgb.r - rgb.g) / delta;
						}
					}
					hsv.x = fract(hsv.x / 6.0);
				}
				return hsv;
			}
			
			float chromaKey(vec3 color) {
				vec3 backgroundColor = vec3(0.0, 1.0, 0.0);
				vec3 weights = vec3(6.0, 216.0 / 225.0, 1.0);
				vec3 hsv = rgb2hsv(color);
				vec3 target = rgb2hsv(backgroundColor);
				float dist = length(weights * (target - hsv));
				return 1.0 - clamp(3.0 * dist - 1.5, 0.0, 1.0);
			}
			
			vec3 changeSaturation(vec3 color, float saturation) {
				float luma = dot(vec3(0.213, 0.715, 0.072) * color, vec3(1.0));
				return mix(vec3(luma), color, saturation);
			}
			
			void main() {
				vec2 uv = openfl_TextureCoordv;
				vec4 rColor = flixel_texture2D(bitmap, uv);
				vec3 color = rColor.rgb * rColor.a;
				float incrustation = 1.0 - chromaKey(color);
				gl_FragColor = vec4(color * incrustation, incrustation);
			}
		')
	#end
	public function new() {
		super();
	}
}
