

_keysInInv = _this select 3 select 0;
_keyIdArr = _this select 3  select 1;
_whichAction = _this select 3 select 2;
_totalKeys = count _keysInInv;


player removeAction find_vehicle;
player removeAction boom_vehicle;
player removeAction keyAD_exit;
dayz_menu = [];

_dispNameArr = [];
{
  _keyName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
  _dispNameArr set [(count _dispNameArr),_keyName];

} forEach _keysInInv;


	if (_totalKeys > 0) then {
	   
	    findDisplay 106 closeDisplay 3000;
	   	cutText [format["Please scroll and choose a Key!"], "PLAIN DOWN"];
   
       _counter = -1;   
	   for "_i" from 1 to _totalKeys do {
	    
	        _counter = _counter + 1;
			_display = _dispNameArr select _counter;
			_keyID   = _keyIdArr select _counter;
			_itemKey = _keysInInv select _counter;
			
			if (_whichAction > 1) then {
			
		        _action = (vehicle player) addaction [format["%1", _display], "keyAD\autoDestruct.sqf", [_keyID,_totalKeys, _itemKey,2], 7, false, true, "", ""];
			    dayz_menu set [(count dayz_menu),_action];
		    
			} else {
			
		       _action = (vehicle player) addaction [format["%1", _display], "keyAD\autoDestruct.sqf", [_keyID,_totalKeys, _itemKey,1], 7, false, true, "", ""];
			   dayz_menu set [(count dayz_menu),_action];
			};			
	    };
        keyAD_exit = (vehicle player) addaction [format["EXIT Keys-Menu"], "keyAD\exit.sqf", [_totalKeys], 6, false, true, "", ""];
		
	};	