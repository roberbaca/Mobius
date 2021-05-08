import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;

class Asteroids extends FlxSprite
{

    private var speedY:         Float;
    private var speedX:         Float;
    private var rotation:       Float;

    public function new(X:Float, Y:Float, SpeedX:Float, SpeedY:Float, Rotation:Float, Health:Float)
    {
        super(X,Y);
        speedY = SpeedY;
        speedX = SpeedX;
        rotation = Rotation;
        health = Health;

        loadGraphic("assets/images/meteor-1.png", true, 42, 39);

    }

    override public function update(elapsed: Float)
    {
        super.update(elapsed);

        velocity.y = speedY;
        velocity.x = speedX;
        angle += rotation;     
           
    }

    public function damage(damage:Float)
    {
        health -= damage;
    }
  
    public function isDestroyed():Bool
    {
        if (health <= 0)
        {
            return true;
        }
        
        return false;
    }
   
}