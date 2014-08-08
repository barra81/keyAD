_ownedVeh = ownedVeh;
_ownedVehCounter = _this select 0;
_whichAction = _this select 1;
_counterItemKey = _this select 2;
_itemKey = keysInInv select _counterItemKey;



_vehicle = _ownedVeh select _ownedVehCounter;
_typeOfVeh = typeOf _vehicle;
_VehName = getText(configFile >> "CfgVehicles" >> _typeOfVeh >> "displayName");


 _vehDis = player distance _vehicle;
 _maxDis = 4000;
          
   if (_whichAction == 1) then {		
								
		   _maxDis =20000;
	};				 
			 
			  
				if (_vehDis <= _maxDis) then {

		             if (_whichAction > 1) then {
                         cutText [format["Prepare for BOOMING of %1!", _VehName], "PLAIN DOWN"];
                        } else {
						 cutText [format["Searching for %1!", _VehName], "PLAIN DOWN"];
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
					  
                           _vehicle setDamage 1;
						   
						   if ((count _ownedVeh) == 1) then {
                               player removeWeapon _itemKey;
						  };
                           cutText [format["%1 got BOOMED!", _VehName], "PLAIN DOWN"];

						   
						} else {
                           openMap true;
						   _showVeh = false;
						   
						           while {visibleMap} do {
								   
			                          609 cutRsc ["KeyADHud_Rsc","PLAIN"];
                                     
									  while {visibleMap} do {
									 
												 
						                       _pos = getposATL _vehicle;
		                                       if (visibleMap) then {
			                                       deleteMarkerLocal _typeOfVeh;
			                                       _mrkr = createMarkerLocal [_typeOfVeh,_pos];
			                                       _mrkr setMarkerTypeLocal "DestroyedVehicle";
			                                       _mrkr setMarkerTextLocal format ["%1",_VehName];
		                                        };
							
							
							                   _Plicon = "\ca\ui\data\igui_side_blufor_ca.paa";
							                   _pIcons = [0, _plicon];
							                   player setVariable ["keyAD_Hud_pIcons", _pIcons];
						    
							                   _distance = _pos distance player;
							                   _pos set [2, (_pos select 2) + 1.5];
		                                       _screen = worldToScreen _pos;
							                   _picon = _pIcons select 0;
							                   _tag = composeText [image _Plicon," ",_VehName];
							
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
						};   
						   
				    }else {

		              cutText [format["Canceled action for %1 !", _VehName], "PLAIN DOWN"];

	                };
					
				} else {
                  
                  cutText [format["%1 is out of range!", _VehName], "PLAIN DOWN"];				  
	
				};
				
				