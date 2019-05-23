TCL_Regroup_F = [

	// ////////////////////////////////////////////////////////////////////////////
	// Regroup Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// Regroup
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group","_logic","_units"];
	
	private _ai = (_group getVariable "TCL_AI" select 9);
	
	if (_ai) then
	{
		private _array = ( (TCL_Hold select 0) + (TCL_Defend select 0) + (TCL_Location select 0) );
		
		if (_group in _array) exitWith {};
		
		if (_units < 3) then
		{
			private _groups = (_logic getVariable "TCL_Reinforcement");
			
			_groups = _groups - [_group];
			
			_groups = _groups select { (side _group isEqualTo side _x) };
			
			if (_groups isEqualTo [] ) exitWith {};
			
			[_group, _logic, _units, _groups] call (TCL_Regroup_F select 1);
		};
	};
	
	True
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Regroup Function #1
	// ////////////////////////////////////////////////////////////////////////////
	// Regroup
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_group","_logic","_units","_groups"];
	
	private _echo = _group;
	
	private _leader = (leader _echo);
	
	if (isNull objectParent _leader) then
	{
		private _rank = [_leader] call TCL_Rank_F;
		
		private "_kilo";
		
		private _count = 0;
		
		for "_count" from _count to (count _groups - 1) do
		{
			_kilo = (_groups select _count);
			
			_condition = (units _kilo) select { ( (alive _x) && { (isNull objectParent _x) } && { (_x distance _leader < 100) } ) };
			
			if ( (_units <= count _condition) && { (_rank <= [leader _kilo] call TCL_Rank_F) } && { ( [_echo, _kilo] call (TCL_KnowsAbout_F select 4) ) } ) exitWith
			{
				private _units = (units _echo);
				
				["TCL_Position", _echo] call (TCL_Marker_F select 0);
				
				// player sideChat format ["TCL_Regroup_F > Group > %1", _echo];
				
				_groups = (_logic getVariable "TCL_Reinforcement");
				
				_groups deleteAt (_groups find _echo);
				
				_units join _kilo;
				
				(TCL_Regroup select 0) append _units;
				
				_units select { (count assignedVehicleRole _x > 0) } apply { [_x] orderGetIn False; [_x] allowGetIn False};
			};
		};
	};
	
	True
	
	}
];