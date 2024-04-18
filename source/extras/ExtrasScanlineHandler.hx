package extras;

import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import openfl.Lib;

class ExtrasScanlineHandler
{
	public static var scanline:ShaderFilter = new ShaderFilter(new ExtrasScanlineShader());
	
	public static function lockAlphaSet(value:Bool=true):Void
	{
		scanline.shader.data.lockAlpha.value = [value];
	}
}
