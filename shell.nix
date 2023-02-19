{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    asciidoctor
    libreoffice
    kicad-small
    inkscape
  ];
}
