package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.effects.FlxFlicker;
import flixel.util.FlxSave;
import Reg;

class GameOverState extends FlxState
{

    var win:                Bool;       // bandera para saber si ganamos o no
    var isPressed:			Bool;
    var text:				FlxText;
    var text2:				FlxText;
    var text3:				FlxText;
    var highscoreText:      FlxText;    // para mostrar el maximo puntaje

    public function new(win:Bool)       // traemos el parametro "win" desde el PlayState
    {
        super();
        this.win = win;     
    }


	override public function create():Void
	{
        super.create();
        
        FlxG.sound.music.stop();
     
        // se muestra el mensaje correspondiente de acuerdo a si ganamos o no
        var text = new FlxText(0, FlxG.height/3, FlxG.width);
        text.size = 48;
        text.alignment = "center";
        if (win)
        {
            text.text = "VICTORY !";
            FlxG.sound.play(Reg.SND_VICTORY);
        }
        else
        {
            text.text = "GAME OVER";
            FlxG.sound.play(Reg.SND_GAMEOVER);
        }
        add(text);


        text2 = new FlxText(0, FlxG.height/2 + 64, FlxG.width);
        text2.size = 32;        
        text2.alignment = "center";                 
        text2.text = "SCORE: " + Reg.score;     
        add(text2);

        // para ver cual fue el mejor puntaje
		var highscore = checkHighscore(Reg.score);

        highscoreText = new FlxText(0, 450, FlxG.width);
	    highscoreText.size = 32;   
        highscoreText.alignment = "center";
        highscoreText.text = "HIGH SCORE: " + highscore;     
		add(highscoreText);



        text3 = new FlxText(150,550,400,"Press X to play again",16,false);
        add(text3);

        FlxFlicker.flicker(text3, 0, 0.5, false, false, null, null);
    
    }

    override public function update(elapsed):Void
    {
        super.update(elapsed);
    
        if (FlxG.keys.justPressed.X && !isPressed)
        {
            isPressed = true;
            FlxFlicker.stopFlickering(text3);
            FlxG.sound.music.stop();
            FlxG.switchState(new PlayState());
        }
    }	

    function checkHighscore(score:Int):Int
    {
        Reg.highscore = score;
        var save = new FlxSave();

        if (save.bind("HighScore"))
        {
            if (save.data.highscore != null && save.data.highscore > Reg.highscore)
            {
                Reg.highscore = save.data.highscore;
            }
            else
            {
                // se guarda el High Score
                 save.data.highscore = Reg.highscore;
            }
        }
        save.close();
        return Reg.highscore;
    }
      
}