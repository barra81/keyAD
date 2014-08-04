class ExtraRc {


class ItemCompass {
  class menuItem1 {
    text = "Combine Bars";
	script = "[[],1] call epoch_returnChange ";  
 };
 
  class menuItem2 {
    text = "Vehicle Remote Menu";
	script = "[] execVM 'keyAD\keys.sqf'";
 };
}; 

class sandbag_nest_kit {
  class menuItem1 {
    text = "Build M240 Nest";
    script = "[""M240Nest_DZ"",[""ItemToolbox"",""ItemEtool"",""ItemCrowbar"",""ItemSledge""],[[""sandbag_nest_kit"",1],[""ItemComboLock"",1]],[0,2,1.2]] execVM ""sys\snap_pro\player_build.sqf"";";
  };
 };
 
 class ItemToolbox {
  class menuItem1 {
    text = "Deploy Bike";
    script = "execVM ""external\bike.sqf"";";
  };
 };
 
  class 30m_plot_kit {
  class menuItem1 {
    text = "Build Skeetmachine";
    script = "[""SkeetMachine"",[""ItemToolbox"",""ItemEtool"",""ItemCrowbar""],[[""ItemGenerator"",1],[""PartEngine"",1], [""ItemFuelBarrel"",2], [""30m_plot_kit"",1]],[0,1.5,0.4]] execVM ""sys\snap_pro\player_build.sqf"";";         //"execVM ""external\SkeetMachine.sqf"";";
  };
  class Infostand_2_EP1 {
    text = "Build RoofControlPanel";
	script = "[""Infostand_2_EP1"",[""ItemToolbox"",""ItemEtool"",""ItemCrowbar""],[[""30m_plot_kit"",1]],[0,1.5,0.6]] execVM ""sys\snap_pro\player_build.sqf""; execVM ""rcr\panelText.sqf""; ";      
 };
 };
 
 class light_pole_kit {
  class menuItem1 {
    text = "Build Illuminated Tower";
    script = "[""Land_Ind_IlluminantTower"",[""ItemToolbox"",""ItemEtool"",""ItemCrowbar"",""ItemSledge""],[[""light_pole_kit"",1],[""ItemGenerator"",1],[""ItemFuelBarrel"",1]],[0,3,10] ] execVM ""sys\snap_pro\player_build.sqf"";";
  };
 };
 class ItemRadio {
	class GroupManagement {
		text = "Group Management";
		script = "[] execVM 'dzgm\loadGroupManagement.sqf'";
	};
	class menuItem1 {
		text = "Switch Roof";
		script = "[] execVM 'rcr\rCr_openUI.sqf'";
	};
 };
 
 class metal_floor_kit {
    class menuItem1 {
	    text = "Build HeliRoof";
		script = "[""MAP_Ind_Shed_01_main"",[""ItemToolbox"",""ItemEtool"",""ItemCrowbar"",""ItemSledge""],[[""metal_floor_kit"",2]],[0,2,7]] execVM ""sys\snap_pro\player_build.sqf"";";
 
};
};
};