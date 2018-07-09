# conda-bundler

Lightweight alternative to [conda constructor](https://github.com/conda/constructor).

Conda constructor is great! But it has the following critical limitations:

- doesn't support noarch packages
- doesn't support pip installs
- may not work with non-default channels (we need conda-forge to be enabled by default)

which we need for [the littlest jupyterhub](https://github.com/yuvipanda/the-littlest-jupyterhub).

This is a simpler version of constructor (that actually relies on the constructor-built miniconda installers) with very basic goals:

- rely on existing bootstrap of conda itself, to eliminate any limitations relative to `conda install`
- record the results of `conda env create -f environment.yml`
- pack up the results (conda packages and pip wheels)
- bundle them up in a directory with an installer script

The result should be a directory you can pack up and distribute for single-command offline installation.

To pack up an environment spec:

    conda-bundle environment.yml
    # creates bundle.tar.gz

On the destination:

    # get bundle.tar.gz
    tar -xzf bundle.tar.gz
    ./bundle/install

Downsides relative to conda-constructor:

- can include duplicate packages for a bit of wasted space (e.g. python will usually be bundled twice, once in the miniconda installer and again in the environment bundle)
- relies on existing miniconda installers to bootstrap conda itself
