import os
import ctypes
import numpy as np


lib_path = os.path.join(
    os.path.dirname(__file__),
    "lib",
    "libpycopa.so")

pycopa_c = ctypes.CDLL(lib_path)

CALLBACKTYPE_func_c = ctypes.CFUNCTYPE(
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double))

run_sampler_c = getattr(
    pycopa_c,
    "pycopa__sampler_run_sampler_c")

run_sampler_c.argtypes = [
    ctypes.c_int,
    CALLBACKTYPE_func_c,
    CALLBACKTYPE_func_c,
    ctypes.POINTER(ctypes.c_double),
    ctypes.POINTER(ctypes.c_double),
    ctypes.c_int,
    ctypes.c_int,
    ctypes.POINTER(ctypes.c_double),
    ctypes.POINTER(ctypes.c_double),
    ctypes.POINTER(ctypes.c_double)]
run_sampler_c.restype = None

def run_sampler(
        ndim, log_prior, log_like,
        lower_lims, upper_lims,
        nwalkers=50, nsteps=1000):
    ndim_c = ctypes.c_int(ndim)
    def log_prior_ptr(x_ptr):
        x = np.ctypeslib.as_array(x_ptr, shape=(ndim, ))
        return log_prior(x)
    log_prior_c = CALLBACKTYPE_func_c(log_prior_ptr)
    def log_like_ptr(x_ptr):
        x = np.ctypeslib.as_array(x_ptr, shape=(ndim, ))
        return log_like(x)
    log_like_c = CALLBACKTYPE_func_c(log_like_ptr)
    lower_lims = np.array(lower_lims, dtype=np.float64)
    lower_lims_c = lower_lims.ctypes.data_as(
        ctypes.POINTER(ctypes.c_double))
    upper_lims = np.array(upper_lims, dtype=np.float64)
    upper_lims_c = upper_lims.ctypes.data_as(
        ctypes.POINTER(ctypes.c_double))
    nwalkers_c = ctypes.c_int(nwalkers)
    nsteps_c = ctypes.c_int(nsteps)
    walkers = np.empty(
        (ndim, nwalkers),
        dtype=np.float64,
        order='F')
    walkers_c = walkers.ctypes.data_as(
        ctypes.POINTER(ctypes.c_double))
    chains = np.empty(
        (ndim, nwalkers, nsteps),
        dtype=np.float64,
        order='F')
    chains_c = chains.ctypes.data_as(
        ctypes.POINTER(ctypes.c_double))
    log_probs = np.empty(
        (nwalkers, nsteps),
        dtype=np.float64,
        order='F')
    log_probs_c = log_probs.ctypes.data_as(
        ctypes.POINTER(ctypes.c_double))
    run_sampler_c(
        ndim_c, log_prior_c, log_like_c,
        lower_lims_c, upper_lims_c,
        nwalkers_c, nsteps_c,
        walkers_c, chains_c, log_probs_c)
    return walkers, chains, log_probs

