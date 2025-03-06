{
	programs.nixvim = { 
		plugins.flutter-tools = { 
			enable = true;
			settings = {
				widget_guides = {
					enabled = true;
				};
			};
		};
	};
}
