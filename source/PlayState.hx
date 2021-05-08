package;

import haxe.Exception;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.util.FlxColor; 
import flixel.effects.FlxFlicker;
import Reg;




class PlayState extends FlxState
{
	var ship: 					Ship;								// jugador
	var playerCollideables: 	FlxGroup;							// grupo para todos los objetos con los que puede colisionar el jugador

	var hud:					HUD;								// instancia de la clase HUD
	var scoreText:				FlxText;							// texto en pantalla con el puntaje
	var bossHPText:				FlxText;							// texto en pantalla con la vida del boss

	var background:				FlxSprite; 
	var scrollingSpeed:			Float = 70;							// velocidad de scrolleo
	
	var shootTime:				Float = 0;							// shooting time 
	var newBullet:				Bullet;								// disparo del jugador
	//var newBullet2:				Bullet;
	var playerBulletsGroup: 	FlxTypedGroup<Bullet>;				// grupo para los disparos del jugador
   
	var asteroid:				Asteroids;
	var asteroidGroup:		 	FlxTypedGroup<Asteroids>;			// grupo para los asteroides

	var eneryPowerUp:			PowerUpEnergy;
	var energyPowerUpGroup:		FlxTypedGroup<PowerUpEnergy>;		// grupo para los powerUps

	var enemy01:				Enemy01;
	var enemy02:				Enemy02;
	var enemiesGroup1: 			FlxTypedGroup<Enemy01>;				// grupo para los enemigos
	var enemiesGroup2: 			FlxTypedGroup<Enemy02>;				// grupo para los enemigos
	var enemyBulletGroup: 		FlxTypedGroup<EnemyBullet>;			// grupo para los disparos enemigos

	var boss:					Boss;								// instancia del jefe final
	var bossGroup: 				FlxTypedGroup<Boss>;				
	var bossBulletGroup: 		FlxTypedGroup<BossBullet>;			// grupo para los disparos del jefe final
	
	var time_to_fade: 			Float = 3;							// tiempo para fade effect
	var time_to_next_wave: 		Float = 0;							// tiempo para avanzar al nivel siguiente
	var time_to_powerup:		Float = 0;							// tiempo para la aparicion de un powerup
	var randomtime:				Float = 0;							// tiempo random
	var wave1_over:				Bool = false;						// bandera para controlar la finalizacion de cada "ola"
	var wave2_over:				Bool = false;						// bandera para controlar la finalizacion de cada "ola"
	var wave3_over:				Bool = false;						// bandera para controlar la finalizacion de cada "ola"
	var wave4_over:				Bool = false;						// bandera para controlar la finalizacion de cada "ola"
	var wave5_over:				Bool = false;						// bandera para controlar la finalizacion de cada "ola"
	var waveBoss_over:			Bool = false;						// bandera para controlar la finalizacion de cada "ola"

	var gameOver:				Bool;								// bandera par fin del juego
	var win:					Bool;								// bandera para determinar condicion de victoria

	override public function create():Void
	{
		super.create();

		//FlxG.debugger.visible = true; 				// para debug visible por codigo

		Reg.score = 0;					 				// reseteo el puntaje
		gameOver = false;								
		win = false;									
		
		FlxG.sound.playMusic(Reg.MUSIC_LEVEL,1,true);	// musica (looping)
		
		randomtime = Std.random(10) + 10;				// tiempo random de aparicion del powerUp

		// creo los grupos
		enemiesGroup1 = new FlxTypedGroup<Enemy01>();
		enemiesGroup2 = new FlxTypedGroup<Enemy02>();
			
		enemyBulletGroup = new FlxTypedGroup<EnemyBullet>();
		bossGroup = new FlxTypedGroup<Boss>();
		bossBulletGroup = new FlxTypedGroup<BossBullet>();

		asteroidGroup = new FlxTypedGroup<Asteroids>();
		energyPowerUpGroup = new FlxTypedGroup<PowerUpEnergy>();
		playerBulletsGroup = new FlxTypedGroup<Bullet>();
		playerCollideables = new FlxGroup();

		// objetos con los que puede colisiones el jugador.
		playerCollideables.add(enemiesGroup1);	
		playerCollideables.add(enemiesGroup2);	
		playerCollideables.add(enemyBulletGroup);
		playerCollideables.add(bossBulletGroup);
		playerCollideables.add(asteroidGroup);
		playerCollideables.add(energyPowerUpGroup);

		background = new FlxSprite(0,0,"assets/images/backgroundLoop.png");  
		background.y = -480;
		background.velocity.y = scrollingSpeed;
		
	
		ship = new Ship(Std.int(FlxG.width/2), Std.int(FlxG.height-128));
		
		// HUD mostrado en la parte inferior de la ventana
		hud = new HUD(32, 580, ship.get_energy());		
		scoreText = new FlxText(220, 580, 600, "SCORE: " + Reg.score, 24);

		
		// agrego a la escena
		add(background);
		add(ship);
		add(enemiesGroup1);
		add(enemiesGroup2);
		add(enemyBulletGroup);
		add(bossGroup);
		add(bossBulletGroup);
		add(asteroidGroup);
		add(energyPowerUpGroup);
		add(playerBulletsGroup);
		add(scoreText);
		add(hud);
		
	}

