#include "TCL_Macros.hpp"

TCL_Random_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Random Function
	// ////////////////////////////////////////////////////////////////////////////
	// By Andrew Barron
	// Rewritten by Warka
	// Optimized by Karel Moricky
	// Optimised by Killzone_Kid
	// ////////////////////////////////////////////////////////////////////////////
	{private "_return";
	
	_return = selectRandom _this;
	
	_return
	
	};
	
TCL_Dir_To_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Direction To Function
	// ////////////////////////////////////////////////////////////////////////////
	// By Andrew Barron
	// Optimised by Killzone_Kid
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_object","_position"];
	
	private _direction = (_object getDir _position);
	
	_direction
	
	};
	
TCL_Rel_Dir_To_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Relative Direction To Function
	// ////////////////////////////////////////////////////////////////////////////
	// By Andrew Barron
	// Optimised and Extended by =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_object","_position"];
	
	private "_direction";
	
	if (isNull objectParent _object) then
	{
		_direction = (_object getRelDir _position);
	}
	else
	{
		private _weaponPosition = [];
		
		if (assignedVehicleRole _object select 0 == "Cargo") then
		{
			_weaponPosition = (_object weaponDirection currentWeapon _object);
		}
		else
		{
			private _vehicle = (vehicle _object);
			
			if (_vehicle isKindOf "Tank") then
			{
				_weaponPosition = (_vehicle weaponDirection currentWeapon _vehicle);
			};
		};
		
		if (_weaponPosition isEqualTo [] ) exitWith
		{
			_direction = (_object getRelDir _position);
		};
		
		private _weaponDirection = (_weaponPosition select 0) atan2 (_weaponPosition select 1);
		
		_weaponDirection = _weaponDirection - (_object getDir _position);
		
		if (_weaponDirection < 0) then {_weaponDirection = _weaponDirection + 360};
		
		if (_weaponDirection > 360) then {_weaponDirection = _weaponDirection - 360};
		
		_direction = _weaponDirection;
	};
	
	_direction
	
	};
	
TCL_Real_Pos_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Relative Position Function
	// ////////////////////////////////////////////////////////////////////////////
	// By Andrew Barron
	// Optimised by =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_position","_distance","_direction"];
	
	if (_position isEqualType objNull) exitWith
	{
		private _return = (_position getPos [_distance, _direction] select [0, 2] ) + [getPos _position select 2];
		
		_return
	};
	
	if (_position isEqualType [] ) exitWith
	{
		private _return = (_position getPos [_distance, _direction] select [0, 2] ) + ( [ [], [_position select 2] ] select (count _position > 2) );
		
		_return
	};
	
	};
	
TCL_Velocity_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Velocity Function
	// ////////////////////////////////////////////////////////////////////////////
	// By Raedor
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_object"];
	
	private _return = (vectorMagnitude velocity _object) * 3.6;
	
	_return
	
	};
	
	TCL_Shuffle_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Shuffle
	// ////////////////////////////////////////////////////////////////////////////
	// By Nelson Duarte
	// Optimised by Killzone_Kid
	// ////////////////////////////////////////////////////////////////////////////
	{
	
	_this = + _this;
	
	private _count = (count _this);
	
	for "0" from 1 to _count do 
	{
		_this pushBack (_this deleteAt floor random _count);
	};
	
	_this
	
	};
	
TCL_Building_Pos_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Building Position Function
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_building"];
	
	private _index = 0;
	
	while { (True) } do
	{
		if (_building buildingPos _index isEqualTo [0,0,0] ) exitWith
		{
			_index = _index - 1;
		};
		
		_index = _index + 1;
	};
	
	_index
	
	};
	
TCL_Daytime_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Daytime Function
	// ////////////////////////////////////////////////////////////////////////////
	// By CarlGustaffa
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_dayTime"];
	
	private _return = False;
	
	private _latitude = -1 * getNumber (configFile >> "CfgWorlds" >> worldName >> "latitude");
	private _year = 360 * (dateToNumber date);
	private _day = (_dayTime / 24) * 360;
	
	private _result = ( (12 * cos (_year) - 78) * cos (_latitude) * cos (_day) ) - (24 * sin (_latitude) * cos (_year) );
	
	if (_result > 0) then
	{
		_return = True;
	};
	
	_return
	
	};
	
