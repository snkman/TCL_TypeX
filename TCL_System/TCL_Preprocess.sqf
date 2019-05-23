/*  ////////////////////////////////////////////////////////////////////////////////
\   \ Tactical Combat Link
 \   \------------------------------------------------------------------------------
  \   \ Preprocess
   \   \----------------------------------------------------------------------------
   /   / By =\SNKMAN/=
  /   /-----------------------------------------------------------------------------
*/   ///////////////////////////////////////////////////////////////////////////////

if (isNil "TCL_Preprocess") then
{
	TCL_Preprocess = True;
	
	TCL_Initialize = False;
	
	TCL_Server = False;
	
	if (isServer) then
	{
		TCL_Server = True;
	};
	
	TCL_Multiplayer = False;
	
	TCL_Dedicated = False;
	
	TCL_RemoteExec = 0;
	
	if (isMultiplayer) then
	{
		TCL_Multiplayer = True;
		
		if (isDedicated) then
		{
			TCL_Dedicated = True;
			
			TCL_RemoteExec = 1;
		};
	};
	
	TCL_FilePatching = False;
	
	if (isFilePatchingEnabled) then
	{
		TCL_FilePatching = True;
	};
	
	execFSM (TCL_Path+"TCL_Initialize.fsm");
};