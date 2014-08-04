keyAD
=====

destroy vehicle remotly(if key is present) via any item configured in extraRc.hpp



KeyAD needs extraRC installed to work!!!


install:

just copy the "keyAD" into the root directory of yourmissionfile.pbo



in your extraRC.hpp add :

  class menuItem2 {
    text = "Vehicle Remote Menu";
	script = "[] execVM 'keyAD\keys.sqf'";
 };
 
 
 to any Item you want, as seen in the sample extraRC.hpp
