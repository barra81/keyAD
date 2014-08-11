
_weaponsArr = weapons player;
_keyString = "ItemKey";


_keyPosInInv = [];
{   
  _string =[_x,7] call KRON_StrLeft;               //needs Kron-String functions installed
  
  
  if (_string == _keyString) then { 
  _keyPos = _forEachIndex;
    
  _keyPosInInv set [(count _keyPosInInv), _keyPos];

  };
  
}forEach _weaponsArr;



_keyPosCount = count _keyPosInInv;
_keysInInv = [];

if (_keyPosCount > 0) then {

    _counter = -1;
    for "_i" from 1 to _keyposCount do {
         _counter = _counter + 1;

         _selector = _keyPosInInv select _counter;
		 _key = _weaponsArr select _selector;
		 _keysInInv set [(count _keysInInv),_key];
    };
	
	
	If ("ItemKeyKit" in _keysInInv) then {
	
	
	_keysInInv = _keysInInv - ["ItemKeyKit"];
	
	};
	

	
	 _KeyIdArr = [];
	{
		
	  _KeyId = getNumber(configFile >> "CfgWeapons" >> _x >> "keyid");
				
	  _KeyIdArr set [(count _KeyIdArr), _KeyId];
		
	} forEach _keysInInv;
	
	[_keysInInv, _keyIdArr] execVM "keyAD\key_menu.sqf";
	
} else {

cutText [format["You dont have any Keys to convert!"], "PLAIN"];

};

















