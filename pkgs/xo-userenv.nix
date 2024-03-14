{
  # nixpkgs dependencies
  buildFHSUserEnv, # ... other deps here

  # xo dependencies
  xo-cmake, xo-indentlog, xo-subsys, xo-refcnt, xo-randomgen, xo-ordinaltree, xo-pyutil, xo-reflect, xo-pyreflect,
  xo-printjson, xo-pyprintjson, xo-callback, xo-webutil, xo-pywebutil, xo-reactor, xo-pyreactor, xo-simulator,
  xo-distribution, xo-pydistribution, xo-process, xo-pyprocess, xo-statistics, xo-kalmanfilter,
  xo-pykalmanfilter, xo-websock, xo-pywebsock,

  # other args

  # someconfigurationoption ? false
} :

buildFHSUserEnv {
  name = "xo-userenv";
  targetPkgs = pkgs: [ xo-cmake
                       xo-indentlog
                       xo-subsys
                       xo-refcnt
                       xo-randomgen
                       xo-ordinaltree
                       xo-pyutil
                       xo-reflect
                       xo-pyreflect
                       xo-printjson
                       xo-pyprintjson
                       xo-callback
                       xo-webutil
                       xo-pywebutil
                       xo-reactor
                       xo-pyreactor
                       xo-simulator
                       xo-distribution
                       xo-pydistribution
                       xo-process
                       xo-pyprocess
                       xo-statistics
                       xo-kalmanfilter
                       xo-pykalmanfilter
                       xo-websock
                       xo-pywebsock
                     ];
  # runScript = ...;
  # profile = ...;
}
