/*
	
--------------------------------
-	TP FINAL PROGRAMACION II   -
-		ROBERTO BACA	       -
-							   -
-  MOBIUS SPACE FORCE V1.0     -
--------------------------------


La cinta de Möbius o Moebius es una superficie con una sola cara y un solo borde.
Esto significa que si se colorea la superficie de una cinta de Möbius, comenzando por 
la «aparentemente» cara exterior, al final queda coloreada toda la cinta, por tanto, 
solo tiene una cara y no tiene sentido hablar de cara interior y cara exterior.

La nave que piloteas tiene la propiedad de doblar el espacio como una cinta
de Moebius !



----------------------------
	       CREDITS	
----------------------------

***** CODE *****

Rober Baca
https://rober-baca.itch.io/



***** MUSIC *****

"Stereotypical 90's space shooter music" album by Jan125
https://opengameart.org/content/stereotypical-90s-space-shooter-music

"Arcade" by Trevor Lentz
https://open.spotify.com/artist/3AjWA7sRmeZSKqr7PoKL6k?si=OP9fcEGdTZG_GMWj44h_Jw



***** SOUNDS *****

"2A03 Victory fanfare" by celestialghost8
https://opengameart.org/content/victory



***** ART *****

Superpowers asset pack
http://superpowers-html5.com/

GrafxKid
https://grafxkid.tumblr.com/



***** ADITIONAL ART *****

Rober Baca



***** TESTER *****

FlorCha



THANKS FOR PLAYING !!!
GRACIAS POR JUGAR !!!

*/




package;

import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.util.FlxSave;
import Reg;

class Main extends Sprite
{

	var skipSplash:Bool = true; 		// saltar el logo de flixel
	var startFullscreen:Bool = true; 	// fullscreen mode

	
	public function new()
	{
		super();
		addChild(new FlxGame(480, 640, MenuState));
	}
}
