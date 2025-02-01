---
title: Direct Ptychography
label: direct_ptycho_page
numbering:
  enumerator: 12.%s
---

Electron ptychography, first proposed by Walter Hoppe in 1969 [@10.1107/S0567739469001045], is a powerful phase-retrieval technique which can achieve resolution beyond the "information limit" [@10.1038/374630a0].
Ptychographic methods are usually grouped in "direct" methods, which include single side band (SSB), and Wigner distribution deconvolution (WDD), which attempt to deconvolve the effects of the probe from the 4D-STEM dataset, and iterative model-based inversion methods.
We focus on the former in this section, and describe iterative methods in [](#iterative_ptycho_page).

## Single Side Band Ptychography

The first step in direct ptychographic methods is taking a Fourier transform over the real-space scan positions to form the complex-valued dataset $G_{Q_x,Q_y}(K_x,K_y) = \mathcal{F}_{\bm{R}\rightarrow \bm{Q}}\left[M_{R_x,R_y}(K_x,K_y)\right]$.
This is shown in [](#direct-ptychography-sto-fig), and holds a wealth of information:

:::{figure} #app:direct-ptychography-sto
:name: direct-ptychography-sto-fig
:placeholder: ./figures/direct-ptychography-sto-placeholder.png
:::

- The amplitude $\left|G_{Q_x,Q_y}(K_x,K_y)\right|$ arises from the overlap between the bright-field aperture $A(K_x,K_y)$ and two apertures centered at $A(K_x \pm Q_x, K_y \pm Q_y)$.
  - At high spatial frequencies, this forms two regions of "double overlap"
  - At low spatial frequencies, the "double-overlap" regions can themselves overlap, leading to the "triple-overlap" region
    - At zero-defocus, the "triple-overlap" region cancels out and holds no information
    - The similarity of the low-spatial frequency probe overlap regions to [](wiki:Pig's_trotter), gave rise to the colloquialism we wiill adopt
- Importantly, note that the phase of each "trotter" is constant (for zero-defocus)
- The relative rotation of the dataset (here -15°), can also be visualized


## Probe Deconvolution and Aberrations

If we know our convergence semiangle accurately, and have calibrated the relative rotation, we can deconvolve the effects of the probe, by making a mask using one of the two trotters, and summing the (near-constant) phase inside them.
We assign that phase to the structure factor at that spatial frequency, and inverse Fourier transform the structure factor to obtain our reconstructed object.

In the presence of residual probe aberrations, the SSB technique we outlined above breaks down since the phase inside each trotter is no-longer constant [@10.1016/j.ultramic.2014.09.013].
To account for this, one can use a complex-valued filter to compensate the phase variation inside the trotters [@10.1038/ncomms10719].

## Aberrations Fitting

The phase-compensation technique above works really well for known aberrations.
Often times however, we need a robust estimate of residual aberrations in our probe.
The same phase-compensation can be formulated as a linear system of equations and fit aberrations up to a given order in the least-squares sense [@10.1038/ncomms12532].

[](#direct-ptychography-aberrations-fig) highlights the delicate manner by which aberrations enter the SSB reconstruction.
Try playing around with the sliders to see if you can recover the residual aberrations by optimizing the reconstruction.

:::{figure} #app:direct-ptychography-aberrations
:name: direct-ptychography-aberrations-fig
:placeholder: ./figures/direct-ptychography-aberrations-placeholder.png
:::

```{attention} Try it yourself!
Click the following badges to try three complete notebooks on Colab:
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/04.direct_ptychography_01.ipynb), [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/05.direct_ptychography_02.ipynb), and [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/06.direct_ptychography_03.ipynb)
```
