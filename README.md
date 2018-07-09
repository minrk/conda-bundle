# conda-bundler

Lightweight alternative to [conda constructor](https://github.com/conda/constructor).

Conda constructor is great! But it has the following critical limitations:

- doesn't support noarch packages
- doesn't support pip installs

which we need for [the littlest jupyterhub](https://github.com/yuvipanda/the-littlest-jupyterhub).

This is a simpler version of constructor (that actually relies on the constructor-build miniconda installers) with very basic goals:

- record the results of `conda env create -f environment.yml`
- pack up the results (conda packages and pip wheels)
- bundle them up in a directory with an installer script

The result should be a directory you can pack up and distribute for single-command offline installation.

To pack up an environment:

    conda-bundle environment.yml
    tar -czvf bundle.tar.gz bundle/ 

On the destination:

    # get bundle.tar.gz
    tar -xzf bundle.tar.gz
    ./bundle/install

