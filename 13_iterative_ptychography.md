---
title: Iterative Ptychography
label: iterative_ptycho_page
numbering:
  enumerator: 13.%s
---

While direct ptychography offers dose-efficient imaging at high resolution, iterative ptychography has distinct advantages over it [@10.1063/1.1823034]:

1. It can solve for both the object and the often unknown probe illumination
2. It relaxes stringent sampling constraints by allowing redundancy with defocused probes
3. It is very flexible and easy to adapt to incorporate additional physics (e.g. multi-slice, mixed-state, etc.)

## Ptychographic Iterative Engine Demo

[](#fig_iterative_ptychography) illustrates the main idea of model-based inversion algorithms like ptychography for a thin sample of Au viewed along the [111] zone axis, for a popular serial ptychography algorithm called ePIE [@10.1016/j.ultramic.2009.05.012].

:::{figure} #app:iterative_ptychography
:name: fig_iterative_ptychography
:placeholder: ./figures/iterative_ptychography_placeholder.png
Iterative electron ptychography.
:::

- We start by positioning a guess for the incoming probe on an empty "object" (here, the projected scattering potential)
- We then use our forward model to compute an estimate for the complex-valued exit wave
- We use this to compute the gradient between our estimate for the diffraction intensities and the measured data
  - This is commonly performed in Fourier-space by replacing the amplitude of our modeled exit wave with the square-root of the measured intensities
- The real-space gradient, which has both positive and negative contributions, is added back to the guesses for the potential and the probe
- Optionally, we can constrain our potential and/or our probe guesses
  - For example, since we expect the imparted phase-shifts to be positive, we can clip any negative values from our object
- The above steps are repeated for all probe positions at random, iterating as needed for convergence

## Forward Model Extensions

Depending on the type of assumptions we make for the scattering physics, we are able to reconstruct increasingly complex samples and phenomena using appropriate forward and adjoint models.
[](#forward_models_table) summarizes these phenomena and provides some of the relevant citations:

:::{table} Iterative Ptychography Extensions
:label: forward_models_table

| **Applicability/Physical Phenomenon**  | **Conventional Name/Reference**                                      |
| -------------------------------------- | ---------------------------------------------------------------------|
| Thin or weakly-scattering objects      | Single-slice ptychography [@10.1016/j.ultramic.2009.05.012]          |
| 'Thick' or multiply-scattering objects | Multi-slice ptychography [@10.1126/science.abg2533]                  |
| Partial probe coherence                | Mixed-state ptychography [@10.1038/nature11806]                      |
| Tilt-series of 'thick' objects         | Joint ptychographic tomography [@10.1103/PhysRevApplied.19.054062]    |
| Incoherent (e.g. thermal) scattering   | Open question in the field!                                          |

:::
