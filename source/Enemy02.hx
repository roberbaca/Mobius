package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;


class Enemy02 extends FlxSprite
{
    static inline var ENEMY_VEL:    Float = 250;
    
    private var enemyBulletGroup:   FlxTypedGroup<EnemyBullet>;
    public var lastTimeShot:        Float;
  

	public function new(X: Float, Y: Float, Health:Float, EnemyBullet:FlxTypedGroup<EnemyBullet>)
	{
        super(X, Y);
        health = Health;
        enemyBulletGroup = EnemyBullet;
        lastTimeShot = 75;
        active = false;

        loadGraphic("assets/images/enemy02.png", false, 16, 14);
        scale.set(3,3);
    }

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
        
        // shoot time
        lastTimeShot--;

        if (lastTimeShot <= 0)
        {
            lastTimeShot = 75;
            attack();
        }
        
        velocity.y = ENEMY_VEL;

    }

    
    private function attack():Void
    {
        if (active && y > 50)
        {   
            var newEnemyBullet = new EnemyBullet(x, y, 400, 2);
            enemyBulletGroup.add(newEnemyBullet);
        }
    }

    public function isDestroyed():Bool
    {
        if (health <= 0)
        {
             return true;
        }
            
         return false;
    }

    public function damage(damage:Float)
    {
        health -= damage;
    }
    
}