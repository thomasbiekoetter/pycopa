[![python](https://img.shields.io/badge/Python-3.9-3776AB.svg?style=flat&logo=python&logoColor=white)](https://www.python.org)
[![Language](https://img.shields.io/badge/-Fortran-734f96?logo=fortran&logoColor=white)](https://github.com/topics/fortran)
[![DOI](https://img.shields.io/badge/doi-10.21468/SciPostPhysCodeb.64-darkblue.svg)](https://scipost.org/SciPostPhysCodeb.64)
[![arXiv](https://img.shields.io/badge/arXiv-2507.06082-b31b1b.svg)](https://arxiv.org/abs/2507.06082)
[![last-commit](https://img.shields.io/github/last-commit/thomasbiekoetter/copa)](https://github.com/thomasbiekoetter/pycopa/commits/master)

# pycopa — Python bindings for **copa**

**pycopa** is a thin, user-friendly Python wrapper around the Fortran **copa** library. It exposes copa’s ensemble MCMC samplers and convenient I/O helpers to the Python ecosystem so you can:

- call copa samplers from Python,
- read / write the binary chain outputs (NumPy-friendly `.npy` blobs),
- combine Fortran speed with NumPy / SciPy / plotting tools for analysis.

pycopa is intended for researchers and engineers who want to run copa’s high-performance samplers from Python (for example inside notebooks, pipelines, or analysis scripts).

## **copa – Fortran Backend**

**pycopa** is built on top of the original Fortran **copa** library, which provides efficient implementations of ensemble Markov Chain Monte Carlo (MCMC) samplers. The underlying package is available via the Fortran Package Manager (fpm). See the repository: [copa](https://github.com/thomasbiekoetter/copa)

## 📜 License and Citation

**pycopa** is licensed under the **GNU General Public License v3 (GPLv3)**.

If you use copa in academic work, please cite the accompanying paper on **evortran**:

> [arXiv:2507.06082]: Thomas Biekötter (IFT, Madrid), *evortran: a modern Fortran package for genetic algorithms with applications from LHC data fitting to LISA signal reconstruction*, [SciPost Phys. Codebases 64 (2026)]

```bibtex
@article{Biekotter:2025gkp,
    author = {Biek{\"o}tter, Thomas},
    title = "{evortran: A modern Fortran package for genetic algorithms with applications from LHC data fitting to LISA signal reconstruction}",
    eprint = "2507.06082",
    archivePrefix = "arXiv",
    primaryClass = "hep-ph",
    reportNumber = "IFT-UAM/CSIC-25-76",
    doi = "10.21468/SciPostPhysCodeb.64",
    journal = "SciPost Phys. Codeb.",
    volume = "64",
    pages = "1",
    year = "2026"
}
```

## Installation

**Prerequisites**
- The `gfortran` Fortran compiler.
- [Fortran Package Manager (fpm)](https://github.com/fortran-lang/fpm) version **≥ 0.13.0** available on `PATH`.
- Python 3.6+ and `pip`.
- `make` (the provided Makefile target uses it).
- `patchelf` (used to embed rpaths into the installed wheel so users normally don't have to set `LD_LIBRARY_PATH`).

**Quick install (recommended)**

Clone the repository and navigate to the `pycopa` directory:
```bash
git clone https://github.com/thomasbiekoetter/pycopa.git
cd pycopa
```
Install the package with:
```bash
make pycopa
```

To force a rebuild:
```bash
make clean && make pycopa
```

**Install in debug mode (slower)**

pycopa can be installed in debug mode which contains additional runtime checks and without compiler optimizations:
```bash
make pycopa-debug
```

## Test and example program

pycopa includes an example program to demonstate the usage and to validate that the installation has been successful. To execute the example, navigate to the `python/test` folder and run the python script:
```bash
cd python/test/single
python rosenbrock.py
```
This program samples the two-dimensional Rosenbrock function. The MCMC chains and the final walkers at completion are stored in the numpy arrays `chains` and `walkers`, respectively.


[SciPost Phys. Codebases 64 (2026)]: https://scipost.org/SciPostPhysCodeb.64
