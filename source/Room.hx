package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Room extends FlxSprite
{
	public var type:RoomType;

	public function new(x = 0, y = 0, size = 14, type:RoomType)
	{
		super(x, y);
		this.type = type;

		switch (type)
		{
			case Start:
				var g = loadGraphic(AssetPaths.RoomStart__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case Treasure:
				var g = loadGraphic(AssetPaths.RoomTreasure__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case Fight:
				var g = loadGraphic(AssetPaths.RoomFight__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case Boss:
				var g = loadGraphic(AssetPaths.RoomBoss__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case Merchant:
				var g = loadGraphic(AssetPaths.RoomMerchant__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case Storage:
				var g = loadGraphic(AssetPaths.RoomStorage__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case LvlUp:
				var g = loadGraphic(AssetPaths.RoomLvlUp__png, false);
				g.origin.set(0, 0);
				g.setGraphicSize(size, size);
			case Empty:
				makeGraphic(size, size, FlxColor.BLACK);
		}
	}
}

enum RoomType
{
	Start; // 1
	Treasure; // 30%
	Fight; // 40%
	Boss; // 4
	Merchant; // 10%
	Storage; // 3%
	LvlUp; // 6%
	Empty; // 10%
}
