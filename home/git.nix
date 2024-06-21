{
	programs.lazygit = {
		enable = true;
	};

	programs.git = {
    enable = true;
    userName = "masoniis";
    userEmail = "bott.m@comcast.net";
    extraConfig = {
      credential = {
        helper = "store";
      };
			sendemail = {
					smtpserver = "smtp.gmail.com";
					smtpuser = "masonmbott@gmail.com";
					smtpencryption = "tls";
					smtpserverport = 587;
			};
			merge = {
				tool = "nvimdiff2";
			};
    };
	};
}
