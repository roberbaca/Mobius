
import flixel.math.FlxVelocity;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxAngle;
import flixel.util.FlxSpriteUtil;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;

class Ship extends FlxSprite
{
	public static inline var SPEED: Float = 120; 			// velocidad de movimiento

	var is_alive:			Bool = true;					// bandera
	var goToGameOver:		Bool = false;					// bandera
	var W: 					Float = 480; 					// ancho de la ventana
	var H: 					Float = 640; 					// alto de la ventana
	var energyPlayer: 		Int; 							// energia de la nave
	var invulnerable:       Bool = false;  					// bandera para ver si es invulnerable


	public function new(X: Float, Y: Float):Void
	{
    	super(X, Y);
		loadGraphic("assets/images/player.png", true, 16, 22);
		animation.add("idle", [0, 1, 2, 3], 15, true);
		animation.add("boom", [4, 5, 6, 7], 10, false);
		animation.play("idle");
		scale.set(3, 3);

		width = 48;
		height = 36;
		offset.set(-16, -20);

		energyPlayer = 10;
		velocity.x = SPEED;
		

	}

	

	public override function update(elapsed: Float)
	{
		super.update(elapsed);
					
		/*
			Al tocar el boton X la nave cambia el sentido de desplazamiento en el eje horizontal.
			Cuando la nave sale fuera de los limites de la pantalla, aparece por el lado opuesto.
		*/


		/*
		-------------------------------------
		 MOVIMIENTO Y ANIMACIONES DE LA NAVE
		-------------------------------------
		*/

		if (is_alive)
		{
			if (FlxG.keys.justPressed.X) // unico boton
			{
				if (velocity.x > 0)
				{
					velocity.x = - SPEED;
				}
				else if (velocity.x < 0)
				{
					velocity.x = SPEED;
				}
			}
		}
		else
		{
			velocity.x = 0;
		}
		
	
		// vuelve a aparecer del lado opuesto de la ventana
		if (x > W) 
		{
			x = 0;
		}
		
		if (x < -width) 
		{
			x = W;
		}
		

		if (isDestroyed() && is_alive)
		{
			animation.play("boom");
			FlxG.sound.play(Reg.SND_EXPLOSION);
			is_alive = false;
		}
	
		if (animation.finished && !is_alive)
		{
			kill();
			goToGameOver = true; // voy a la pantalla de Game Over
		}
	
	}

	public function isDestroyed():Bool
	{
		if (energyPlayer <= 0)
		{
			return true;
		}
		
		return false;
	}

	public function take_hit(damage:Int)
	{
		// quita energia a la nave.
		// le concede un período de gracia (lo hace invulnerable) por 2 segundos.
		if (energyPlayer >= 0 && !invulnerable)
		{
			energyPlayer -= damage;
			FlxFlicker.flicker(this,0.5,0.04,true); // efecto flickering
			invulnerable = true;
		}
		
		// transcurridos 1 segundos, la nave vuelve a ser vulnerable
		var timer = new FlxTimer();
		timer.start(1, function(t: FlxTimer){invulnerable = false;});
 	
	}
	

	public function get_energy()
	{
		// devuelve la energia restante de la nave
		return energyPlayer;
	}

	public function add_energy(energy:Int)
	{

		// la energia de la nave no puede ser mayor a 10
		
		if (energyPlayer + energy >= 10 )
		{
			energyPlayer = 10;
		}
		else
		{
			energyPlayer += energy;
		}
	}
	

	public function get_playerState()
	{		
		return goToGameOver;
	}

	public function is_flickering()
	{
		return FlxFlicker.isFlickering(this);
	}
	
}
