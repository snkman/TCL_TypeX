TCL_Helicopter_F = [

	// ////////////////////////////////////////////////////////////////////////////
	// Helicopter Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group","_logic","_vehicle"];
	
	private _array = [];
	
	private _bool = False;
	
	private _units = (units _group);
	
	if (_group getVariable "TCL_Eject") then
	{
		private "_unit";
		
		private _count = 0;
		
		for "_count" from _count to (count _units - 1) do
		{
			_unit = (_units select _count);
			
			if (assignedVehicleRole _unit select 0 == "Cargo") then
			{
				_array pushBack _unit;
				
				if (backpack _unit isEqualTo "B_Parachute") then
				{
					_unit action ["EJECT", _vehicle];
					
					_unit allowDamage False;
					
					_array pushBack _unit;
					
					sleep 1 - (random 1);
				}
				else
				{
					_bool = True;
				};
				
				[_unit] orderGetIn False; [_unit] allowGetIn False;
			};
		};
	}
	else
	{
		_bool = True;
		
		_units select { (assignedVehicleRole _x select 0 == "Cargo") } apply {_array pushBack _x; [_x] orderGetIn False; [_x] allowGetIn False};
	};
	
	private _crew = (crew _vehicle);
	
	_crew = _crew - _array;
	
	if (_bool) then
	{
		_vehicle flyInHeight 100;
		
		{_x disableAI "AUTOCOMBAT"; _x disableAI "AUTOTARGET"; _x doWatch objNull; _x commandWatch objNull} count _crew;
		
		_vehicle setBehaviour "AWARE";
		
		_vehicle setCombatMode "WHITE";
		
		_vehicle land "GET OUT";
	};
	
	if (count _array > 0) then
	{
		while { (_array findIf { (_x in _vehicle) } > -1) } do
		{
			sleep 5;
		};
		
		{_x allowDamage True} count _array;
		
		private _leader = (leader _group);
		
		if (_leader in _array) then
		{
			_group setVariable ["TCL_Helicopter", (driver _vehicle) ];
		}
		else
		{
			_group setVariable ["TCL_Helicopter", _leader];
			
			_leader = (_array select 0);
			
			_group selectLeader _leader;
			
			{_x setUnitRank "PRIVATE"} count _crew;
			
			{if (rank _x == "PRIVATE") then {_x setUnitRank "CORPORAL"} } count _array;
		};
	};
	
	private _random = 100;
	
	private _gunner = (gunner _vehicle);
	
	if ( (alive _gunner) && { (canFire _vehicle) } && { (someAmmo _vehicle) } ) then
	{
		_random = 50;
		
		// player sideChat format ["TCL_Helicopter_F > Armed > %1", _vehicle];
	};
	
	_vehicle flyInHeight 100;
	
	if ( (alive _logic) && { (floor (random 100) < _random) } ) exitWith
	{
		private _crew = (crew _vehicle);
		
		(TCL_Helicopter select 0) append _crew;
		
		_position = (_group getVariable "TCL_Position");
		
		{_x disableAI "FSM"; _x disableAI "AUTOCOMBAT"; _x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"} count _crew;
		
		// _vehicle flyInHeight 100;
		
		sleep 10 + (random 30);
		
		_vehicle doMove _position;
		
		private _land = "Land_HelipadEmpty_F" createVehicleLocal _position;
		
		while { ( (alive _vehicle) && { (_vehicle distance2D _position > 100) } ) } do
		{
			sleep 1;
		};
		
		if (alive _logic) then
		{
			doStop _vehicle;
			
			_vehicle land "LAND";
			
			// _vehicle forceSpeed 0;
			
			while { (getPos _vehicle select 2 > 10) } do
			{
				sleep 1;
			};
		};
		
		deleteVehicle _land;
	};
	
	_group selectLeader (driver _vehicle);
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Helicopter Function #1
	// ////////////////////////////////////////////////////////////////////////////
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group","_crew","_vehicle"];
	
	private _leader = (leader _group);
	
	private _position = (_group getVariable "TCL_Position");
	
	{_x enableAI "FSM"; _x enableAI "AUTOCOMBAT"; _x enableAI "AUTOTARGET"; _x enableAI "CHECKVISIBLE"} forEach (crew _vehicle);
	
	_vehicle forceSpeed -1;
	
	private _units = (units _group);
	
	_units = _units - _crew;
	
	if (_units findIf { (alive _x) } > -1) then
	{
		private _unit = (_units select 0);
		
		{if (_x == _leader) exitWith {_unit = _x} } count _units;
		
		_vehicle doMove (getPos _unit);
		
		// _group move (getPos _unit);
		
		// _units doFollow _leader;
		
		while { (_vehicle distance2D _unit > 100) } do
		{
			sleep 1;
		};
		
		if (floor (random 100) < 50) then
		{
			_vehicle land "LAND";
		}
		else
		{
			_vehicle land "GET IN";
		};
	};
	
	[_group] call (TCL_Remount_F select 2);
	
	_group move _position;
	
	// units _group doFollow _leader;
	
	while { ( (alive _vehicle) && { (_vehicle distance2D _position > 100) } ) } do
	{
		sleep 1;
	};
	
	_vehicle land "LAND";
	
	}
];