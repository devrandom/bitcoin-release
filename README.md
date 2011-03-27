# Bitcoin Releases

This directory contains bitcoin Gitian build results, signed by multiple people.

The layout of this directory is:

    <release-name>/
      <signer>/
        bitcoin-res.yml - the result file produced by the signer's build process
        signature.pgp - the signer's signature certifying the result

Normally, all output manifests in the result files should be identical between different signers.

See also:

* [Bitcoin](https://www.bitcoin.org/)
* [Gitian builder](https://github.com/devrandom/gitian-builder)
