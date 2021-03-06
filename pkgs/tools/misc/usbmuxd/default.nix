{ stdenv, fetchFromGitHub, autoreconfHook, pkgconfig, libusb1, libimobiledevice }:

stdenv.mkDerivation rec {
  pname = "usbmuxd";
  version = "2018-10-10";

  src = fetchFromGitHub {
    owner = "libimobiledevice";
    repo = pname;
    rev = "96e4aabe0b9a46ea9da4955a10c774a8e58fe677";
    sha256 = "03xnj4y606adbhl829vv46qa78f6w2ik4mjz19a34x9lhkcrqxqi";
  };

  nativeBuildInputs = [ autoreconfHook pkgconfig ];
  propagatedBuildInputs = [ libimobiledevice libusb1 ];

  preConfigure = ''
    configureFlags="$configureFlags --with-udevrulesdir=$out/lib/udev/rules.d"
    configureFlags="$configureFlags --with-systemdsystemunitdir=$out/lib/systemd/system"
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/libimobiledevice/usbmuxd;
    description = "A socket daemon to multiplex connections from and to iOS devices";
    longDescription = ''
      usbmuxd stands for "USB multiplexing daemon". This daemon is in charge of
      multiplexing connections over USB to an iOS device. To users, it means
      you can sync your music, contacts, photos, etc. over USB. To developers, it
      means you can connect to any listening localhost socket on the device. usbmuxd
      is not used for tethering data transfer which uses a dedicated USB interface as
      a virtual network device. Multiple connections to different TCP ports can happen
      in parallel. The higher-level layers are handled by libimobiledevice.
    '';
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
