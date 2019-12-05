{
  mkDerivation, lib, fetchpatch,
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

    # konsole 19.08.1 -> 19.08.2 introduced some bad hidpi scaling changes
    # that introduced space between lines and also made it impossible to use
    # a decimal size e.g. 9.5pt font.
    (fetchpatch {
      url = "https://github.com/KDE/konsole/commit/54820e0ff2745add8b8353f538ad67d66b657d49.patch";
      sha256 = "1qi1cxvlm5nh58mpdsbcn8vkkfgz7f42an51kvd7bbzhmj8z8y2c";
      revert = true;
    })
    (fetchpatch {
      url = "https://github.com/KDE/konsole/commit/36cd1aa267cf616d8135e38f4da7e4142f64059a.patch";
      sha256 = "1z62qhxcn1857i6nkwmj07qxir331b440pvfbfcnl4l08gnh4k3y";
      revert = true;
    })
    (fetchpatch {
      url = "https://github.com/KDE/konsole/commit/a3bc2f9667696a37b291852a2df851433cc4377b.patch";
      sha256 = "0qq1xik3p0gjf5xxsqyrv53dy7lv5wnff2q4wicairhar1h3dcmg";
      revert = true;
    })
  ];
  postPatch = ''
    # Use a more visible color to indicate tab activity
    sed -i -r 's/const QColor activityColor = .*/const QColor activityColor = QColor(209, 25, 25);/g' src/ViewContainer.cpp
  '';

  enableParallelBuilding = true;
}
