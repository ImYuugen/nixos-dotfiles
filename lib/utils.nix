{ lib, ... }:

let
  inherit (builtins) attrValues readFile;
  inherit (lib) concatStringsSep filterAttrs fold isAttrs mapAttrs' mkOption types;
in rec {
  mapFilterAttrs = pred: f: attrs: filterAttrs pred (mapAttrs' f attrs);
  attrValuesRec = attr: fold (x: xs: (if isAttrs x then attrValuesRec x else [x]) ++ xs) [] (attrValues attr);
  filterSelf = attr: filterAttrs (n: _: n != "self") attr;
  joinWithSep = list: sep: concatStringsSep sep (map toString list);
  configWithExtras = path: extras: "${readFile path}\n${extras}";
  enable = { enable = true; };

  mkOpt = type: default: description: mkOption { inherit type default description; };
  mkOpt' = type: default: mkOpt type default null;
  mkBoolOpt = default: mkOpt' types.bool default;
}
