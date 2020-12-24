package;

import Room.RoomType;
import Room;
import Wall;
import flixel.FlxSprite;
import openfl.display.Tileset;

class LabyOpti
{
	public var width:Int;
	public var height:Int;
	public var tile:Int;
	public var walls:Array<Array<Wall>>;
	public var rooms:Array<Array<Room>>;

	private var array:Array<Array<Int>>;

	public var path:Array<Point>;

	private var roomSize:Int;
	private var essentialRoom:Array<RoomType>;

	public function getArray()
	{
		return this.array;
	}

	public function new(width = 16, height = 9, tile = 80)
	{
		this.width = Math.floor(width / tile);
		this.height = Math.floor(height / tile);
		this.tile = tile;
		this.roomSize = Math.floor(this.tile / 10) * 8;
		this.path = new Array();
		this.array = new Array();
		this.walls = new Array();
		this.rooms = new Array();
		this.essentialRoom = new Array();
		for (i in 0...this.width)
		{
			this.array[i] = new Array();
			this.walls[i] = new Array();
			this.rooms[i] = new Array();
		}
	}

	public function Generate()
	{
		for (x in 0...this.width)
		{
			for (y in 0...this.height)
			{
				this.array[x][y] = 0;
				this.rooms[x][y] = new Room(0, 0, 0, RoomType.Empty);
			}
		}

		this.setRooms();

		for (x in 0...this.width)
		{
			for (y in 0...this.height)
			{
				this.walls[x][y] = new Wall(x * this.tile, y * this.tile, this.tile, this.array[x][y]);
			}
		}
	}

	private function gen(x:Int, y:Int, dir:Direction):Array<Int>
	{
		var tab = [1, 1, 1, 1];
		var tabXY = [[0, 0], [0, 0], [0, 0], [0, 0]];
		var ret = [1, x, y];
		switch (dir)
		{
			case UP:
				this.array[x][y] += 4;
			case DOWN:
				this.array[x][y] += 1;
			case LEFT:
				this.array[x][y] += 2;
			case RIGHT:
				this.array[x][y] += 8;
		}
		var direction = this.randDirection();
		for (d in direction)
		{
			switch (d)
			{
				case UP:
					if (y - 1 >= 0 && this.array[x][y - 1] == 0)
					{
						this.array[x][y] += 1;
						var t = this.gen(x, y - 1, d);
						tab[0] += t[0];
						tabXY[0] = [t[1], t[2]];
					}
				case DOWN:
					if (y + 1 < this.height && this.array[x][y + 1] == 0)
					{
						this.array[x][y] += 4;
						var t = this.gen(x, y + 1, d);
						tab[1] += t[0];
						tabXY[1] = [t[1], t[2]];
					}
				case LEFT:
					if (x - 1 >= 0 && this.array[x - 1][y] == 0)
					{
						this.array[x][y] += 8;
						var t = this.gen(x - 1, y, d);
						tab[2] += t[0];
						tabXY[2] = [t[1], t[2]];
					}
				case RIGHT:
					if (x + 1 < this.width && this.array[x + 1][y] == 0)
					{
						this.array[x][y] += 2;
						var t = this.gen(x + 1, y, d);
						tab[3] += t[0];
						tabXY[3] = [t[1], t[2]];
					}
			}
		}
		var index = this.findMax(tab);
		if (!this.checkOne(tab))
			ret = [tab[index], tabXY[index][0], tabXY[index][1]];
		return ret;
	}

	private function setRooms()
	{
		var y = Math.floor(Math.random() * 1000) % this.height;
		var start = gen(0, y, Direction.RIGHT);

		this.rooms[start[1]][start[2]] = new Room(start[1] * this.tile + Math.floor(this.tile / 10), start[2] * this.tile + Math.floor(this.tile / 10),
			this.roomSize, RoomType.Start);
		this.findPath(0, y, Direction.RIGHT);
		this.path.push(new Point(0, y));
		for (i in 0...this.path.length)
		{
			this.rooms[this.path[i].x][this.path[i].y] = new Room(this.path[i].x * this.tile + Math.floor(this.tile / 10),
				this.path[i].y * this.tile + Math.floor(this.tile / 10), this.roomSize, RoomType.Empty);
		}
		this.rooms[start[1]][start[2]] = new Room(start[1] * this.tile + Math.floor(this.tile / 10), start[2] * this.tile + Math.floor(this.tile / 10),
			this.roomSize, RoomType.Start);

		var p:Point = this.path[Math.floor(this.path.length / 4)];
		this.rooms[p.x][p.y] = new Room(p.x * this.tile + Math.floor(this.tile / 10), p.y * this.tile + Math.floor(this.tile / 10), this.roomSize,
			RoomType.Boss);
		p = this.path[Math.floor(this.path.length / 4) * 2];
		this.rooms[p.x][p.y] = new Room(p.x * this.tile + Math.floor(this.tile / 10), p.y * this.tile + Math.floor(this.tile / 10), this.roomSize,
			RoomType.Boss);
		p = this.path[Math.floor(this.path.length / 4) * 3];
		this.rooms[p.x][p.y] = new Room(p.x * this.tile + Math.floor(this.tile / 10), p.y * this.tile + Math.floor(this.tile / 10), this.roomSize,
			RoomType.Boss);
		p = this.path[this.path.length - 1];
		this.rooms[p.x][p.y] = new Room(p.x * this.tile + Math.floor(this.tile / 10), p.y * this.tile + Math.floor(this.tile / 10), this.roomSize,
			RoomType.Boss);
		var nbRoom = this.width * this.height;

		for (i in 0...Math.floor(nbRoom * 0.25))
			this.essentialRoom.push(RoomType.Treasure);
		for (i in 0...Math.floor(nbRoom * 0.45))
			this.essentialRoom.push(RoomType.Fight);
		for (i in 0...Math.floor(nbRoom * 0.1))
			this.essentialRoom.push(RoomType.Merchant);
		for (i in 0...Math.floor(nbRoom * 0.03))
			this.essentialRoom.push(RoomType.Storage);
		for (i in 0...Math.floor(nbRoom * 0.06))
			this.essentialRoom.push(RoomType.LvlUp);
		for (i in 0...Math.floor(nbRoom * 0.1))
			this.essentialRoom.push(RoomType.Empty);
		if (nbRoom - Math.floor(nbRoom * 0.99) > 0)
			for (i in 0...(nbRoom - Math.floor(nbRoom * 0.99)))
				this.essentialRoom.push(RoomType.Empty);

		this.essentialRoom = this.randRoomTab(this.essentialRoom);
		for (i in 0...this.essentialRoom.length)
			FlxG.log.advanced(this.essentialRoom[i]);
		for (x in 0...this.width)
		{
			for (y in 0...this.height)
			{
				if (!(this.rooms[x][y] == null || this.rooms[x][y].type == RoomType.Start || this.rooms[x][y].type == RoomType.Boss))
				{
					this.rooms[x][y] = new Room(x * this.tile + Math.floor(this.tile / 10), y * this.tile + Math.floor(this.tile / 10), this.roomSize,
						this.essentialRoom[0]);
					this.essentialRoom.shift();
				}
			}
		}
	}

