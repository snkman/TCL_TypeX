/*  ////////////////////////////////////////////////////////////////////////////////
\   \ Tactical Combat Link
 \   \------------------------------------------------------------------------------
  \   \ Macros
   \   \----------------------------------------------------------------------------
   /   / By =\SNKMAN/=
  /   /-----------------------------------------------------------------------------
*/   ///////////////////////////////////////////////////////////////////////////////
#define TCL_DeleteAT(_array, _index, _object); (_array select _index) deleteAt ( (_array select _index) find _object);