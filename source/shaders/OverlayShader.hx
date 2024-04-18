package shaders;

import flixel.system.FlxAssets.FlxShader;

class OverlayShader extends FlxShader {
	@:glFragmentSource('
		#pragma header
		uniform vec4 uBlendColor;
		
		vec3 blendLighten(vec3 base, vec3 blend) {
			return mix(1.0 - 2.0 * (1.0 - base) * (1.0 - blend), 2.0 * base * blend, step(base, vec3(0.5)));
		}
		
		vec4 blendLighten(vec4 base, vec4 blend, float opacity) {
			//return (blendLighten(base.rgb, blend.rgb) * opacity + base.a * (1.0 - opacity)); // BASE, PIECE OF DOGSHT
			
			//return vec4(blendLighten(base.rgb, blend.rgb), base.a * (1.0 - opacity) + blend.a * opacity); // MOD1, BASIC ONE
			return vec4(blendLighten(base.rgb, blend.rgb) * opacity + base.rgb * (1.0 - opacity), max(base.a, blend.a)); // MOD2, BINGCHILLIMG(MAY NOT BE ACCURATE)
		}
		
		void main() {
			vec4 base = texture2D(bitmap, openfl_TextureCoordv);
			//vec4 uBlendColor = vec4(1.0, 1.0, 0.0, 1.0); // FOR TESTING(YELLOW OUTPUT)
			gl_FragColor = blendLighten(base, uBlendColor, uBlendColor.a);
		}
	')
	public function new() {
		super();
	}
}