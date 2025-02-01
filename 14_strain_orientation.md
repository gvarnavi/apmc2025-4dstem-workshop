---
title: Strain and Orientation Mapping
short_title: Strain/Orientation Mapping
label: strain_orientation_mapping_page
numbering:
  enumerator: 14.%s
---

The phase retrieval techniques we have just explored were mostly focused at atomic-resolution imaging, which requires an aberration-corrected probe with a large convergence angle.
However, a lot of the physics of materials we might care about, such as the sample strain and the crystal structure orientation, may not require atomic resolution.
In-fact a great deal of structural descriptors can be accessed using nanometer resolution by utilizing smaller convergence angles.

We will refer to this 4D-STEM geometry as "nanobeam diffraction".
Recall from [](#cbed_section) that when using small convergence angles, the diffracted disks do not overlap.

## Strain Mapping

The first type of analysis we'll explore is nanometer strain mapping.
The relationship between strain and the location of the nanobeam CBED patterns is illustrated interactively in [](#fig_strain) for a uniaxially-strained Au sample.
As the lattice constant increases along the x-direction, the spacing of the diffracted disks along the $k_x$ direction decreases (recall that real- and reciprocal-space are duals, and thus when one expands the other contracts).

:::{figure} #app:strained_gold
:name: fig_strain
:placeholder: ./figures/strain_mapping_placeholder.png
Strained Au nanobeam diffraction.
:::

As such, in order to be able to map strain using 4D-STEM measurements we need to be able to precisely detect the location of every diffracted peak, and compare that against a reference lattice spacing.

## Orientation Mapping

The link between the zone-axis orientation and the CBED pattern is perhaps less obvious, though we briefly explored it in [](#cbed_section).
[](#fig_orientations) demonstrates a simplified polycrystalline sample with three distinct zone axes orientations of Au.

:::{figure} #app:orientations_gold
:name: fig_orientations
:placeholder: ./figures/orientation_mapping_placeholder.png
Orientation mapping nanobeam diffraction.
:::

Try positioning the probe in the different grains, as well as the grain boundaries, to observe how the CBED patterns change.
This is further complicated by the fact that the grain boundaries need not be aligned with the beam direction and thus, as the probe traverses the sample, we are observing a diffuse boundary in projection.

In order to match crystalline orientations then, we need to perform multiple dynamical scattering simulations along various zone-axes orientations and "match" the experimental observations with the generated database.

```{attention} Try it yourself!
Click the following badges to try two complete notebooks on Colab:  
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/09.strain_orientation_mapping_01.ipynb) and [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://githubtocolab.com/ophusgroup/apmc2025-4dstem-workshop/blob/main/notebooks/try-it-yourself/10.strain_orientation_mapping_02.ipynb) and 
```
