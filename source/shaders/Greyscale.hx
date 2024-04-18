package shaders;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;

class Greyscale extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		
		void main() {
			vec4 color = texture2D(bitmap, openfl_TextureCoordv);
			float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
			gl_FragColor = vec4(vec3(gray), color.a);
		}
	')
	
	public function new(){
		super();
	}
}
