SFV_V = vehicle player;
moveOut player;
waitUntil {vehicle player == player};
player attachTo [SFV_V,[0,-0.2,-1]];
[-2, {[_this] spawn fn_dsl_mh6_SetFFVAnim},player] call cba_fnc_globalexecute;
player setVariable ["st_mh6_enhance_ffv_active",true];
player setDir 360;
[31, [false, false, false], {player execVM "SFV\ATV\stopD.sqf"}] call CBA_fnc_addKeyHandler;
hint format ["CONTROLS \n\nAim+ALT to free-aim \n\nS to stop/reload"];