{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage {
  pname = "prettier-plugin-svelte";
  version = "3.2.5";

  src = fetchFromGitHub {
    owner = "sveltejs";
    repo = "prettier-plugin-svelte";
    rev = "d2c680c016195f876c54c39a817bc57418b15ef7";
    hash = "sha256-Odaw435tsFUA3kWzOhVshTwhQCtqP3eTb3RBI89qsxI=";
  };

  # This is a common requirement for plugins which don't have a build script
  dontNpmBuild = true;
  npmDepsHash = "sha256-yxGdOZlS2xWktsSX2a4A9OiWFrK+entn5oroSSgedKk=";

  meta = {
    description = "A Prettier plugin for Svelte v3, v4, and v5 components";
    homepage = "https://github.com/sveltejs/prettier-plugin-svelte";
  };
}
