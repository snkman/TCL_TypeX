/*  ////////////////////////////////////////////////////////////////////////////////
\   \ Zeus ExecVM
 \   \------------------------------------------------------------------------------
  \   \ By =\SNKMAN/=
  /   /-----------------------------------------------------------------------------
*/   ///////////////////////////////////////////////////////////////////////////////
params ["_curators"];

waitUntil { ( (alive player) && (time > 0) ) };

private _bool = True;

private _curator = objNull;

private ["_count","_curator"];

while { (_bool) } do
{
	_count = 0;
	
	for "_count" from _count to (count _curators - 1) do
	{
		_curator = (_curators select _count);
		
		_player = getAssignedCuratorUnit _curator;
		
		if (_player == player) exitWith
		{
			_bool = False;
			
			// player sideChat format ["TCL_Initialize > Curator > %1", _curator];
		};
	};
	
	sleep 1;
};

if (alive _curator) then
{
	_curator addEventHandler ["CuratorObjectPlaced", {_this spawn (TCL_EH_Zeus_F select 0) } ];
	
	_curator addEventHandler ["CuratorWaypointPlaced", {_this call (TCL_EH_Zeus_F select 1) } ];
	
	_curator addEventHandler ["CuratorWaypointDeleted", {_this call (TCL_EH_Zeus_F select 2) } ];
};