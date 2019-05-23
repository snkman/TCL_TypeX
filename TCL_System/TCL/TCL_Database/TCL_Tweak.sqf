// ////////////////////////////////////////////////////////////////////////////
// Tactical Combat Link
// ////////////////////////////////////////////////////////////////////////////
// Tweak Database
// Based on Operation Flashpoint Mod E.C.P. ( Enhanced Configuration Project )
// By =\SNKMAN/=
// ////////////////////////////////////////////////////////////////////////////

if (TCL_Server) then
{
	if (isNil "TCL_Tweak") then
	{
		TCL_Tweak = [
			
			// 0 ( Behaviour )
			50,
			
			// 1 ( Push Distance )
			300,
			
			// 2 ( Push Factor )
			1,
			
			// 3 ( Push Chance )
			50
		];
		
		if (TCL_FilePatching) then
		{
			if ("UserConfig\TCL\TCL_Tweak.sqf" call TCL_Exist_F) then
			{
				call compile preprocessFileLineNumbers "UserConfig\TCL\TCL_Tweak.sqf";
			};
		};
	};
};