{
  src ? ./.,
  stdenvNoCC,
  gtk-engine-murrine,
  sass,
  coreutils
}:

stdenvNoCC.mkDerivation {
  pname = "everblush-gtk";
  name = "everblush-gtk";
  src = src;

  propagatedUserEnvPkgs = [ gtk-engine-murrine ];
  nativeBuildInputs = [ sass coreutils ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/themes/Everblush/gtk-3.0
    sass $src/gtk-3.0/gtk.scss $out/share/themes/Everblush/gtk-3.0/gtk.css
    install -v -d $out/share/themes/Everblush
    install -m 0644 -v $src/index.theme $out/share/themes/Everblush
    cp -rv $src/assets $src/gtk-2.0 $out/share/themes/Everblush
  '';

/*
  meta = with lib; {
    description = "A GTK theme with the Everblush colour palette";
    homepage = "https://github.com/Everblush/gtk";
    licenes = licenses.mit;
    platforms = platforms.unix;
  };
*/
}
