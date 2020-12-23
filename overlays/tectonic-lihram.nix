self: super:
let
  version = "0.3.3";
in {
  tectonic-lihram = super.tectonic.overrideAttrs (old: {
    src = super.fetchFromGitHub {
        owner = "tectonic-typesetting";
        repo = "tectonic";
        rev = "tectonic@${version}";
        sha256 = "1ncczcchyphprkrb8spya400gi212a6akx18fm3j4xdhmg9caj3f";
    };

    cargoSha256 = "0000000000000000000000000000000000000000000000000000";
  });
}

