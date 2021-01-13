#macro mAPPEAR_COORDS x - (appear_width / 2), y - (appear_height / 2), x + (appear_width / 2), y + (appear_height / 2)

inventory = ds_map_create();
reg_space = 0;
/* inventory:
each key is named after a track and contains this party member's track data in a DS grid
the member's track level is represented by the grid width
each column represents a weapon, each row determines its stats:
0 = quantity
1 = dmgbonus
2 = dmgpenalty
3 = special
*/
ownedtracks = ds_list_create();

isHovering = false;