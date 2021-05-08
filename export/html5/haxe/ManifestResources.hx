package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR0y36:assets%2Fimages%2FbackgroundLoop.pngR2i38464R3y5:IMAGER5R7R6tgoR0y26:assets%2Fimages%2FBoss.pngR2i11387R3R8R5R9R6tgoR0y31:assets%2Fimages%2FbossShots.pngR2i6481R3R8R5R10R6tgoR0y29:assets%2Fimages%2Fenemy01.pngR2i278R3R8R5R11R6tgoR0y29:assets%2Fimages%2Fenemy02.pngR2i1700R3R8R5R12R6tgoR0y33:assets%2Fimages%2FenemyBullet.pngR2i157R3R8R5R13R6tgoR0y32:assets%2Fimages%2Fexplosions.pngR2i767R3R8R5R14R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R15R6tgoR0y31:assets%2Fimages%2FlifeMeter.pngR2i16004R3R8R5R16R6tgoR0y30:assets%2Fimages%2Fmeteor-1.pngR2i3678R3R8R5R17R6tgoR0y30:assets%2Fimages%2Fmeteor-2.pngR2i3150R3R8R5R18R6tgoR0y28:assets%2Fimages%2Fplayer.pngR2i8976R3R8R5R19R6tgoR0y35:assets%2Fimages%2FplayerBullets.pngR2i4971R3R8R5R20R6tgoR0y32:assets%2Fimages%2Fpower-up-4.pngR2i3156R3R8R5R21R6tgoR0y32:assets%2Fimages%2Ftitle-font.pngR2i6350R3R8R5R22R6tgoR0y33:assets%2Fimages%2FtitleScreen.pngR2i9748R3R8R5R23R6tgoR2i8229523R3y5:MUSICR5y27:assets%2Fmusic%2FArcade.oggy9:pathGroupaR25hR6tgoR2i381031R3y5:SOUNDR5y26:assets%2Fmusic%2Flevel.oggR26aR28hR6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R29R6tgoR2i103634R3R27R5y26:assets%2Fmusic%2Fstart.oggR26aR30hR6tgoR2i111992R3R27R5y32:assets%2Fsounds%2Fdark-shoot.wavR26aR31hR6tgoR2i33089R3R27R5y31:assets%2Fsounds%2Fexplosion.oggR26aR32hR6tgoR2i861354R3R27R5y38:assets%2Fsounds%2Ffallen_in_battle.wavR26aR33hR6tgoR2i13079R3R27R5y25:assets%2Fsounds%2Fhit.oggR26aR34hR6tgoR2i8665R3R27R5y34:assets%2Fsounds%2Fplayer_shoot.oggR26aR35hR6tgoR2i110740R3R27R5y30:assets%2Fsounds%2Fpower-up.wavR26aR36hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R37R6tgoR2i430460R3R27R5y29:assets%2Fsounds%2FVictory.wavR26aR38hR6tgoR2i2114R3R24R5y26:flixel%2Fsounds%2Fbeep.mp3R26aR39y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R24R5y28:flixel%2Fsounds%2Fflixel.mp3R26aR41y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R27R5R40R26aR39R40hgoR2i33629R3R27R5R42R26aR41R42hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R43R44y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R8R5R49R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R8R5R50R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_backgroundloop_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boss_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_bossshots_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_enemy01_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_enemy02_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_enemybullet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_explosions_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_lifemeter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_meteor_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_meteor_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_playerbullets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_power_up_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_title_font_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_titlescreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_arcade_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_level_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_start_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_dark_shoot_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_explosion_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_fallen_in_battle_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hit_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_player_shoot_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_power_up_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_victory_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/backgroundLoop.png") @:noCompletion #if display private #end class __ASSET__assets_images_backgroundloop_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Boss.png") @:noCompletion #if display private #end class __ASSET__assets_images_boss_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bossShots.png") @:noCompletion #if display private #end class __ASSET__assets_images_bossshots_png extends lime.graphics.Image {}
@:keep @:image("assets/images/enemy01.png") @:noCompletion #if display private #end class __ASSET__assets_images_enemy01_png extends lime.graphics.Image {}
@:keep @:image("assets/images/enemy02.png") @:noCompletion #if display private #end class __ASSET__assets_images_enemy02_png extends lime.graphics.Image {}
@:keep @:image("assets/images/enemyBullet.png") @:noCompletion #if display private #end class __ASSET__assets_images_enemybullet_png extends lime.graphics.Image {}
@:keep @:image("assets/images/explosions.png") @:noCompletion #if display private #end class __ASSET__assets_images_explosions_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/lifeMeter.png") @:noCompletion #if display private #end class __ASSET__assets_images_lifemeter_png extends lime.graphics.Image {}
@:keep @:image("assets/images/meteor-1.png") @:noCompletion #if display private #end class __ASSET__assets_images_meteor_1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/meteor-2.png") @:noCompletion #if display private #end class __ASSET__assets_images_meteor_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/player.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_png extends lime.graphics.Image {}
@:keep @:image("assets/images/playerBullets.png") @:noCompletion #if display private #end class __ASSET__assets_images_playerbullets_png extends lime.graphics.Image {}
@:keep @:image("assets/images/power-up-4.png") @:noCompletion #if display private #end class __ASSET__assets_images_power_up_4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/title-font.png") @:noCompletion #if display private #end class __ASSET__assets_images_title_font_png extends lime.graphics.Image {}
@:keep @:image("assets/images/titleScreen.png") @:noCompletion #if display private #end class __ASSET__assets_images_titlescreen_png extends lime.graphics.Image {}
@:keep @:file("assets/music/Arcade.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_arcade_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/level.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_level_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/start.ogg") @:noCompletion #if display private #end class __ASSET__assets_music_start_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/dark-shoot.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_dark_shoot_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/explosion.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_explosion_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/fallen_in_battle.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_fallen_in_battle_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hit.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_hit_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/player_shoot.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_player_shoot_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/power-up.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_power_up_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/Victory.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_victory_wav extends haxe.io.Bytes {}
@:keep @:file("G:/Haxe/haxe/lib/flixel/4,8,1/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("G:/Haxe/haxe/lib/flixel/4,8,1/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("G:/Haxe/haxe/lib/flixel/4,8,1/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("G:/Haxe/haxe/lib/flixel/4,8,1/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("G:/Haxe/haxe/lib/flixel/4,8,1/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("G:/Haxe/haxe/lib/flixel/4,8,1/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
