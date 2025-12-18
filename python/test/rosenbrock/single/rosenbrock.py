import numpy as np
from pycopa.sampler import run_sampler


a = 1e0
b = 1e2
def rosenbrock(theta):
    x = theta[0]
    y = theta[1]
    return -((a - x) ** 2 + b * (y - x ** 2) ** 2)

def log_prior(x):
    if -2 <= x[0] <= 2 and -1 <= x[1] <= 3:
        return 0.0
    else:
        return -1e10

lower_lims = np.array([-2.0, -1.0])
upper_lims = np.array([2.0, 3.0])

walkers, chains, log_probs = run_sampler(
    2, log_prior, rosenbrock,
    lower_lims=lower_lims,
    upper_lims=upper_lims,
    nwalkers=50, nsteps=1000)

np.save("walkers.npy", walkers)
np.save("chains.npy", chains)
np.save("log_probs.npy", log_probs)
