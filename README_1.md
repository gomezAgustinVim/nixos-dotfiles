# Introducción

Este repositorio contiene mis mismos dotfiles que ya están declarando en [otro de mis repos](https://github.com/gomezAgustinVim/duandotfiles) con la diferencia de que esta configuración estará escrita exclusivamente para utilizar en la distro **NixOS**, aprovechando las ventajas de tener una configuración completamente declarativa, escrita en el lenguaje nix.

Debería ser utilizable en el estado en el que está ahora, aunque apenas. Ha de notarse que
hay varias configuraciones mías referenciadas en home.nix las cuales he decidido no subir
al repositorio debido a que sería redundante, pues esas configuraciones aún no están
escritas declarativamente con nix.

Todos los paquetes utilizarán la versión estable de NixOS a no ser que sea necesario
especificar una versión inestable para **un paquete** en concreto.

## Objetivos

- Modularizar toda la configuración de home manager para que no sea una mezcla de
configuraciones de distintos programas que no tienen nada que ver.
- Reescribir todas mis configuraciones en nix
