{
  # nixpkgs dependencies
  buildFHSUserEnv, # ... other deps here

  # xo dependencies
  xo-cmake, xo-indentlog, xo-subsys, xo-refcnt, xo-randomgen, xo-ordinaltree, xo-reflectutil,
  xo-ratio, xo-pyutil, xo-reflect, xo-pyreflect,
  xo-printjson, xo-pyprintjson, xo-callback, xo-webutil, xo-pywebutil, xo-reactor, xo-pyreactor, xo-simulator,
  xo-pysimulator, xo-distribution, xo-pydistribution, xo-process, xo-pyprocess, xo-statistics, xo-kalmanfilter,
  xo-pykalmanfilter, xo-websock, xo-pywebsock, xo-tokenizer, xo-expression, xo-pyexpression, xo-reader

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
                       xo-reflectutil
                       xo-ratio
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
                       xo-pysimulator
                       xo-distribution
                       xo-pydistribution
                       xo-process
                       xo-pyprocess
                       xo-statistics
                       xo-kalmanfilter
                       xo-pykalmanfilter
                       xo-websock
                       xo-pywebsock
                       xo-tokenizer
                       xo-expression
                       xo-pyexpression
                       xo-reader
                     ];
  # runScript = ...;
  # profile = ...;
}
