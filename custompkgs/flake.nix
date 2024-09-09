{
	description = "A flake for all my custom packages and flakes";


	# For any external flakes, I think I will load them here and cherry-pick packages out of them.
	# For example, jerry may be like this:
	# inputs.jerryFlake.url = "github:justchokingaround/jerry";
	# outputs = {jerryFlake} : {
	# 	packages = {
	# 		jerry = jerryFlake.packages.jerry; 
	# 	};
	# };

	outputs = {} : {};
}
