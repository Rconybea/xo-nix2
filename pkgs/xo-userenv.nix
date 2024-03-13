{
  # nixpkgs dependencies
  buildFHSUserEnv, # ... other deps here

  # xo dependencies
  xo-cmake, xo-indentlog

  # other args

  # someconfigurationoption ? false
} :

buildFHSUserEnv {
  name = "xo-userenv";
  targetPkgs = pkgs: [ xo-cmake xo-indentlog ];
  # runScript = ...;
  # profile = ...;
}
