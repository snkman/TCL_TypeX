// ////////////////////////////////////////////////////////////////////////////
// Tactical Combat Link
// ////////////////////////////////////////////////////////////////////////////
// Feature Database
// Based on Operation Flashpoint Mod E.C.P. ( Enhanced Configuration Project )
// By =\SNKMAN/=
// ////////////////////////////////////////////////////////////////////////////

if (TCL_Server) then
{
	if (isNil "TCL_Feature") then
	{
		TCL_Feature = [
		
			// 0 ( Watch )
			True,
			50,
			
			// 2 ( Garrison )
			True,
			
			// 3 - 6 ( Smoke )
			True,
			50,
			True,
			75,
			
			// 7 ( Flare )
			True,
			50,
			
			// 9 ( Artillery )
			True,
			15,
			
			// 11 ( House Search )
			True,
			50,
			
			// 13 ( Static Weapon )
			True,
			50,
			
			// 15 - 17 ( Take Cover )
			True,
			75,
			30,
			
			// 18 - 22 ( Advancing )
			True,
			15,
			50,
			300,
			700,
			
			// 23 - 25 ( Suppressed )
			True,
			0.90,
			5
		];
		
		if (TCL_FilePatching) then
		{
			if ("UserConfig\TCL\TCL_Feature.sqf" call TCL_Exist_F) then
			{
				call compile preprocessFileLineNumbers "UserConfig\TCL\TCL_Feature.sqf";
			};
		};
	};
};