{ config, ... }:

{
  sops = {
    # 1. Define the source secret
    secrets.wakatime_api_key = { };

    # 2. Define the template
    templates."wakatime" = {
      content = ''
        [settings]
        api_key = ${config.sops.placeholder.wakatime_api_key}
      '';
    };
  };

  # 3. Symlink the dotfile to the rendered template
  home.file.".wakatime.cfg".source =
    config.lib.file.mkOutOfStoreSymlink
      config.sops.templates."wakatime".path;
}
