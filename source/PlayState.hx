package;

import Laby;
import Wall;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSignal.FlxTypedSignal;
import haxe.Timer;
import openfl.Lib;
import openfl.system.System;

class PlayState extends FlxState
{
	private var i:Int = 0;
	private var l:Laby;
	private var timerCounter:Float = 0;

	override public function create()
	{
		FlxG.debugger.visible = true;
		FlxG.fullscreen = false;

		l = new Laby(1280, 720);
		l.Generate();

		for (x in 0...l.walls.length)
		{
			for (y in 0...l.walls[x].length)
			{
				add(l.walls[x][y]);
				if (l.rooms[x][y] != null)
					add(l.rooms[x][y]);
			}
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		timerCounter += elapsed;

		if (FlxG.keys.justPressed.ESCAPE)
			System.exit(0);

		if (FlxG.keys.justPressed.ENTER)
			FlxG.fullscreen = !FlxG.fullscreen;
		if (FlxG.keys.pressed.SHIFT)
			FlxG.resetGame();
	}

	private function round(number:Float, ?precision = 2):Float
	{
		number *= Math.pow(10, precision);
		return Math.round(number) / Math.pow(10, precision);
	}
}
// Ctrl+Shift+B to execute
