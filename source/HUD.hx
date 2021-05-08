package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;


class HUD extends FlxSprite
{

    var energyBar:         FlxSprite;

    public function new(X: Float, Y: Float, energy: Int) 
    {
        super(X, Y);
        setEnergy(energy);    
    }

    public function setEnergy(energy)
    {
        // recibe un entero con la cantidad de energia de la nave
        loadGraphic("assets/images/lifeMeter.png", true, 158, 40);
        animation.add("10", [0], 1, false);
        animation.add("9", [1], 1, false);
        animation.add("8", [2], 1, false);
        animation.add("7", [3], 1, false);
        animation.add("6", [4], 1, false);
        animation.add("5", [5], 1, false);
        animation.add("4", [6], 1, false);
        animation.add("3", [7], 1, false);
        animation.add("2", [8], 1, false);
        animation.add("1", [9], 1, false);
        animation.add("0", [10], 1, false);
          
        // se muestra la animacion correspondiente en funcion de la energia restante
        if (energy >= 0)
        {
            animation.play(Std.string(energy)); 
        }
        else
        {
            animation.play("0");
        }
    
    }
 
}