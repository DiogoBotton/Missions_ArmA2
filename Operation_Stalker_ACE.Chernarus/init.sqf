execVM "briefing.sqf";
execVM "CriarPrenderTriggersNosCarros.sqf";

//SALVA OS PARÂMETROS DO LOBBY COMO VARIÁVEIS GLOBAIS
if (isNil "paramsArray") then
	{
    	if (isClass (missionConfigFile/"Params")) then
		{
        	for "_i" from 0 to (count (missionConfigFile/"Params") - 1) do
			{
			_paramName = configName ((missionConfigFile >> "Params") select _i);
			missionNamespace setVariable [_paramName, getNumber (missionConfigFile >> "Params" >> _paramName >> "default")];
            		};
	        };
	} else

	{
	for "_i" from 0 to (count paramsArray - 1) do
		{
		missionNamespace setVariable [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
	        };
};

//DETERMINA SE ESTA DEBUGANDO OU NAO
debugar = (ParamDEBUGAR);

if(debugar == 1) then {investigou = true} else {investigou = false;};
if(debugar == 1) then {vilasInvestigadas = 2;} else {vilasInvestigadas = 0;};

nukeDetonated = false;

//define Say3D como comando de efeito global
fn_netSay3D = compile preprocessFileLineNumbers "fn_netSay3D.sqf";

if (isNil "PVEH_netSay3D") then {
PVEH_NetSay3D = [objNull,0];
};

"PVEH_netSay3D" addPublicVariableEventHandler {
     private["_array"];
     _array = _this select 1;
    (_array select 0) say3D (_array select 1);
};

fnc_killLights = {
	private "_cfg";
	_cfg = configFile >> "CfgVehicles" >> (typeOf _this) >> "Reflectors";
	for "_i" from 0 to count(_cfg) - 1 do
		{
		_this setHit [getText((_cfg select _i) >> "selection"), 1];
		};
	};

// Apaga luzes de postes das cidades atingidas pela explosão
desligarShakhovka = [luzesShakhovka,150] execVM "apagarCidades.sqf";
desligarPolana = [luzesPolana,230] execVM "apagarCidades.sqf";