	override public function update(elapsed:Float):Void    
	{       
		super.update(elapsed);    
		
		if (gameOver)
		{
			return;
		}
		
		FlxG.mouse.visible = false; 				// oculto el mouse
		scoreText.text = ("SCORE: " + Reg.score);	// muestro el puntaje en pantalla

		if (boss != null)
		{
			bossHPText.text = ("HP: " + boss.get_health());
			add(bossHPText);
		}


		// infinite scrolling background
		if (background.y >= 0)
		{
			background.y = -480;
		}

		/*
		   -------------------------------------
		 				ENEMY WAVES
		   -------------------------------------
		*/

		time_to_next_wave += elapsed;
		time_to_powerup += elapsed;

		if((time_to_next_wave >= 3) && !wave1_over)
		{
			wave_asteroids();
			wave1_over = true;
			
		}

		if((time_to_next_wave >= 6) && !wave2_over)
		{
			wave_asteroids();
			wave2_over = true;
		}

		if((time_to_next_wave >= 6) && !wave3_over)
		{
			wave_enemy01();
			wave3_over = true;
		}

		if((time_to_next_wave >= 45) && !wave4_over)
		{
			wave_enemy02();
			wave4_over = true;
		}
	
		
		if((time_to_next_wave >= 55) && !wave5_over)
		{
			wave_enemy02();
			wave5_over = true;
		}

		if((time_to_next_wave >= 70) && !waveBoss_over)
		{
			wave_boss();
			waveBoss_over = true;
		}
	
		/*
		   -------------------------------------
		 				POWER UP
		   -------------------------------------
		*/
		

		// creo un nuevo power up despues de transcurrido un tiempo random entre 5 y 10 seg.				
		if(time_to_powerup >= randomtime)
		{
			time_to_powerup = 0;
			randomtime = Std.random(5) + 10;
			new_powerup();
		}

		/*
		   -------------------------------------
		 			COMPROBAR COLISIONES
		   -------------------------------------
		*/
		
		// comprobar colisiones del jugador
		FlxG.overlap(playerCollideables, ship, onPlayerCollision); 

		//colision de los disparos del jugador con los asteroides
		FlxG.overlap(playerBulletsGroup,asteroidGroup,null,overlapped);

		//colision de los disparos del jugador con los enemigos
		FlxG.overlap(playerBulletsGroup,enemiesGroup1,null,overlapped);

		//colision de los disparos del jugador con los enemigos
		FlxG.overlap(playerBulletsGroup,enemiesGroup2,null,overlapped);

		//colision de los disparos del jugador con el jefe final
		FlxG.overlap(playerBulletsGroup,bossGroup,null,overlapped);
	
		

		/*
		   -------------------------------------
		 			PLAYER SHOOTING
		   -------------------------------------
		*/

		// disparo automatico de proyectiles del jugador
		shootTime += elapsed;
		if (ship.get_energy() > 0)
		{
			if(shootTime >= 0.5) 
			{
				newBullet = new Bullet(ship.x+2, ship.y - 48, 300, 5);
				playerBulletsGroup.add(newBullet);
				FlxG.sound.play(Reg.SND_BULLET_FIRE);
				shootTime = 0;
			}
		}
		
		// destruyo las proyectiles del jugador que se van fuera de los limites de la pantalla
		for (pb in playerBulletsGroup)
		{	
			if (pb.isTouching(FlxObject.ANY) || (pb.y < -pb.height))
			{
				playerBulletsGroup.remove(pb);
				pb.kill();
			}
		}


		// destruyo las powerUp que se van fuera de los limites de la pantalla
		for (pa in energyPowerUpGroup)
		{	
			if (pa.y > (FlxG.height + pa.height))
			{
				energyPowerUpGroup.remove(pa);
				pa.kill();
			}
		}



		// destruyo las asteroides que se van fuera de los limites de la pantalla
		for (meteors in asteroidGroup)
		{	
			if (meteors.y > (FlxG.height + asteroid.height))
			{
				asteroidGroup.remove(meteors);
				meteors.kill();
			}
		}

		// destruyo las enemigos que se van fuera de los limites de la pantalla
		for (e1 in enemiesGroup1)
		{	
				
			if (e1.y > (FlxG.height + e1.height))
			{
				enemiesGroup1.remove(e1);
				e1.kill();
			}
		}

		for (e2 in enemiesGroup2)
		{	
				
			if (e2.y > (FlxG.height + e2.height))
			{
				enemiesGroup2.remove(e2);
				e2.kill();
			}
		}

	

		// destruyo las disparos enemigos que se van fuera de los limites de la pantalla
		for (eb in enemyBulletGroup)
		{	
			if (eb.y > (FlxG.height + eb.height))
			{
				enemyBulletGroup.remove(eb);
				eb.kill();
			}
		}

		// destruyo las disparos del jefe final que se van fuera de los limites de la pantalla
		for (bb in bossBulletGroup)
		{	
			if (bb.y > (FlxG.height + bb.height))
			{
				bossBulletGroup.remove(bb);
				bb.kill();
			}
		}
	
		/*
		   -------------------------------------
		 				GAME OVER
		   -------------------------------------
		*/

		// la vida del jugador es igual o menor a cero.

		if ((ship.get_energy() <= 0) && ship.get_playerState())
		{
			
			FlxG.camera.fade(FlxColor.BLACK, 1.3, false, doneFadeOut); // fade out effect
			win = false;
			gameOver = true;
		}
	
	
		/*
		   -------------------------------------
		 				WIN CONDITION
		   -------------------------------------
		*/

		// Derrotamos al jefe final
		if (boss != null)
		{
			if (boss.get_health() <= 0)
			{
				FlxG.camera.fade(FlxColor.BLACK, 1.3, false, doneFadeOut); // fade out effect
				win = true;
				gameOver = true;
			}
		}

	}
	
