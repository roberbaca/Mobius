package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;



class Boss extends FlxSprite
{
    var W: 					        Float = 480; 					// ancho de la ventana
    var H: 					        Float = 640; 					// alto de la ventana
    static inline var ENEMY_VEL:    Float = 50;
    
    private var bossBulletGroup:    FlxTypedGroup<BossBullet>;
    public var lastTimeShotR:       Float;
    public var lastTimeShotL:       Float;
   
    
	public function new(X: Float, Y: Float, BossBullet:FlxTypedGroup<BossBullet>)
	{
        super(X, Y);

        health = 200;
        bossBulletGroup = BossBullet;
        lastTimeShotR = 100;
        lastTimeShotL = 120;
        active = false;

        loadGraphic("assets/images/Boss.png", true, 90, 74);
        animation.add("left", [2], 1, false);
        animation.add("right", [1], 11, false);
        animation.add("idle", [3], 1, false);
		animation.play("idle");
                
        // AABB
        width = 180;
        height = 130;   
        offset.set(-48, -24);

        scale.set(2,2);

        var timer = new FlxTimer();
        onRestartTimer(timer);
         

    }

    public override function update(elapsed: Float)
    {
        super.update(elapsed);
        
        // el Boss se mueve entre los limites de la pantalla
        if (x > W - width) 
        {
            x = W- width;
        }
            
        if (x < 0 + width) 
        {
            x = 0 + width;
        }


        // avanza con cierta velocidad y luego se detiene
        if (y<100)
        {
            velocity.y = ENEMY_VEL;
        }
        else 
        {
            velocity.y = 0;
        }


        // shoot time. Dispara en forma alternada entre los cañones de los 
        // brazos izquierdo y derecho
        lastTimeShotR--;
        lastTimeShotL--;

        if (lastTimeShotR <= 0)
        {
            lastTimeShotR = 100;
            attackLeft();
        }

      
        if (lastTimeShotL <= 0)
        {
            lastTimeShotL = 100;
            attackRight();
        }
        
        
    }

    
    private function onTimerOff(theTimer: FlxTimer)
    {
        switch(FlxG.random.int(0, 1))
        {
            case 0:
                velocity.y = 0;
                velocity.x = -ENEMY_VEL;
           
            case 1:
                velocity.y = 0;
                velocity.x = ENEMY_VEL;          
                        
        }

        theTimer.start(FlxG.random.int(1, 3), onRestartTimer);
    }

    private function onRestartTimer(theTimer: FlxTimer)
    {
        velocity.x = velocity.y = 0;
        theTimer.start(FlxG.random.int(0, 3), onTimerOff);
    }

    private function attackLeft():Void
    {
        if (active && y > 50)
        {   
            animation.play("left");
            var newBossBullet = new BossBullet(x-2, y+132, 225, 3);
            bossBulletGroup.add(newBossBullet);
            FlxG.sound.play(Reg.SND_BOSS_FIRE);
        }
    }

    private function attackRight():Void
    {
        if (active && y > 50)
        {   
            animation.play("right");
            var newBossBullet2 = new BossBullet(x+138, y+132, 225, 3);
            bossBulletGroup.add(newBossBullet2);
            FlxG.sound.play(Reg.SND_BOSS_FIRE);
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

    public function get_health(): Float
    {
        // devuelve la energia restante de la nave
        return health;
    }
    
    
}