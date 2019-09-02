{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  kbookmarks, kcompletion, kconfig, kconfigwidgets, kcoreaddons, kguiaddons,
  ki18n, kiconthemes, kinit, kdelibs4support, kio, knotifications,
  knotifyconfig, kparts, kpty, kservice, ktextwidgets, kwidgetsaddons,
  kwindowsystem, kxmlgui, qtscript, knewstuff
}:

mkDerivation {
  name = "konsole";
  meta = {
    license = with lib.licenses; [ gpl2 lgpl21 fdl12 ];
    maintainers = [ lib.maintainers.ttuegel ];
  };
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  buildInputs = [
    kbookmarks kcompletion kconfig kconfigwidgets kcoreaddons kdelibs4support
    kguiaddons ki18n kiconthemes kinit kio knotifications knotifyconfig kparts kpty
    kservice ktextwidgets kwidgetsaddons kwindowsystem kxmlgui qtscript knewstuff
  ];

  propagatedUserEnvPkgs = [ (lib.getBin kinit) ];

  patches = [
    ./konsole-focus-right-tab-on-close.patch
  ];
  postPatch = ''
    # Use a more visible color to indicate tab activity
    sed -i -r 's/const QColor activityColor = .*/const QColor activityColor = QColor(209, 25, 25);/g' src/ViewContainer.cpp
  '';

  enableParallelBuilding = true;
}