	function doneFadeOut()
	{
		FlxG.switchState(new GameOverState(win));
	}


	function onPlayerCollision(object: FlxObject, ship:Ship)
	{
		// manejo todas las colisiones del jugador con una unica funcion
		if (ship.get_energy() > 0)
		{
			switch (Type.getClass(object))
			{
				case Asteroids: // colision con los asteroides
				{
					var meteor: Asteroids = cast(object, Asteroids);
				
					FlxG.camera.flash(FlxColor.WHITE,1.5); 						// efecto flash en la pantalla
					FlxG.camera.shake(0.01, 0.2);								// shake screen
					FlxG.sound.play(Reg.SND_EXPLOSION);
				
					var boom = new Explosion(meteor.x,meteor.y,20, 3);			// creo una explosion
					add(boom);
					meteor.kill();
					
					ship.take_hit(3); 											// resto energia
					hud.setEnergy(ship.get_energy());							// actualizamos el HUD
				}

				case Enemy01: // colision con los enemigos
				{
					var tieFighter: Enemy01 = cast(object, Enemy01);
				
					FlxG.camera.flash(FlxColor.WHITE,1.5); 						// efecto flash en la pantalla
					FlxG.camera.shake(0.01, 0.2);								// shake screen
					FlxG.sound.play(Reg.SND_EXPLOSION);

					var boom = new Explosion(tieFighter.x,tieFighter.y,20, 3);	// creo una explosion
					add(boom);
					tieFighter.kill();
				
					ship.take_hit(3); 											// resto energia
					hud.setEnergy(ship.get_energy());							// actualizamos el HUD
				}

				case Enemy02: // colision con los enemigos
				{
					var xFighter: Enemy02 = cast(object, Enemy02);
				
					FlxG.camera.flash(FlxColor.WHITE,1.5); 						// efecto flash en la pantalla
					FlxG.camera.shake(0.01, 0.2);								// shake screen
					FlxG.sound.play(Reg.SND_EXPLOSION);

					var boom = new Explosion(xFighter.x,xFighter.y,20, 3);		// creo una explosion
					add(boom);
					xFighter.kill();
				
					ship.take_hit(3); 											// resto energia
					hud.setEnergy(ship.get_energy());							// actualizamos el HUD
				}

			
				case EnemyBullet: // colision con los disparos enemigos
				{
					var ebullet: EnemyBullet = cast(object, EnemyBullet);
					FlxG.sound.play(Reg.SND_BULLET_HIT);
					ebullet.kill();
					ship.take_hit(1); 											// resto energia
					hud.setEnergy(ship.get_energy());							// actualizamos el HUD				
				}

				case BossBullet: // colision con los disparos del jefe final
				{
					var bbullet: BossBullet = cast(object, BossBullet);
					FlxG.sound.play(Reg.SND_BULLET_HIT);
					bbullet.kill();
					ship.take_hit(bbullet.damage); 								// resto energia
					hud.setEnergy(ship.get_energy());							// actualizamos el HUD				
				}

				case PowerUpEnergy: // colision con los power Ups
				{
					var energyP: PowerUpEnergy = cast(object, PowerUpEnergy);
					Reg.score += 5;												// sumo puntos al score
					energyP.kill();
					FlxG.sound.play(Reg.SND_POWERUP);
					ship.add_energy(2);											// sumo energia
					hud.setEnergy(ship.get_energy());							// actualizamos el HUD
				}
			}
		}

	}
	


