class KeyADHud_Rsc
{
	idd = -1;
	movingEnable = 1;
	enableSimulation = 1;
	enableDisplay = 1;

	onLoad = "uiNamespace setVariable ['keyAD_Hud_Disp',_this select 0];";

	duration = 180;
	fadein  = 0;
	fadeout = 0;
	class controls
	{
		class Icons : w_RscStructuredText
		{
		idc = -1;
		style = 0x00;
		x = 0.9;
		y = 0.9;
		w = 0.9;
		h = 0.9;
		size = 0.08;
		colorBackground[] = {0,0,0,0};
		colortext[] = {0,0,0,0.7};
		text ="";
			class Attributes {
			align = "left";
			};		
		};
	class PlayerIcon00:Icons {idc = 73311 + 0;};
		
	};
};