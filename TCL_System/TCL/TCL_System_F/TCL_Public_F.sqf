TCL_Public_F = [

	// ////////////////////////////////////////////////////////////////////////////
	// Public Function #0
	// ////////////////////////////////////////////////////////////////////////////
	// Public
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_object"];
	
	if (_object isKindOf "Man") then
	{
		[_object] spawn (TCL_Fire_FX_F select 0);
	}
	else
	{
		[_object] spawn (TCL_Whiz_FX_F select 2);
	};
	
	},
	
	// ////////////////////////////////////////////////////////////////////////////
	// Public Function #1
	// ////////////////////////////////////////////////////////////////////////////
	// Public
	// By =\SNKMAN/=
	// ////////////////////////////////////////////////////////////////////////////
	{params ["_object"];
	
	if (_object isEqualType grpNull) then
	{
		private _group = _object;
		
		(TCL_Zeus select 0) pushBack _group;
	}
	else
	{
		private _group = _this select 1;
		
		if (_group in (TCL_Zeus select 1) ) then
		{
			_this call (TCL_EH_Zeus_F select 2);
		}
		else
		{
			_this call (TCL_EH_Zeus_F select 1);
		};
	};
	
	}
];