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

### Probe-Forming Aperture

The STEM probe-forming aperture, located in the condenser system, essentially limits the maximum wavevector (i.e. maximum transferred frequency) of the incident electron wavefunction.

The most common probe-forming apertures are circular, with a soft-edge.
Let's investigate how the radius of this soft aperture (specified by the convergence semi-angle) affects the size of the real-space probe in the absence of any probe aberrations.

```{figure} #app:convergence_angle_widget
:name: convergence_angle_widget
```
