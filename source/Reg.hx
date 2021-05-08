package;
import flixel.util.FlxSave;

class Reg
{
   public static var score:         Int = 0;
   public static var highscore:     Int = 0;
  

   // Sprites
   public static inline var TITLE_LOGO = "assets/images/titleScreen.png";

   // Sounds
	public static inline var SND_EXPLOSION:String = "assets/sounds/explosion.ogg";	
	public static inline var SND_BULLET_HIT:String = "assets/sounds/hit.ogg";
   public static inline var SND_BULLET_FIRE:String = "assets/sounds/player_shoot.ogg";
   public static inline var SND_BOSS_FIRE:String = "assets/sounds/dark-shoot.wav";
   public static inline var SND_POWERUP:String = "assets/sounds/power-up.wav";
   public static inline var SND_GAMEOVER:String = "assets/sounds/fallen_in_battle.wav";
   public static inline var SND_VICTORY:String = "assets/sounds/Victory.wav";
   
   // Music
   public static inline var MUSIC_LEVEL:String = "assets/music/level.ogg";
   public static inline var MUSIC_START:String = "assets/music/start.ogg";
   public static inline var MUSIC_INTRO:String = "assets/music/Arcade.ogg";
 
}