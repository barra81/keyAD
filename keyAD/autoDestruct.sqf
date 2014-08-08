sleep 0.5;
_charID = _this select 0;
_whichAction = _this select 1;


_counterItemKey = _this select 2;



_playerUID = getPlayerUID player;




    _filtered = [[],[],[],[],[]]; 
    _cfg = (configFile >> "CfgVehicles"); 
    for "_i" from 0 to ((count _cfg)-1) do { 
        if (isClass ((_cfg select _i) ) ) then { 
            _cfgName = configName (_cfg select _i); 
								
			
            if ( (_cfgName isKindOf "Air") && (getNumber ((_cfg select _i) >> "scope") == 2) ) then { 
                _side = getNumber ((_cfg select _i) >> "side"); 
                _temp = _filtered select _side; 
                _temp set [count _temp, _cfgName ]; 
                _filtered set [_side, _temp]; 
            }; 
			
		    if ( (_cfgName isKindOf "Car") && (getNumber ((_cfg select _i) >> "scope") == 2) ) then { 
                _side = getNumber ((_cfg select _i) >> "side"); 
                _temp = _filtered select _side; 
                _temp set [count _temp, _cfgName ]; 
                _filtered set [_side, _temp]; 
            }; 
						
        }; 
    };  

	
  _filteredCount = count _filtered;
  _vehicle = vehicles;
  _vehIdArr = [];
  _notExist = false; 
  ownedVeh = [];

{
  _veh = _x;
  _vehID = _x getVariable ["CharacterID","0"];
  _vehIDNum = parseNumber _vehID;
  _vehIdArr set [(count _vehIdArr),_vehIDNum];

  

  if (_vehIDNum == _charID ) then {
  
      _typeOfVeh = typeOf _x;
      _vehPUID = _x getVariable ["OwnerPUID","0"];
  
  
      _existCheck = false;  
      _counter = -1;
	 for "_i" from 1 to _filteredCount do {
	      _counter = _counter + 1;
	      _subArr = _filtered select _counter;
		         
		  if (_typeOfVeh in _subArr) then {

                _existCheck = true;             
                _notExist = false;		  

				
			} else {
			
				_notExist = true;
			};	
              
			  if (_existCheck) exitWith {_notExist = false;};
  
        };

	
			 if ((_playerUID == _vehPUID) && !_notExist) then { 
			 
			      ownedVeh set [(count ownedVeh),_x];
				
                };
    };	   
     


	
}forEach _vehicle;





if ((count ownedVeh) > 0) then {

_dispArr = [];
{
  _typeOfVehi = typeOf _x;
  _VehName = getText(configFile >> "CfgVehicles" >> _typeOfVehi >> "displayName");
  _dispArr set [(count _dispArr),_VehName];
} forEach ownedVeh;


keyAD_menu3 = [

	           ["",true],
	           ["-- KeyAD select Vehicle --", [], "", -5, [["expression", ""]], "1", "0"],
	           ["", [-1], "", -5, [["expression", ""]], "1", "0"]
	           ];

			   
_counter = -1;			   
for "_i" from 1 to ( count ownedVeh) do {
	
    _counter = _counter +1;
	_display = _dispArr select _counter;
    _string = format ['[%1,%2,%3] execVM "keyAD\autoDestructExec.sqf"',_counter, _whichAction,_counterItemKey];			
    _action = [format["%1", _display], [],"",-5,[["expression",_string]],"1","1"];
    keyAD_menu3 set [(count keyAD_menu3),_action];	
};
    _action = ["", [-1], "", -5, [["expression", ""]], "1", "0"];
    keyAD_menu3 set [(count keyAD_menu3),_action];
    _action = [format["EXIT"], [],"",-5,[],"1","1"];
	keyAD_menu3 set [(count keyAD_menu3),_action];
	    
	showCommandingMenu "#USER:keyAD_menu3";
	
} else {
	
   	cutText [format["This vehicle doesnt exists any more!"], "PLAIN DOWN"];
    };
	