_totalKeys = _this select 3 select 0;

_counter = -1;
for "_i" from 1 to _totalKeys do {
_counter = _counter + 1;
_menu = dayz_menu select _counter;
player removeAction _menu;
};
player removeAction keyAD_exit;