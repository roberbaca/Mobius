package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;

class PowerUpEnergy extends FlxSprite
{

    private var speed:         Float = 75;

	public function new(X: Float, Y: Float)
	{
		super(X, Y);
        loadGraphic("assets/images/power-up-4.png", false, 24, 19);
            
        // AABB
        width = 36;
        height = 26;
        offset.set(-6, -4);
        
        scale.set(1.5,1.5);

    }

    override public function update(elapsed: Float)
    {
        super.update(elapsed);
        velocity.y = speed;               
    }
}