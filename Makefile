PC = python

pycopa-debug:
	fpm @install-gfortran-debug install --prefix=./python/pycopa/
	cd python && $(PC) -m pip install -e .
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' libpycopa.so
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' libcopa.so
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' libevortran.so
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' liberror-handling.so

pycopa:
	fpm @install-gfortran-run install --prefix=./python/pycopa/
	cd python && $(PC) -m pip install -e .
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' libpycopa.so
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' libcopa.so
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' libevortran.so
	cd python/pycopa/lib && patchelf --set-rpath '$$ORIGIN' liberror-handling.so

clean:
	$(PC) -m pip uninstall pycopa
	rm -rf build
	rm -rf python/pycopa/bin
	rm -rf python/pycopa/lib
	rm -rf python/pycopa/include
