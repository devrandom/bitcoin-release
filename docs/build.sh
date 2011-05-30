# First run:
apt-get install apt-cacher python-vm-builder
vi /etc/default/apt-cacher # ensure autostart is enabled
sudo service apt-cacher start
# Note that apt-cacher caused some problems for me, you can also try apt-cacher-ng, making sure to set the listen address to 127.0.0.1 (which it for some reason doesn't do if you have IPv6 in some cases)

git clone git://github.com/TheBlueMatt/bitcoin.git
git clone git://github.com/devrandom/gitian-builder.git
mkdir gitian-builder/inputs
mkdir gitian-builder/sigs
git clone git://github.com/devrandom/bitcoin-release.git gitian-builder/sigs/bitcoin
wget 'http://miniupnp.tuxfamily.org/files/download.php?file=miniupnpc-1.5.tar.gz' -O gitian-builder/inputs/miniupnpc-1.5.tar.gz
wget 'http://downloads.sourceforge.net/project/wxwindows/2.9.1/wxWidgets-2.9.1.tar.bz2' -O gitian-builder/inputs/wxWidgets-2.9.1.tar.bz2

# These are only required for Win32 Cross compiling
wget 'http://downloads.sourceforge.net/project/boost/boost/1.43.0/boost_1_43_0.tar.bz2' -O gitian-builder/inputs/boost_1_43_0.tar.bz2
wget 'http://download.oracle.com/berkeley-db/db-4.7.25.NC.tar.gz' -O gitian-builder/inputs/db-4.7.25.NC.tar.gz
wget 'http://miniupnp.tuxfamily.org/files/download.php?file=upnpc-exe-win32-20110215.zip' -O gitian-builder/inputs/upnpc-exe-win32-20110215.zip
wget 'http://miniupnp.tuxfamily.org/files/download.php?file=miniupnpc-1.5.20110215.tar.gz' -O gitian-builder/inputs/miniupnpc-1.5.20110215.tar.gz
wget 'http://openssl.org/source/openssl-1.0.0d.tar.gz' -O gitian-builder/inputs/openssl-1.0.0d.tar.gz

cd gitian-builder
bin/make-base-vm --arch i386
bin/make-base-vm --arch amd64
cd ..

# To build for Linux
cd bitcoin
git pull
git checkout gitian0.3.22
cd ../gitian-builder
cp ../bitcoin/contrib/toplevel.* ./inputs/
git pull
./bin/gbuild --commit bitcoin=`cat sigs/bitcoin/0.3.22/commit` ../bitcoin/contrib/gitian.yml
./bin/gsign -r 0.3.22 -s NAMEORNICK ../bitcoin/contrib/gitian.yml # to sign as a builder
./bin/gverify -r 0.3.22 ../bitcoin/contrib/gitian.yml # to verify all reports with their signatures
cd ..

# To cross compile for Win32 (via MinGW)
cd bitcoin
git checkout crosscompile
cd ../gitian-builder
cp ../bitcoin/src/makefile.linux-mingw inputs/
git pull
./bin/gbuild --commit bitcoin=`cat sigs/bitcoin/0.3.22/commit` ../bitcoin/contrib/gitian-win32.yml
# see linux section for sign and verify
cd ..
