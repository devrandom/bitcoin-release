# Bitcoin Releases

This directory contains bitcoin Gitian build results, signed by multiple people.

The layout of this directory is:

    <release-name>/
      <signer>/
        bitcoin-build.assert - the result file produced by the signer's build process
        bitcoin-build.assert.sig - the signer's signature certifying the result

This directory is created by the Gitian `gsign` command, after a successful `gbuild`.  It can be verified with `gverify`.

Normally, all output manifests in the result files should be identical between different signers.

See also:

* docs/build.sh
* [Bitcoin](https://www.bitcoin.org/)
* [Gitian builder](https://github.com/devrandom/gitian-builder)
