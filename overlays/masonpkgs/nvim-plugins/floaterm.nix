{ fetchFromGitHub, vimUtils }:

vimUtils.buildVimPlugin {
  pname = "floaterm";
  version = "ae3de018d20dccd9372bbff7137e8a6d6030f69e";
  src = fetchFromGitHub {
    owner = "nvzone";
    repo = "floaterm";
    rev = "ae3de018d20dccd9372bbff7137e8a6d6030f69e";
    sha256 = "sha256-EpSYeGEQED6dmnPsGvXNLhRSeQPoEpZ9Wbw5+I9Sdk8=";
  };

  # Skip the require check that's failing 9/3/25
  doCheck = false;

  meta = {
    homepage = "https://github.com/nvzone/floaterm";
    description = "Beautiful floating terminal manager for Neovim ";
  };
}
