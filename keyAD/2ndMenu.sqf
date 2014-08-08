

keysInInv = _this select 0;
_keyIdArr = _this select 1;

_totalKeys = count keysInInv;



_whichAction = _this select 2;

_dispNameArr = [];
{
  _keyName = getText(configFile >> "CfgWeapons" >> _x >> "displayName");
  _dispNameArr set [(count _dispNameArr),_keyName];

} forEach keysInInv;


	if (_totalKeys > 0) then {
	   
	    findDisplay 106 closeDisplay 3000;
	   	cutText [format["Please scroll and choose a Key!"], "PLAIN DOWN"];
		
	       keyAD_menu2 = [
	       ["",true],
	       ["-- KeyAD Find Menu --", [], "", -5, [["expression", ""]], "1", "0"],
	       ["", [-1], "", -5, [["expression", ""]], "1", "0"]
	       ];		
		
		
		
		if (_whichAction > 1) then {
	       keyAD_menu2 = [
	       ["",true],
	       ["-- KeyAD BOOM Menu --", [], "", -5, [["expression", ""]], "1", "0"],
	       ["", [-1], "", -5, [["expression", ""]], "1", "0"]
	       ];
           };

	 
	   _counter = -1;   
	   for "_i" from 1 to _totalKeys do {
	    
	        _counter = _counter + 1;
			_display = _dispNameArr select _counter;
			
						
			_keyID   = _keyIdArr select _counter;
				
					        
			if (_whichAction > 1) then {
			
			
			
			   _string = format ['[%1,2,%2] execVM "keyAD\autoDestruct.sqf"',_keyID,_counter];
			
		       _action = [format["%1", _display], [],"",-5,[["expression",_string]],"1","1"];
		       keyAD_menu2 set [(count keyAD_menu2),_action];
		    
			} else {
			
			   _string = format ['[%1,1,%2] execVM "keyAD\autoDestruct.sqf"',_keyID, _counter];
		       _action = [format["%1", _display], [],"",-5,[["expression",_string]],"1","1"];
               keyAD_menu2 set [(count keyAD_menu2),_action];
			};			
	    };
		_action = ["", [-1], "", -5, [["expression", ""]], "1", "0"];
		keyAD_menu2 set [(count keyAD_menu2),_action];
		_action = [format["EXIT"], [],"",-5,[],"1","1"];
	    keyAD_menu2 set [(count keyAD_menu2),_action];
	    
	  showCommandingMenu "#USER:keyAD_menu2";
		
	};	
		
