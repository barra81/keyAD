sleep 0.5;
_charID = _this select 3 select 0;
_totalKeys = _this select 3 select 1;
_itemKey = _this select 3 select 2;

_counter = -1;
for "_i" from 1 to _totalKeys do {
_counter = _counter + 1;
_menu = dayz_menu select _counter;
player removeAction _menu;
};
player removeAction keyAD_exit;




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
{

  _abort = false;
  _vehID = _x getVariable ["CharacterID","0"];
  _vehIDNum = parseNumber _vehID;
  _vehIdArr set [(count _vehIdArr),_vehIDNum];
  
 
  
     _existCheck = false;  
     _typeOfX = typeOf _x;
     _counter = -1;
	 for "_i" from 1 to _filteredCount do {
	      _counter = _counter + 1;
	      _subArr = _filtered select _counter;
		         
		  if (!(_typeOfX in _subArr)) then {
				
				_notExist = true;
				
			} else {
                _existCheck = true;             
                _notExist = false;
			};	
              
			  if (_existCheck) exitWith {};
  
        };

  
  

  if ((_vehIDNum == _charID) && !_notExist) then {
        
       
                _typeOfVeh = typeOf _x;
                _vehDis = player distance _x;
				_maxDis = 4000;
				
				if (_vehDis <= _maxDis) then {

		 
                cutText [format["Prepare for BOOMING of %1!", _typeOfVeh], "PLAIN DOWN"];		 
                [1,1] call dayz_HungerThirst;
				player playActionNow "Medic";

				[player,"repair",0,false] call dayz_zombieSpeak;
				[player,10,true,(getPosATL player)] spawn player_alertZombies;

				r_interrupt = false;
				_animState = animationState player;
				r_doLoop = true;				
				_setOK = false;
				_started = false;
				
					 while {r_doLoop} do {
					_animState = animationState player;
					_isMedic = ["medic",_animState] call fnc_inString;
					if (_isMedic) then {
						_started = true;
					};
					if (_started && !_isMedic) then {
						r_doLoop = false;				
						_setOK = true;
					};
					if (r_interrupt) then {
						r_doLoop = false;
						if (vehicle player == player) then {
						[objNull, player, rSwitchMove,""] call RE;
						player playActionNow "stop";
					    };						
					};
					sleep 0.1;
				    };
				    r_doLoop = false;
			 
			        if (_setOK) then {
   
                       _x setDamage 1;
                       player removeWeapon _itemKey;
                       cutText [format["%1 got BOOMED!", _typeOfVeh], "PLAIN DOWN"];
		               _abort = true;
				    }else {

		              cutText [format["Canceled BOOMING of %1 !", _typeOfVeh], "PLAIN DOWN"];
					  _abort = true;
	                };
					
				} else {
                  
                  cutText [format["%1 is out of range!", _typeOfVeh], "PLAIN DOWN"];				  
				  _abort = true;	
				};						
            };	   
     

    if (_abort) exitWith {};
	
}forEach _vehicle;



  if (_notExist || !(_charID in _vehIdArr))  then {

      cutText [format["This vehicle doesnt exists any more!"], "PLAIN DOWN"];
    };
	