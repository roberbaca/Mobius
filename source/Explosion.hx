package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;


class Explosion extends FlxSprite
{
    private var time:       Float;
    private var scaleXY:    Float;

    public function new(X:Float, Y:Float, Time:Float, ScaleXY:Float)
    {
        super(X,Y);
       
        time = Time;
        scaleXY = ScaleXY;
       
        loadGraphic("assets/images/explosions.png", true, 32, 32);
        animation.add("explode", [0,1,2,3,4,5], 15, false);
        animation.play("explode");
        scale.set(scaleXY, scaleXY);
    }

    override public function update(elapsed: Float)
    {
        super.update(elapsed);

        // el objeto se destruye despues de transcurrido un tiempo "time"
        time--;
        if (time <= 0)
        {
            kill();
        }
    }

    override public function destroy():Void
    {
        super.kill();
    }
}