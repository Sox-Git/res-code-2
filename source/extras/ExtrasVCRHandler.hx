package extras;

import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import openfl.Lib;

class ExtrasVCRHandler
{
	public static var vcr:ShaderFilter = new ShaderFilter(new ExtrasVCRShader());

	public static function vcrSet(glitchFactor:Float, distortion:Bool=true, perspectiveOn:Bool=true, vignetteMoving:Bool=true):Void
	{
		vcr.shader.data.iTime.value = [0];
		vcr.shader.data.vignetteOn.value = [true];
		vcr.shader.data.perspectiveOn.value = [perspectiveOn];
		vcr.shader.data.distortionOn.value = [distortion];
		vcr.shader.data.scanlinesOn.value = [true];
		vcr.shader.data.vignetteMoving.value = [vignetteMoving];
		vcr.shader.data.glitchModifier.value = [glitchFactor];
		vcr.shader.data.iResolution.value = [Lib.current.stage.stageWidth,Lib.current.stage.stageHeight];
	}
	
	public function update(elapsed:Float) {
		vcr.shader.data.iTime.value[0] += elapsed;
		vcr.shader.data.iResolution.value = [Lib.current.stage.stageWidth,Lib.current.stage.stageHeight];
	}
}
