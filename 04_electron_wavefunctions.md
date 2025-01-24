---
title: Electron Wavefunctions
label: electron_wavefunctions_page
numbering:
  enumerator: 4.%s
---

Armed with a numerical representation of our atomic model's scattering potentials, we turn our attention to the second ingredient of simulating STEM measurements, shown in the middle panel of [](#fig_stem_measurements), the electron wavefunction $\psi(\bm{k})$ incident on the sample.

In typical STEM operation, we try to use the objective lens to form the **smallest possible probe**.
Despite enormous recent advances, the electromagnetic lenses used in electron optics are far from an ideal optical system, with the deviations being characterized by probe **aberrations**.

Even in state-of-the-art "aberration-corrected" microscopes, we can never truly eliminate higher-order residual aberrations, and in-fact we will also explore imaging modalities where we deliberately introduce probe aberrations to texture the incoming illumination.
As such, it is important to understand how to model these deviations and how they affect the probe wavefunction.

## Converged Electron Probe

A converged STEM probe can be expressed mathematically in Fourier-space using:
```{math}
:label:stem_probe_eq

\psi(\bm{k}) = A(\bm{k}) \mathrm{e}^{-\mathrm{i} \chi(\bm{k})},

```
where $A(\bm{k})$ is the probe-forming aperture and $\chi(\bm{k})$ is the aberration function.

:::{admonition} Terminology
:class: information

Note that in STEM, we often use the abbreviated term "probe" to refer to the incident electron wavefunction. 
Confusingly, this is used to refer to both the real-space and its dual Fourier-space representation.

:::

## Probe-Forming Aperture

The STEM probe-forming aperture, located in the condenser system, essentially limits the maximum wavevector (i.e. maximum transferred frequency) of the incident electron wavefunction.

The most common probe-forming apertures are circular, with a soft-edge.
Let's investigate how the radius of this soft aperture (specified by the convergence semi-angle) affects the size of the real-space probe in the absence of any probe aberrations.

```{figure} #app:convergence_angle_widget
:name: convergence_angle_widget
:placeholder: ./figures/convergence_angle_placeholder.png
Effect of the convergence semi-angle on the real-space size of a converged probe.
```

## Aberrations Function

It is evident from [](#convergence_angle_widget) that the larger the convergence angle, the smaller the real-space probe size.
Why do we bother clipping the elecrons at higher scattering angles then, and don't always image with a large convergence angle?
The reason is that the residual aberrations we mentioned above are more pronounced at higher scattering angles, limiting our probe size.

```{figure} #app:aberrations_widget
:name: aberrations_widget
:placeholder: ./figures/aberrations_placeholder.png
Effect of common aberrations on the real-space size of a converged probe.
```

[](#aberrations_widget) illustrates this effect by adding some common low-order aberrations to our probe function, namely defocus, (two-fold) astigmatism, and coma.
Try moving the semiangle slider to notice that, in the presence of aberrations, there's an optimum convergence angle to achieve the minimal probe size.
Using the phase scalebar, try and see if you can identify a condition for the maximum allowed "phase-tolerance" for this condition.

### Polar Aberrations Expansion

Notice that while defocus and astigmatism above are specified in nanometers, we specified coma in microns instead.
This is because they scale differently with the magnitude of the spatial frequency.
Similarly, notice that (i) we didn't need to specify an angle for the defocus, which is rotationall invariant; (ii) the astigmatism angle is modulo 180&deg;; while (iii) the coma angle is module 360&deg;.
This is because they have different azimuthal orders.

More generally, we expand the aberration function $\chi(\bm{k})$ in [](#stem_probe_eq) as a series:

```{math}
:label: chi_expansion_eq
\chi(k,\phi) = \frac{2\pi}{\lambda} \sum_{m,n} \frac{1}{n+1} C_{n,m} \left(k \lambda\right)^{n+1} \cos\left[m \left(\phi - \phi_{n,m}\right)\right],
```

where $k = \sqrt{k_x^2 + k_y^2}$ is the radial component and $\phi = \arctan\left[k_y/k_x\right]$ is the azimuthal component of the spatial frequency wavevector, and $n,m$ are the radial and azimuthal orders of the aberration coefficient $C_{n,m}$ with axis $\phi_{n,m}$, respectively.

We can visualize the effect of each aberration coefficient independently using the Fourier-space probe, often called the contrast-transfer function (CTF), and its inverse Fourier-transform which illustrates the effect of the CTF on a point source:

```{math}
:label: psf_eq

\begin{align}
  \mathrm{CTF}(\bm{k}) &= \mathrm{e}^{-\mathrm{i}\chi(\bm{k})} \\
  \mathrm{PSF}(\bm{r}) &= \mathcal{F}^{-1}_{\bm{k}\rightarrow \bm{r}}\left[\mathrm{CTF}(\bm{k}) \right].
\end{align}

```

:::::{tab-set}
::::{tab-item} Contrast transfer functions
:::{figure} ./figures/CTFs_table.png
:::
::::
::::{tab-item} Point spread functions
:::{figure} ./figures/PSFs_table.png
:::
::::
Contrast transfer and point spread functions for independent aberration coefficients at 100kV.
Note that all the azimuthal axes have been set to zero, $\phi_{n,m}=0$, and that the coefficient magnitudes have been scaled by their radial order, $C_{n,m}= 50^n$.
:::::

::::{admonition} Common aliases and conventions
:class: information

Low-order aberrations have common aliases, which both the simulation and analysis codes, `abTEM` and `py4DSTEM` respectively, we will use accept:

:::{table}
:label: aliases_center
:align: center
|         | $m = 0$        | $m = 1$        | $m = 2$        | $m = 3$        | $m = 4$        | $m = 5$        | $m = 6$        |
| ------- | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- | -------------- |
| $n = 1$ | `defocus`      |                | `astigmatism`  |                |                |                |                |
| $n = 2$ |                | `coma`         |                | `trefoil`      |                |                |                |
| $n = 3$ | `Cs`           |                | `astigmatism2` |                | `quadrafoil`   |                |                |
| $n = 4$ |                | `coma2`        |                | `trefoil2`     |                | `pentafoil`    |                |
| $n = 5$ | `C5`           |                | `astigmatism3` |                | `quadrafoil2`  |                | `hexafoil`     |
:::

Note that, by convention, we define `defocus` as $\Delta f = - C_{1,0}$, with positive `defocus` corresponding to the focal point being inside (or even after!) the sample.

::::
