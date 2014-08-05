waitUntil {!isNil "dayz_animalCheck"};


if (isNil "keyAD_init") then {call compile preprocessFileLineNumbers "keyAD\icons.sqf";};
uiSleep 1;
[] spawn keyAD_init;