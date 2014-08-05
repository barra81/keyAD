sleep 0.5;
_charID = _this select 3 select 0;
_totalKeys = _this select 3 select 1;
_itemKey = _this select 3 select 2;
_whichAction = _this select 3 select 3;
_playerUID = getPlayerUID player;


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
  _veh = _x;
  _abort = false;
  _vehID = _x getVariable ["CharacterID","0"];
  _vehIDNum = parseNumber _vehID;
  _vehIdArr set [(count _vehIdArr),_vehIDNum];
  _vehPUID = _veh getVariable ["OwnerPUID","0"];
  _typeOfX = typeOf _x;



// ["conGreen",format ["_vehPUID: %1, _veh: %2", _vehPUID, _veh]] call diaglog;
  
     _existCheck = false;  

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
       
	   if (_whichAction == 1) then {		
								
		   _maxDis =20000;
		};		
				
				
			 if (_playerUID == _vehPUID) then { 
			  
				if (_vehDis <= _maxDis) then {

		             if (_whichAction > 1) then {
                         cutText [format["Prepare for BOOMING of %1!", _typeOfVeh], "PLAIN DOWN"];
                        } else {
						 cutText [format["Searching for %1!", _typeOfVeh], "PLAIN DOWN"];
				        };
						
                    [1,1] call dayz_HungerThirst;
				    player playActionNow "Medic";
                       if (_whichAction > 1) then {
				          [player,"repair",0,false] call dayz_zombieSpeak;
					    } else {
                          [player,"bandage",0,false] call dayz_zombieSpeak;
                        }; 
						
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
					
					   if (_whichAction > 1) then {
					  
                           _x setDamage 1;
                           player removeWeapon _itemKey;
                           cutText [format["%1 got BOOMED!", _typeOfVeh], "PLAIN DOWN"];
		                   _abort = true;
						   
						} else {
                           openMap true;
						   _showVeh = false;
						   
						           while {visibleMap} do {
								   
			                          609 cutRsc ["KeyADHud_Rsc","PLAIN"];
                                     
									  while {visibleMap} do {
									 
												 
						                       _pos = getposATL _x;
		                                       if (visibleMap) then {
			                                       deleteMarkerLocal _typeOfVeh;
			                                       _mrkr = createMarkerLocal [_typeOfVeh,_pos];
			                                       _mrkr setMarkerTypeLocal "DestroyedVehicle";
			                                       _mrkr setMarkerTextLocal format ["%1",_typeOfVeh];
		                                        };
							
							
							                   _Plicon = "\ca\ui\data\igui_side_blufor_ca.paa";
							                   _pIcons = [0, _plicon];
							                   player setVariable ["keyAD_Hud_pIcons", _pIcons];
						    
							                   _distance = _pos distance player;
							                   _pos set [2, (_pos select 2) + 1.5];
		                                       _screen = worldToScreen _pos;
							                   _picon = _pIcons select 0;
							                   _tag = composeText [image _Plicon," ",_typeOfVeh];
							
							                   _scale = 0;
				                               _sx = _screen select 0;
				                               _sy = _screen select 1;
				                               if (_distance < 200) then {
					                               _scale = 0.3;
				                                } else {
					                              _scale = 1 min ((1 - ((_distance) - 3) / 15) max 0.3); 
				                                };	
							
							
				                             ((uiNamespace getVariable "keyAD_Hud_Disp") displayCtrl 73311 ) ctrlSetStructuredText _tag;
				                             ((uiNamespace getVariable "keyAD_Hud_Disp") displayCtrl 73311 ) ctrlSetPosition [_sx, _sy, 0.99, 0.65];
				                             ((uiNamespace getVariable "keyAD_Hud_Disp") displayCtrl 73311 ) ctrlSetScale _scale;
				                             ((uiNamespace getVariable "keyAD_Hud_Disp") displayCtrl 73311 ) ctrlSetFade ((1- _scale ) / 2);
				                             ((uiNamespace getVariable "keyAD_Hud_Disp") displayCtrl 73311 ) ctrlCommit 0;
				                             ((uiNamespace getVariable "keyAD_Hud_Disp") displayCtrl 73311 ) ctrlShow true;
													   						   
						                     609 cutText ["","PLAIN"];
						                };
										
						               deleteMarkerLocal _typeOfVeh;         
                                    };	
									
						    _abort = true; 
						   
						};   
						   
				    }else {

		              cutText [format["Canceled action for %1 !", _typeOfVeh], "PLAIN DOWN"];
					  _abort = true;
	                };
					
				} else {
                  
                  cutText [format["%1 is out of range!", _typeOfVeh], "PLAIN DOWN"];				  
				  _abort = true;	
				};
              } else {
                  cutText [format["%1 is not yours!", _typeOfVeh], "PLAIN DOWN"];				  
				  _abort = true;
			    };	
            };	   
     

    if (_abort) exitWith {};
	
}forEach _vehicle;



  if ((_notExist) || (!(_charID in _vehIdArr)))  then {

      cutText [format["This vehicle doesnt exists any more!"], "PLAIN DOWN"];
    };
	