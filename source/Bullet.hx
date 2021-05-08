import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;

class Bullet extends FlxSprite
{

    private var speed:      Float;
    private var damage:     Float;


    public function new(X:Float, Y:Float,Speed:Float, Damage:Float)
    {
        super(X,Y);
        
        speed = Speed;
        damage = Damage;
        
        loadGraphic("assets/images/playerBullets.png", true, 8, 9);
        scale.set(3,3);

        width = 24;
        height = 27;
        offset.set(-8, -8);
    }

    override public function update(elapsed: Float)
    {
        super.update(elapsed);

        velocity.y = -speed;     
           
    }

    override public function destroy()
    {
        kill();   
    }

  
}