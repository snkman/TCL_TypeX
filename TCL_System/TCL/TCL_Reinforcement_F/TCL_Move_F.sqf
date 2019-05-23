TCL_Move_F = [

	// ////////////////////////////////////////////////////////////////////////////
	// Move Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// Move
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_logic","_array","_spot","_waypoint"];
	
	private _leader = (leader _group);
	
	private _position = (_group getVariable "TCL_Position");
	
	if ( [_enemy, _group, _logic] call (TCL_Move_F select 1) ) then
	{
		_position = [_enemy, _group, _logic, _array] call (TCL_Move_F select 2);
	};
	
	// player sideChat format ["TCL_Move_F > Group > %1 > %2", _group, _position];
	
	if ( (_leader distance _position > 10) || (_leader distance _waypoint > 10) ) then
	{
		_group move _position;
		
		private _units = (units _group);
		
		if (_units findIf { (currentCommand _x isEqualTo "GET IN") } > -1) then
		{
			// player sideChat format ["TCL_Move_F > GET IN > %1", _group];
			
			{if (_x in assignedVehicle _x) then {_units = _units - [_x] } } count _units;
		};
		
		private _array = ( (TCL_Take_Cover select 0) + (TCL_Helicopter select 0) + (TCL_House_Search select 0) + (TCL_Static_Weapon select 0) );
		
		_units = _units - _array;
		
		// _units doMove _position;
		
		// _units doMove (getPos _leader);
		
		// _leader doMove _position;
		
		// _units doFollow _leader;
		
		if (alive _spot) then
		{
			_spot setPos _position;
		};
		
		// _group move _position;
	};
	
	_group setVariable ["TCL_Waypoint", _position];
	
	["TCL_Position", _group, _position] call (TCL_Marker_F select 0);
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Move Function #1
	// ////////////////////////////////////////////////////////////////////////////
	// Move
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_logic"];
	
	private _return = False;
	
	if (_group in (TCL_Hold select 0) ) then
	{
		if ( [_group, _logic] call TCL_Trigger_F ) then
		{
			_return = True;
		};
	}
	else
	{
		if (_group in (TCL_Waiting select 0) ) then
		{
			if ( [_enemy, _group, _logic] call (TCL_Waiting_F select 0) ) then
			{
				_return = True;
				
				TCL_Waiting set [0, (TCL_Waiting select 0) - [_group] ];
			};
		}
		else
		{
			_return = True;
		};
	};
	
	_return
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Move Function #2
	// ////////////////////////////////////////////////////////////////////////////
	// Move
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_logic","_array"];
	
	private "_position";
	
	private _knowsAbout = 0;
	
	if (alive _enemy) then
	{
		_knowsAbout = (_group knowsAbout vehicle _enemy);
	};
	
	private _value = 100;
	
	private _random = 1 + (random 1);
	
	// _value = (_value * _random);
	
	private _distance = 0;
	
	private _object = _logic;
	
	// private _distance = _value;
	
	private _leader = (leader _group);
	
	private _direction = (random 360);
	
	if (_knowsAbout > 0) then
	{
		if (_knowsAbout < 1) then
		{
			_knowsAbout = 1;
		};
		
		if (count _array > 0) then
		{
			private _tweak = (TCL_Tweak select 1);
			
			// _range = 300;
			
			// private _range = (random _tweak);
			
			private _random = (random _tweak);
			
			private _range = (_tweak - _random);
			
			// player sideChat format ["TCL_Move_F > Range > %1 > %2 > %3", _group, _range, _random];
			
			private _bool = False;
			
			private _units = (units _group);
			
			if (_array isEqualTo _units) then
			{
				if (_leader distance _enemy < _tweak) then
				{
					_bool = True;
				};
			};
			
			// _bool = False;
			
			// player sideChat format ["TCL_Move_F > Knowledge > %1 > %2 > %3", _group, (count _units), (count _array) ];
			
			if ( (_bool) || (_leader distance _enemy < _range) ) then
			{
				private _tweak = (TCL_Tweak select 2);
				
				private _random = [_enemy, _group, _array, _range, _tweak] call (TCL_Move_F select 3);
				
				// if (floor (random 100) < 0) then
				
				if (floor (random 100) < _random) then
				{
					_distance = (_leader distance _enemy);
					
					private _value = 1 + (random _tweak);
					
					_distance = (_distance / _value);
					
					// _distance = 0;
					
					// player sideChat format ["TCL_Move_F > Move > %1 > %2 > %3 > %4 > %5 > %6%7", _group, round (_leader distance _enemy), (behaviour _leader), (combatMode _group ), (round _range), (round _random), "%"];
				}
				else
				{
					_distance = 0;
					
					_object = _leader;
					
					// player sideChat format ["TCL_Move_F > Stop > %1 > %2 > %3 > %4 > %5 > %6 > %7%8", _group, round (_leader distance _enemy), (behaviour _leader ), (combatMode _group), (count _array), (round _range), (round _random), "%"];
				};
			};
			
			// player sideChat format ["TCL_Move_F > Visible > %1 > %2 > %3 > %4 > %5", _group, _range, round (_leader distance _enemy), (combatMode _group), (behaviour _leader ) ];
			
			_direction = (_enemy getDir _leader);
			
			private _random = (random 10 - random 10);
			
			if (floor (random 100) < 50) then
			{
				_random = 10 - (random 30);
			};
			
			// _direction = (_direction + _random);
			
			// player sideChat format ["TCL_Move_F > Direction > %1 > %2", _group, _direction];
		}
		else
		{
			_skill = [_group] call TCL_Accuracy_F;
			
			_value = (_value / _skill);
			
			_distance = (random _value - random _value);
			
			// player sideChat format ["TCL_Move_F > Skill > %1 > %2 > %3", _group, _skill, _value];
		};
	}
	else
	{
		_distance = (random _value - random _value);
		
		private _units = (_logic getVariable "TCL_Units");
		
		private _groups = (_logic getVariable "TCL_Reinforcement");
		
		// {if ( (alive _enemy) && { (_x knowsAbout vehicle _enemy > 0) } && { (_enemy in _units) } ) exitWith {_logic setPos (getPos _enemy) } } count _groups;
	};
	
	if (vehicle _leader isKindOf "Ship") then
	{
		_direction = (_enemy getDir _leader);
		
		_distance = (_leader distance _enemy);
		
		_distance = (_distance - 300);
		
		private _position = [_object, _distance, _direction] call TCL_Real_Pos_F;
		
		if (surfaceIsWater _position) then
		{
			_distance = _distance;
		}
		else
		{
			_distance = (_distance + 200);
		};
	};
	
	if (_logic getVariable "TCL_Artillery" select 1) then
	{
		if (_leader distance _logic < 200) then
		{
			_distance = 0;
			
			_object = _leader;
			
			// player sideChat format ["TCL_Move_F > Artillery > %1", _group];
		};
	};
	
	// _distance = 0;
	
	// _distance = (_leader distance _enemy);
	
	_position = [_object, _distance, _direction] call TCL_Real_Pos_F;
	
	_position
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Move Function #3
	// ////////////////////////////////////////////////////////////////////////////
	// Move
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_group","_array","_range","_tweak"];
	
	if (_group in (TCL_Sneaking select 0) ) exitWith {_return = 100; _return};
	
	private _return = (TCL_Tweak select 3);
	
	private _random = (random 5);
	
	private _value = 1 + (random _tweak);
	
	_range = (_range / _value);
	
	// player sideChat format ["TCL_Move_F > Range > %1 > %2", _group, _range];
	
	private _count = (count _array);
	
	private _leader = (leader _group);
	
	if (_leader distance _enemy < _range) then
	{
		if (_count > 0) then
		{
			_return = (_return / _count);
		};
	}
	else
	{
		private _units = { (alive _x) } count (units _group);
		
		// if (_count isEqualTo _units) exitWith {};
		
		_units = (_units / 3);
		
		if (_count > _units) then
		{
			if (combatMode _group isEqualTo "YELLOW") then
			{
				_random = (random 5);
			}
			else
			{
				_random = (random 15);
			};
		};
	};
	
	_return = (_return + _random);
	
	// player sideChat format ["TCL_Move_F > Push > %1 > %2 > %3%4", _group, (combatMode _group), (round _return), "%"];
	
	_return
	
	}
];