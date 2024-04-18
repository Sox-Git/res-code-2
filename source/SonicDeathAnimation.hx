package;

import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class SonicDeathAnimation extends FlxSprite
{
    public var exeanimOffsets:Map<String, Array<Dynamic>>;

    public function new(x:Float, y:Float)
        {
            super(x, y);

            exeanimOffsets = new Map<String, Array<Dynamic>>();

            var tex:FlxAtlasFrames;
            antialiasing = true;

            tex = Paths.getSparrowAtlas('gameovers/DeathScreenSonicExe');
			frames = tex;
			animation.addByPrefix('firstDeath', 'appear', 24, false);
			animation.addByPrefix('deathLoop', 'deathLoopSonicExe instance 1', 24, true);
            animation.addByPrefix('deathConfirm', 'deathConfirmSonicExe instance 1', 24, false);

            addOffset('firstDeath', -27, -63);
            addOffset('deathLoop', -25, -80);
            addOffset('deathConfirm', -57,-80);
        }

        public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
            {
                animation.play(AnimName, Force, Reversed, Frame);
        
                var daOffset = exeanimOffsets.get(AnimName);
                if (exeanimOffsets.exists(AnimName))
                {
                    offset.set(daOffset[0], daOffset[1]);
                }
                else
                    offset.set(0, 0); 
            }

        public function addOffset(name:String, x:Float = 0, y:Float = 0)
                {
                    exeanimOffsets[name] = [x, y];
                }
        
        override function update(elapsed:Float)
            {

                if (animation.curAnim.name == 'firstDeath' && animation.curAnim.finished)
                    {
                        playAnim('deathLoop');
        
                    }

                if (animation.curAnim.name == 'deathConfirm' && animation.curAnim.finished)
                    {
                        visible = false;
        
                    }
                super.update(elapsed);
            }     
}