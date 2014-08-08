keysInInv = _this select 0;
keyIdArr = _this select 1;
_totalKeys = count keysInInv;


	if (_totalKeys > 0) then {
	   
	    findDisplay 106 closeDisplay 3000;
	    
	  keyAD_menu1 = [
	  ["",true],
	  ["-- KeyAD Action Menu --", [], "", -5, [["expression", ""]], "1", "0"],
	  ["", [-1], "", -5, [["expression", ""]], "1", "0"],
	  ["Find Vehicle",[],"",-5,[["expression",'[keysInInv,keyIdArr,1] execVM "keyAD\2ndMenu.sqf"']],"1","1"],
	  ["Destroy Vehicle",[],"",-5,[["expression",'[keysInInv,keyIdArr,2] execVM "keyAD\2ndMenu.sqf"']],"1","1"],
	  ["", [-1], "", -5, [["expression", ""]], "1", "0"],
	  ["EXIT",[],"",-5,[],"1","1"]
	  ];
	  showCommandingMenu "#USER:keyAD_menu1";

	   cutText [format["Please choose a Vehicle action!"], "PLAIN DOWN"];
    } else {
	
	   cutText [format["You must have, any Keys in your Inventory to use an action!"],"PLAIN"];
	};   