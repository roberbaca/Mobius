package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;
import Reg;


class MenuState extends FlxState
{

	private var text:				FlxText;
	private var isPressed:			Bool;

	override public function create():Void
	{
		super.create();

		isPressed = false;

		FlxG.sound.playMusic(Reg.MUSIC_INTRO,1,true);	// musica (looping)

		// pantalla inicial
		var title = new FlxSprite(120,160);
		title.loadGraphic(Reg.TITLE_LOGO,false,480,640);
		title.scale.set(2,2);
		add(title);
		
		text = new FlxText(70,450,400,"Press X to play!",32,false);
		add(text);

		var auth = new FlxText(150,600,300,"Rober Baca - 2020",14,false);
		add(auth);

		FlxFlicker.flicker(text, 0, 0.5, false, false, null, null);
	}
	

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update(elapsed):Void
	{
		super.update(elapsed);
        if (FlxG.keys.justPressed.X && !isPressed)
        {
			isPressed = true;
			FlxFlicker.stopFlickering(text);
			FlxG.sound.music.stop();
			FlxG.sound.pause();
			FlxG.sound.play(Reg.MUSIC_START,1,false,false,musicFinishedPlaying);
		}
	}	

	private function musicFinishedPlaying():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);
		FlxG.switchState(new PlayState());
	}
}