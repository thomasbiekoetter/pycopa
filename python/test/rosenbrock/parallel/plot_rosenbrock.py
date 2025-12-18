import numpy as np
import matplotlib.pyplot as plt
import matplotlib


ndim = 2
nwalkers = 50
nthreads = 4
nsteps = int(1000 / nthreads)

burn_in = 1000

samples = np.load("chains.npy")
samples = samples.reshape((ndim, nwalkers * nsteps * nthreads))
samples = samples[:, burn_in:-1]

log_probs = np.load("log_probs.npy")
log_probs = log_probs.reshape((nwalkers * nsteps * nthreads))
log_probs = log_probs[burn_in:-1]


fig, ax = plt.subplots()

sc = ax.scatter(
    samples[0, :],
    samples[1, :],
    c=-log_probs,
    s=4,
    norm=matplotlib.colors.LogNorm(),
    rasterized=True)
fig.colorbar(sc)

plt.savefig("rosenbrock.pdf")

