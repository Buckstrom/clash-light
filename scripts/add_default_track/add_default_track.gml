function add_default_track(track){
	var _output = load_csv("clashlight_wep_default - " + track + ".csv");
	//CSV to DS grid
	//y =
	//0 : name (string)
	//1 : strength [damage / turns] (real)
	//2 : accuracy (real, 0-100 range)
	//3 : capacity (real; typically 30,25,20,15,7,3,2,1)
	//4 : target (real; 0 = single, 1 = all)
	//5 : factor [debuff turns] (real)
	return _output;
}