TCL_Text_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Text Function
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	[ {"<t color='#ffff00'>" + _this + "</t>"},
	  {"<t color='#ff0000'>" + _this + "</t>"},
	  {"<t color='#bebebe'>" + _this + "</t>"},
	  "<t size='1.5' color='#ff0000' underline='True'>Warning!</t><br/>",
	  "<t size='1.5' color='#ffff00' underline='True'>Instruction:</t><br/>",
	  "<t size='1.5' color='#ffff00' underline='True'>Information:</t><br/>"
	];
	
TCL_Create_Marker_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Create Marker Function
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_array","_position","_shape","_size","_type","_color"];
	
	private _marker = _array joinString "";
	
	if (getMarkerPos _marker isEqualTo [0,0,0] ) then
	{
		createMarker [_marker, _position];
		
		_marker setMarkerShape _shape;
		
		_marker setMarkerSize _size;
		
		private _array = ["Horizontal","Border","FDiagonal"];
		
		if (_type in _array) then
		{
			_marker setMarkerBrush _type;
		}
		else
		{
			_marker setMarkerType _type;
		};
		
		_marker setMarkerColor _color;
	}
	else
	{
		_marker = "";
	};
	
	_marker
	
	};
	
TCL_Rank_F =

	// ////////////////////////////////////////////////////////////////////////////
	// Rank Function
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit"];
	
	private _return = 0;
	
	if (alive _unit) then
	{
		private _rank = (rank _unit);
		
		if (_rank isEqualTo "PRIVATE") exitWith
		{
			_return = 1;
		};
		
		if (_rank isEqualTo "CORPORAL") exitWith
		{
			_return = 2;
		};
		
		if (_rank isEqualTo "SERGEANT") exitWith
		{
			_return = 3;
		};
		
		if (_rank isEqualTo "LIEUTENANT") exitWith
		{
			_return = 4;
		};
		
		if (_rank isEqualTo "CAPTAIN") exitWith
		{
			_return = 5;
		};
		
		if (_rank isEqualTo "MAJOR") exitWith
		{
			_return = 6;
		};
		
		if (_rank isEqualTo "COLONEL") exitWith
		{
			_return = 7;
		};
	};
	
	_return
	
	};
	
	TCL_Trigger_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Trigger Function
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group","_object"];
	
	private _return = False;
	
	private _trigger = (_group getVariable "TCL_Trigger");
	
	if (_object inArea _trigger) then
	{
		_return = True;
	};
	
	_return
	
	};
	
	TCL_Visible_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Visible Function
	// ////////////////////////////////////////////////////////////////////////////
	// Visible
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_units","_group","_logic"];
	
	private _time = 0;
	
	private _array = [];
	
	private _bool = True;
	
	private _knowledge = 0;
	
	// private _random = 10 + (random 30);
	
	private _random = 5 + (random 10);
	
	private _tweak = (TCL_IQ select 2);
	
	private _value = 1 + (random _tweak);
	
	// private _value = 1 + _tweak;
	
	_random = (_random * _value);
	
	_units = _units select { ( (alive _x) && { (_x knowsAbout vehicle _enemy > 0) } ) };
	
	// player sideChat format ["TCL_Visible_F > Knowledge > %1", _units];
	
	private ["_unit","_knowledge","_time"];
	
	private _count = 0;
	
	for "_count" from _count to (count _units - 1) do
	{
		_unit = (_units select _count);
		
		_knowledge = (_unit targetKnowledge vehicle _enemy) select 2;
		
		if (_knowledge < 0) then
		{
			_knowledge = (_unit targetKnowledge vehicle _enemy) select 3;
		};
		
		if (_knowledge > 0) then
		{
			_time = (time - _knowledge);
			
			// player sideChat format ["TCL_Visible_F > Knowledge > %1 > %2 > %3", _unit, _time, _random];
			
			// player sideChat format ["TCL_Visible_F > Knowledge > %1 > %2 > %3", time, _time, _knowledge];
			
			if (_time < _random) then
			{
				_bool = False;
				
				_array pushBack _unit;
				
				// player sideChat format ["TCL_Visible_F > Knowledge > %1 > %2 > %3", _unit, _time, _random];
			}
			else
			{
				if (_unit distance _logic < 100) then
				{
					if (floor (random 100) < 35) then
					{
						// _array pushBack _unit;
					};
				}
				else
				{
					if (floor (random 100) < 15) then
					{
						// _array pushBack _unit;
					};
				};
			};
		};
		
		if (TCL_Debug select 6) then
		{
			[_unit, _enemy, _array] spawn (TCL_Debug_F select 3);
		};
	};
	
	if (_bool) then
	{
		// player sideChat format ["TCL_Visible_F > Lost LOS > %1", _group];
		
		private _skill = [_group] call TCL_Accuracy_F;
		
		_random = 30 + (random 50);
		
		// private _tweak = (TCL_IQ select 2);
		
		// private _value = 1 + (random _tweak);
		
		_random = (_random * _value);
		
		_random = (_random * _skill);
		
		if (_time > _random) then
		{
			_group forgetTarget (vehicle _enemy);
		};
		
		// player sideChat format ["TCL_Visible_F > Forget > %1 > %2 > %3", _group, _time, _random];
	};
	
	_array
	
	};
	
	TCL_Knowledge_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Knowledge Function
	// ////////////////////////////////////////////////////////////////////////////
	// Knowledge
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_enemy","_groups"];
	
	private _return = False;
	
	private ["_group","_units","_knowsAbout"];
	
	private _count = 0;
	
	for "_count" from _count to (count _groups - 1) do
	{
		_group = (_groups select _count);
		
		_units = (units _enemy);
		
		// player sideChat format ["TCL_Knowledge_F > Units > %1", (count _units) ];
		
		_knowsAbout = (_units findIf { ( (alive _x) && { (_group knowsAbout vehicle _x > 0) } ) } );
		
		if (_knowsAbout > -1) exitWith
		{
			_return = True;
		};
	};
	
	_return
	
	};
	
	TCL_Spawn_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Spawn Function
	// ////////////////////////////////////////////////////////////////////////////
	// Spawn
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group"];
	
	private _count = 0;
	
	while { (_count < count units _group) } do
	{
		sleep 1;
		
		_count = _count + 1;
		
		// player sideChat format ["TCL_Spawn_F > Count > %1 > %2", _group, _count];
	};
	
	if (TCL_Multiplayer) then
	{
		private _leader = (leader _group);
		
		if (local _leader) exitWith {};
		
		if (_group in (TCL_Zeus select 0) ) then
		{
			_group setGroupOwner 2;
		};
	};
	
	private _value = (TCL_System select 8);
	
	sleep _value;
	
	private _units = (units _group);
	
	if (_units findIf { (alive _x) } > -1) then
	{
		_group = [_group];
		
		[_group] call (TCL_Groups_F select 0);
	};
	
	};
	
	TCL_Cover_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Cover Function
	// ////////////////////////////////////////////////////////////////////////////
	// Cover
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_unit","_array","_distance"];
	
	private _position = (_array select 1);
	
	_objects = (_array select 2);
	
	if ( (_unit distance _position > _distance) || (_objects isEqualTo [] ) ) then
	{
		_objects = nearestTerrainObjects [_position, ["HIDE","ROCK","ROCKS","BUSH"], _distance];
		
		_array set [2, _objects];
		
		_array set [1, (getPos _unit) ];
		
		player sideChat format ["TCL_Take_Cover_F > Far > %1 > %2", _unit, (count _objects) ];
	}
	else
	{
		player sideChat format ["TCL_Take_Cover_F > Close > %1 > %2", _unit, (count _objects) ];
	};
	
	_objects
	
	};
	
	TCL_Exist_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Exist Function
	// ////////////////////////////////////////////////////////////////////////////
	// Exist
	// By Killzone_Kid
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_file"];
	
	private _return = False;
	
	disableSerialization;
	
	private _ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
	
	_ctrl htmlLoad _file;
	
	private _bool = ctrlHTMLLoaded _ctrl;
	
	if (_bool) then
	{
		_return = True;
	};
	
	_return
	
	};
	
	TCL_Accuracy_F =
	
	// ////////////////////////////////////////////////////////////////////////////
	// Accuracy Function
	// ////////////////////////////////////////////////////////////////////////////
	// Accuracy
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group"];
	
	private _skill = 1;
	
	private _leader = (leader _group);
	
	if (alive _leader) then
	{
		_skill = _skill + (_leader skill "general");
		
		_skill = _skill + (_leader skill "commanding");
		
		_skill = _skill - (_leader skill "courage");
		
		if (_skill < 1) then
		{
			_skill = 1;
		};
		
		// player sideChat format ["TCL_Accuracy_F > Skill > %1 > %2", _leader, _skill];
	};
	
	_skill
	
	};