	private function overlapped(Sprite1:FlxObject, Sprite2:FlxObject):Bool
	{
		var sprite1ClassName:String = Type.getClassName(Type.getClass(Sprite1));
		var sprite2ClassName:String = Type.getClassName(Type.getClass(Sprite2));
	
		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Asteroids") // colision entre los disparos del jugador y los asteroides
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var meteor: Dynamic = cast(Sprite2,Asteroids);
			
			FlxFlicker.flicker(meteor,0.5,0.04,true); // efecto flickering

			meteor.damage(bullet.damage);
			FlxG.sound.play(Reg.SND_BULLET_HIT);
			if (meteor.isDestroyed())
			{
				asteroidGroup.remove(meteor);
				Sprite2.kill();						// destruyo el asteroide
				FlxG.sound.play(Reg.SND_EXPLOSION);
				Reg.score += 10;					// sumo puntos al score
			
				FlxG.camera.shake(0.01, 0.2);

				//creo una explosion en la posicion del asteroide
				var ex = new Explosion(meteor.x,meteor.y,20, meteor.width/Sprite2.width*2);
				add(ex);
			}
	
			
			playerBulletsGroup.remove(bullet);
			Sprite1.kill();
	
			return true;
		}
		
		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Enemy01") // colision entre los disparos del jugador y los enemnigos
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var enemy1: Dynamic = cast(Sprite2,Enemy01);
				
			FlxFlicker.flicker(enemy1,0.5,0.04,true); // efecto flickering
	
		
			enemy1.damage(bullet.damage);
			FlxG.sound.play(Reg.SND_BULLET_HIT);
		
			if (enemy1.isDestroyed())
			{
				enemiesGroup1.remove(enemy1);
				FlxG.sound.play(Reg.SND_EXPLOSION);
				Sprite2.kill();
				Reg.score += 50;
			
				FlxG.camera.shake(0.01, 0.2);
		
				//creo una explosion
				var ex = new Explosion(enemy1.x,enemy1.y,20, enemy1.width/Sprite2.width*2);
				add(ex);
			}
		
			playerBulletsGroup.remove(bullet);
			Sprite1.kill();
		
