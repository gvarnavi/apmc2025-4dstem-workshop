---
title: Iterative Ptychography
label: iterative_ptycho_page
numbering:
  enumerator: 13.%s
---

While direct ptychography offers dose-efficient imaging at high resolution, iterative ptychography has distinct advantages over it:

1. It can solve for both the object and the often unknown probe illumination
2. It relaxes stringent sampling constraints by allowing redundancy with defocused probes
3. It is very flexible and easy to adapt to incorporate additional physics (e.g. multi-slice, mixed-state).

[](#fig_iterative_ptychography) illustrates the main idea of model-based inversion algorithms like ptychography.

:::{figure} #app:iterative_ptychography
:name: fig_iterative_ptychography
:placeholder: ./figures/iterative_ptychography_placeholder.png
Iterative electron ptychography.
:::

