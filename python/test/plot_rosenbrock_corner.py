import numpy as np
import matplotlib.pyplot as plt
import getdist
from getdist import plots


ndim = 2
nwalkers = 50
nsteps = 1000

burn_in = 1000

samples = np.load("chains.npy")
samples = samples.reshape((ndim, nwalkers * nsteps)).T
samples = samples[burn_in:-1, :]
samples = getdist.MCSamples(
    samples=samples,
    names=['x', 'y'],
    labels=['x', 'y'])

g = plots.get_subplot_plotter()
g.triangle_plot(
    [samples],
    ["x", "y"],
    filled=True)

g.export("rosenbrock_corner.pdf")

