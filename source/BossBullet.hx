import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;

class BossBullet extends FlxSprite
{

    private var speed:      Float;
    public var damage:      Int;


    public function new(X:Float, Y:Float,Speed:Float, Damage:Int)
    {
        super(X,Y);
        
        speed = Speed;
        damage = Damage;
        
        loadGraphic("assets/images/bossShots.png", false, 18, 21);
        scale.set(2,2);

        width = 36;
        height = 42;
        offset.set(-8, -8);
    }

    override public function update(elapsed: Float)
    {
        super.update(elapsed);

        velocity.y = speed;     
           
    }

    override public function destroy()
    {
        kill();   
    }

  
}