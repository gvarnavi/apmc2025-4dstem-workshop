---
title: Tilt-Corrected Bright-Field STEM
short_title: tcBF-STEM (Parallax)
label: parallax_page
numbering:
  enumerator: 11.%s
---

## Principle of Reciprocity

In [](#bloch_wave_algorithm_page), we used the fact that off-axis pixels inside the BF disk are equivalent to tilted plane waves to calculate CBED patterns.
Formally, this relationship is referred to as the [principle of reciprocity](wiki:Helmholtz_reciprocity), which states that rays connecting a source to a detector follow he same optical path as the rays from the detector to the source {cite:p}`10.1016/j.micron.2016.09.007`.

:::{figure} #app:hrtem_bf_stem_reciprocity
:name: hrtem_bf_stem_reciprocity
:placeholder: ./figures/hrtem_bf_stem_reciprocity_placeholder.png
Principle of reciprocity in off-axis BF-STEM and tilted HRTEM.
The tilted ray traces in HRTEM from source-to-detector match the ray traces in STEM from detector-to-source, and highlight the apparent lateral image shifts at the sample plane.
:::

[](#hrtem_bf_stem_reciprocity) shows how this can be used to show that tilted HRTEM images are equivalent to virtual images created using off-axis pixels in BF-STEM.
By following the tilted rays from source-to-detector in HRTEM and detector-to-source in STEM we can see reciprocity in action.
Notice how the tilted rays impact the sample at different positions, giving rise to the apparent lateral image shifts.

## Lateral Image Shifts

Consider the virtual BF image formed by integrating only the center-most pixel of the bright field disk in a 4D-STEM experiment in [](#virtual_bf_images_stack).
This image is analogous to a conventional HRTEM image at the same conditions. 
More generally in STEM imaging, as the collection angle is decreased, diffraction contrast increases, and the resulting image looks more like a HRTEM bright field image {cite:p}`10.1007/978-3-319-26651-0`.
Recall that, as we saw in [](#phase_problem_page), we can increase the contrast by introducing defocus.

:::{figure} #app:shifted_virtual_bfs
:name: virtual_bf_images_stack
:placeholder: ./figures/virtual_bf_shifts_placeholder.png
**Virtual Bright-Field Images.** Schematic of STEM probe (left). 
The virtual images (right) are formed from the position highlighted by the red dot (middle). 
The size of the shifts become larger with increasing magnitude of defocus.
:::

When defocused, tilted planewave illumination (equivalent to off-axis virtual BF-STEM images) produces lateral image shifts.
This can be seen by clicking on the BF-disk in [](#virtual_bf_images_stack). 
The magnitude of the shifts increases with increasing defocus, which is based on the geometry of a defocused probe, as illustrated on the left.

## Aberration Surface Gradient

More generally, the lateral shifts $\vec{w}(\bm{k})$ are given by the gradient of the aberration surface $\chi(\bm{k})$ {cite:p}`10.1111/jmi.12372`:

```{math}
:label: aberration_surface_gradient_eq
\vec{w}(\bm{k}) = \nabla \chi(\bm{k}).
```

[](#parallax_shifts_interactive) investigates the effect of common aberrations and microscope geometry variations, away from the ground-truth values (relative rotation angle = -15°, and defocus = 1.5μm), on the apparent image shifts of virtual BF images and the aligned virtual BF stack.

:::{figure} #app:parallax_shifts_interactive
:name: parallax_shifts_interactive
:placeholder: ./figures/parallax_shifts_placeholder.png
:::

```{attention} Try it yourself!
Click the following badges to try two complete notebooks on Colab:  
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/02.parallax_01.ipynb) and [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/03.parallax_02.ipynb)
```