	private function findPath(x:Int, y:Int, direction:Direction):Bool
	{
		var opens = this.int2Bin(this.array[x][y]); // 1 2 4 8
		var ret = false;
		if (opens[0] == 1 && direction != Direction.DOWN)
		{
			if (findPath(x, y - 1, Direction.UP))
			{
				this.path.push(new Point(x, y - 1));
				ret = true;
			}
		}
		if (opens[1] == 1 && direction != Direction.LEFT)
		{
			if (findPath(x + 1, y, Direction.RIGHT))
			{
				this.path.push(new Point(x + 1, y));
				ret = true;
			}
		}
		if (opens[2] == 1 && direction != Direction.UP)
		{
			if (findPath(x, y + 1, Direction.DOWN))
			{
				this.path.push(new Point(x, y + 1));
				ret = true;
			}
		}
		if (opens[3] == 1 && direction != Direction.RIGHT)
		{
			if (findPath(x - 1, y, Direction.LEFT))
			{
				this.path.push(new Point(x - 1, y));
				ret = true;
			}
		}
		if (this.rooms[x][y] != null && this.rooms[x][y].type == RoomType.Start)
			ret = true;

		return ret;
	}

	private function randDirection():Array<Direction>
	{
		var dir:Array<Direction> = [UP, DOWN, LEFT, RIGHT];
		for (i in 0...4)
		{
			var r:Int = Math.floor(Math.random() * 1000) % 4;
			var tmp:Direction = dir[r];
			dir[r] = dir[i];
			dir[i] = tmp;
		}
		return dir;
	}

	private function findPGCD(a:Int, b:Int):Int
	{
		while (a * b != 0)
		{
			if (a > b)
				a = a - b;
			else
				b = b - a;
		}
		if (a == 0)
			return b;
		else
			return a;
	}

	private function findMax(tab:Array<Int>):Int
	{
		var index = 0;
		var max = tab[0];
		for (i in 0...tab.length)
		{
			if (max < tab[i])
			{
				max = tab[i];
				index = i;
			}
		}
		return index;
	}

	private function checkOne(tab:Array<Int>):Bool
	{
		for (i in 0...tab.length)
		{
			if (tab[i] != 1)
				return false;
		}
		return true;
	}

	private function int2Bin(num:Int):Array<Int>
	{
		var a:Array<Int> = new Array();
		var i = 0;
		while (num > 0)
		{
			a[i] = num % 2;
			num = Math.floor(num / 2);
			i++;
		}

		if (a.length <= 1)
			a[1] = 0;
		if (a.length <= 2)
			a[2] = 0;
		if (a.length <= 3)
			a[3] = 0;

		return a;
	}

	private function randRoomTab(tab:Array<RoomType>):Array<RoomType>
	{
		for (i in 0...tab.length)
		{
			var r = Math.floor(Math.random() * 1000) % tab.length;
			var tmp = tab[i];
			tab[i] = tab[r];
			tab[r] = tmp;
		}
		return tab;
	}
}

enum Direction
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}

class Point
{
	public var x:Int;
	public var y:Int;

	public function new(x:Int, y:Int)
	{
		this.x = x;
		this.y = y;
	}
}

class Room
{
	public var x:Int;
	public var y:Int;
	public var walls:Int;
	public var width:Int;
	public var height:Int;
	public var type:RoomType;

	public function new(x:Int, y:Int, walls:Int, type:RoomType)
	{
		this.x = x;
		this.y = y;
		this.width = 12;
		this.height = 9; // sprite size : 80
		this.walls = walls;
		this.type = type;
	}
}
