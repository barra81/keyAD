_keysInInv = _this select 0;
_keyIdArr = _this select 1;
_totalKeys = count _keysInInv;


	if (_totalKeys > 0) then {
	   
	    findDisplay 106 closeDisplay 3000;
	    
	  
	   find_vehicle = (vehicle player) addaction [format["Find Vehicle"], "keyAD\2ndMenu.sqf", [_keysInInv,_keyIdArr,1], 7, false, true, "", ""];
	   boom_vehicle = (vehicle player) addaction [format["Destroy Vehicle"], "keyAD\2ndMenu.sqf", [_keysInInv,_keyIdArr,2], 7, false, true, "", ""];
	   keyAD_exit = (vehicle player) addaction [format["EXIT Keys-Menu"], "keyAD\exit.sqf", [_totalKeys], 6, false, true, "", ""];
	   cutText [format["Please scroll and choose Vehicle action!"], "PLAIN DOWN"];
    };