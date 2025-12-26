![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
[![Language](https://img.shields.io/badge/-Fortran-734f96?logo=fortran&logoColor=white)](https://github.com/topics/fortran)
[![arXiv](https://img.shields.io/badge/arXiv-2507.06082-b31b1b.svg)](https://arxiv.org/abs/2507.06082)
[![last-commit](https://img.shields.io/github/last-commit/thomasbiekoetter/copa)](https://github.com/thomasbiekoetter/copa/commits/master)

# pycopa — Python bindings for **copa**

**pycopa** is a thin, user-friendly Python wrapper around the Fortran **copa** library. It exposes copa’s ensemble MCMC samplers and convenient I/O helpers to the Python ecosystem so you can:

- call copa samplers from Python,
- read / write the binary chain outputs (NumPy-friendly `.npy` blobs),
- combine Fortran speed with NumPy / SciPy / plotting tools for analysis.

pycopa is intended for researchers and engineers who want to run copa’s high-performance samplers from Python (for example inside notebooks, pipelines, or analysis scripts).

## 📜 License and Citation

**pycopa** is licensed under the **GNU General Public License v3 (GPLv3)**.

If you use copa in academic work, please cite the accompanying paper on **evortran**:

> T. Biekötter, *evortran: a modern Fortran package for genetic algorithms with applications from LHC data fitting to LISA signal reconstruction*, [arXiv:2507.06082](https://arxiv.org/abs/2507.06082)

```bibtex
@article{Biekotter:2025gkp,
    author = {Biek{\"o}tter, Thomas},
    title = "{evortran: a modern Fortran package for genetic algorithms with applications from LHC data fitting to LISA signal reconstruction}",
    eprint = "2507.06082",
    archivePrefix = "arXiv",
    primaryClass = "hep-ph",
    reportNumber = "IFT-UAM/CSIC-25-76",
    month = "7",
    year = "2025"
}
```

## Installation

**Prerequisites**
- The `gfortran` Fortran compiler.
- [Fortran Package Manager (fpm)](https://github.com/fortran-lang/fpm) version **≥ 0.12.0** available on `PATH`.
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
cd python/test
python rosenbrock.py
```
This program samples the two-dimensional Rosenbrock function. The MCMC chains and the final walkers at completion are stored in the numpy arrays `chains` and `walkers`, respectively.



