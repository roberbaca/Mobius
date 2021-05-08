package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;


class Enemy01 extends FlxSprite
{
    var W: 					        Float = 480; 					// ancho de la ventana
    var H: 					        Float = 640; 					// alto de la ventana
    static inline var ENEMY_VEL:    Float = 50;
    
    private var enemyBulletGroup:   FlxTypedGroup<EnemyBullet>;
    public var lastTimeShot:        Float;
  

	public function new(X: Float, Y: Float, Health:Float, EnemyBullet:FlxTypedGroup<EnemyBullet>)
	{
        super(X, Y);
        health = Health;
        enemyBulletGroup = EnemyBullet;
        lastTimeShot = 100;
        active = false;

        loadGraphic("assets/images/enemy01.png", false, 16, 12);
                
        // AABB
        width = 48;
        height = 36;   
        offset.set(-14, -12);

        scale.set(3,3);

        var timer = new FlxTimer();
        onRestartTimer(timer);
    }

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
        
        // los enemigos re aparecen por el lado opuesto de la pantalla
        if (x > W) 
        {
            x = 0;
        }
            
        if (x < 0) 
        {
            x = W;
        }


        // shoot time
        lastTimeShot--;

        if (lastTimeShot <= 0)
        {
            lastTimeShot = 100;
            attack();
        }
        
    }

    
    private function onTimerOff(theTimer: FlxTimer)
    {
        switch(FlxG.random.int(0, 3))
        {
            case 0:
                velocity.y = ENEMY_VEL*1.5;
                velocity.x = 0;
               
            case 1:
                velocity.y = -ENEMY_VEL*0.5;
                velocity.x = 0;
           
            case 2:
                velocity.y = ENEMY_VEL;
                velocity.x = ENEMY_VEL;
            
              
            case 3:
                velocity.y = ENEMY_VEL;
                velocity.x = -ENEMY_VEL;
                        
        }

        theTimer.start(FlxG.random.int(1, 3), onRestartTimer);
    }

    private function onRestartTimer(theTimer: FlxTimer)
    {
        velocity.x = velocity.y = 0;
        theTimer.start(FlxG.random.int(0, 3), onTimerOff);
    }

    private function attack():Void
    {
        if (active && y > 50)
        {   
            var newEnemyBullet = new EnemyBullet(x, y, 175, 2);
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