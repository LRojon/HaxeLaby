package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Wall extends FlxSprite
{
	public var type:Int;

	public function new(x = 0, y = 0, size = 16, type:Int = 0)
	{
		this.type = type;
		super(x, y);
		switch (type)
		{
			case 0:
				makeGraphic(size, size, FlxColor.WHITE);
			case 1:
				var g = loadGraphic(AssetPaths.Room1__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 2:
				var g = loadGraphic(AssetPaths.Room2__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 3:
				var g = loadGraphic(AssetPaths.Room3__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 4:
				var g = loadGraphic(AssetPaths.Room4__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 5:
				var g = loadGraphic(AssetPaths.Room5__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 6:
				var g = loadGraphic(AssetPaths.Room6__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 7:
				var g = loadGraphic(AssetPaths.Room7__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 8:
				var g = loadGraphic(AssetPaths.Room8__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 9:
				var g = loadGraphic(AssetPaths.Room9__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 10:
				var g = loadGraphic(AssetPaths.Room10__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 11:
				var g = loadGraphic(AssetPaths.Room11__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 12:
				var g = loadGraphic(AssetPaths.Room12__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 13:
				var g = loadGraphic(AssetPaths.Room13__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 14:
				var g = loadGraphic(AssetPaths.Room14__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case 15:
				var g = loadGraphic(AssetPaths.Room15__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
		}
	}
}
