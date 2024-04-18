package shaders;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;

class Wow extends FlxShader
{
  @:glFragmentSource('
		#pragma header
		
		void main()
        {
	        #pragma body
	        vec2 uv = openfl_TextureCoordv;
    
            vec4 blueScreen = vec4(0.,0.,1.,1.);
            vec4 col = flixel_texture2D(bitmap, uv);
    
            vec3 diff = col.xyz - blueScreen.xyz;
            float fac = smoothstep(0.55-0.05,0.55+0.05, dot(diff,diff));
    
            col = mix(col, vec4(0., 0., 0., 0.), 1.-fac);
            
            vec4 transparentScreen = vec4(0.,0.,0.,0.);
            vec4 col2 = flixel_texture2D(bitmap, uv);
    
            vec3 diff2 = col2.xyz - transparentScreen.xyz;
            float fac2 = smoothstep(0.55-0.05,0.55+0.05, dot(diff2,diff2));
    
            col2 = mix(col, vec4(0., 0., 0., 1.), 1.-fac2);
            
            vec4 finalCol = mix(col, col2, 1.);
            
	        gl_FragColor = finalCol;
        }
  ')
  public function new()
  {
    super();
  }
}