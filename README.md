keyAD
=====

destroy vehicle remotly(if key is present and OWNER) via any item configured in extraRC.hpp



KeyAD needs extraRC installed to work!!!


install:

just copy the "keyAD" into the root directory of yourmissionfile.pbo



in your extraRC.hpp add :

  class menuItem2 {
    text = "Vehicle Remote Menu";
	script = "[] execVM 'keyAD\keys.sqf'";
 };
 
 
 to any Item you want, as seen in the sample extraRC.hpp

 _____________________________________________________________________________________________
 
 in your compiles.sqf
 
 find
 
// trader menu code
if (DZE_ConfigTrader) then {
		call compile preprocessFileLineNumbers "originalPath";
		
and replace the original path with this one

"keyAD\player_traderMenuConfig.sqf";

in the else directly below it change the original path to this one

"keyAD\player_traderMenuHive.sqf";

_____________________________________________________________________________________________

in your description.ext

add

#include "keyAD\keyAD_icons.hpp"

into the "RSCTitels" class, see sample for detailed position

______________________________________________________________________________________________ 
                 SERVER FILES
				 
at your "@dayz_dayz_epoch_server" folder, open dayz_server.pbo

in your dayz_server.pbo open the server_monitor.sqf

Add

                if (count _worldspace < 3) then
                {
                        _worldspace set [count _worldspace, "0"];
                };             


                _ownerPUID = _worldspace select 2;		
				
				
ABOVE

                if (_damage < 1) then {
				
-----------------------------------------------------------------------------------------------				
				
Add

               _object setVariable ["OwnerPUID", _ownerPUID, true];
			   
Below

               _object setVariable ["lastUpdate",time];
			   _object setVariable ["ObjectID", _idKey, true];			   
                
______________________________________________________________________________________________
                 SERVER FILES
				 
at your "@dayz_dayz_epoch_server" folder, open dayz_server.pbo

in your dayz_server.pbo open the server_publishVehicle2.sqf

add

                 _ownerPUID = _worldspace select 2;
				 
BELOW
  
                 _dir = 		_worldspace select 0;
                 _location = _worldspace select 1;

------------------------------------------------------------------------------------------------
				 
add
                _ownerPUID
				
				
to this array:

          // Switched to spawn so we can wait a bit for the ID
         [_object,_uid,_characterID,_class,_dir,_location,_donotusekey,_activatingPlayer] spawn {				
                 

			 
----------------------------------------------------------------------------------------------------	
				 
add
        
                _ownerPUID = _this select 8;	

BELOW

                _donotusekey = _this select 6;
                _activatingPlayer = _this select 7;				


------------------------------------------------------------------------------------------------------				
				 
add

                _object setVariable ["OwnerPUID",_ownerPUID,true];

BELOW

                _object setVariable ["CharacterID", _characterID, true];				


		
		for details see serverfile samples	
		
		
		you are done ;)