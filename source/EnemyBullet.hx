import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVelocity;

class EnemyBullet extends FlxSprite
{

    private var speed:      Float;
    private var damage:     Float;


    public function new(X:Float, Y:Float,Speed:Float, Damage:Float)
    {
        super(X,Y);
        
        speed = Speed;
        damage = Damage;
        
        loadGraphic("assets/images/enemyBullet.png", false, 6, 6);
        scale.set(3,3);

        width = 18;
        height = 18;
        offset.set(-6, -6);
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