			return true;
		}

		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Enemy02") // colision entre los disparos del jugador y los enemnigos
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var enemy2: Dynamic = cast(Sprite2,Enemy02);
					
			FlxFlicker.flicker(enemy2,0.5,0.04,true); // efecto flickering
				
			enemy2.damage(bullet.damage);
			FlxG.sound.play(Reg.SND_BULLET_HIT);
		
			if (enemy2.isDestroyed())
			{
				enemiesGroup2.remove(enemy2);
				FlxG.sound.play(Reg.SND_EXPLOSION);
				Sprite2.kill();
				Reg.score += 40;
			
				FlxG.camera.shake(0.01, 0.2);
			
				//creo una explosion 
				var ex = new Explosion(enemy2.x,enemy2.y,20, enemy2.width/Sprite2.width*2);
				add(ex);
			}
			
			playerBulletsGroup.remove(bullet);
			Sprite1.kill();
			
			return true;
		}

		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Boss") // colision entre los disparos del jugador y el jefe final
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var bossy: Dynamic = cast(Sprite2,Boss);
					
			FlxFlicker.flicker(bossy,0.3,0.02,true); // efecto flickering
		
			bossy.damage(bullet.damage);
			FlxG.sound.play(Reg.SND_BULLET_HIT);
			if (bossy.isDestroyed())
			{
				bossGroup.remove(bossy);
				FlxG.sound.play(Reg.SND_EXPLOSION);
				Sprite2.kill();
				Reg.score += 200;
			
				FlxG.camera.shake(0.01, 0.2);
			
				//creo una explosion 
				var ex = new Explosion(bossy.x,bossy.y,20, bossy.width/Sprite2.width*2);
				add(ex);
				FlxG.camera.flash(FlxColor.WHITE,1.5); 										// efecto flash en la pantalla
				FlxG.camera.shake(0.01, 0.2);												// shake screen
			}			
		
			playerBulletsGroup.remove(bullet);
			Sprite1.kill();
			
			return true;
		}
	

		return false;
	}



	private function wave_asteroids()
	{		
		for (i in 0...15) 
		{
			var randomPosY = Std.random(300)-600;
			var randomPosX = Std.random(FlxG.width);
			var randomVelY = Std.random(90)+65;
			var randomVelX = Std.random(60)-35;
			var randomRot = Std.random(2)+0.25;
			asteroid = new Asteroids(randomPosX, randomPosY, randomVelX, randomVelY, randomRot,10);
			asteroidGroup.add(asteroid);
		}
	}
	
	private function wave_enemy01()
	{		
		for (i in 0...10) 
		{
			var randomY = Std.random(300)-600;
			var randomX = Std.random(FlxG.width);
			
			enemy01 = new Enemy01(randomX, randomY,20, enemyBulletGroup);
			enemiesGroup1.add(enemy01);
			enemy01.active = true;
		}			
	}

	private function wave_enemy02()
	{		
		for (i in 0...5) 
		{
			var randomY = Std.random(400)-800;
			var randomX = Std.random(FlxG.width);
				
			enemy02 = new Enemy02(randomX, randomY,5, enemyBulletGroup);
			enemiesGroup2.add(enemy02);
			enemy02.active = true;
		}	
		
		for (i in 0...3) 
		{
			var randomY = Std.random(10)-900;
			var randomX = Std.random(FlxG.width);
					
			enemy02 = new Enemy02(randomX, randomY,5, enemyBulletGroup);
			enemiesGroup2.add(enemy02);
			enemy02.active = true;
		}	
	}

	private function wave_boss()
	{				
		boss = new Boss(FlxG.width/2, -100,bossBulletGroup);
		bossGroup.add(boss);
		boss.active = true;	
		bossHPText = new FlxText(50, 50, 600, "HP: " + boss.get_health(), 12);
		add(bossHPText);
	}
		
	
	function new_powerup()
	{
		// aparece un power up solo si el grupo esta vacio
		if (energyPowerUpGroup.countLiving() < 1)
		{
			energyPowerUpGroup.add(new PowerUpEnergy(Std.random(FlxG.width - 40) + 20 ,-10));
		}
	}	
}
