{
	programs.lazygit = {
		enable = true;
	};

	programs.git = {
    enable = true;
    userName = "your_username";
    userEmail = "your_email@example.com";
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
    };
	};
}
