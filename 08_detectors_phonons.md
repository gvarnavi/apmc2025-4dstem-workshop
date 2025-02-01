---
title: Detectors and Frozen Phonons
short_title: Detectors and Phonons
label: detectors_phonons_page
numbering:
  enumerator: 8.%s
---

```{note} Credit

This section in particular is generously inspired from the `abtem` walkthrough guide found [here](https://abtem.readthedocs.io/en/latest/user_guide/walkthrough/scan_and_detect.html).

```

## Scanning Simulations

In the previous sections, we investigated electron scattering simulations using different approximations and algorithms with respective strengths and weaknesses.
These all provided us with the electron exit wave $\psi^{\mathrm{exit}}_{\bm{R}}(\bm{r})$ subject to an incident convergent probe illumination, $\psi^{\mathrm{in}}_{\bm{R}}(\bm{r})$, centered at position $\bm{R}$.
In order to simulate a STEM experiment we simply perform electron scattering simulations for varying prove positions.

In `abtem`, there are a number of ways to specify the path that the scanning probe takes.
Most notably, we can:
- position the probes at custom positions using `abtem.CustomScan`,
- position the probes along a straight line using `abtem.LineScan`, or
- position the probes in a grid using using `abtem.GridScan`

[](#detectors_scans_fig) demonstrates the various scanning modes overlaid on an STO [100] sample.

```{figure} #app:detectors_scans
:label: detectors_scans_fig
Different scan specifications overlaid on an STO [100] sample.
```

## Monolithic Detectors

For each scanning position defined above, we perform an electron scattering simulation to obtain the complex-valued exit wave $\psi^{\mathrm{exit}}_{\bm{R}}(\bm{r})$.
We then need to capture this exit wave using physical detectors, which detect the wave intensity $I_{\bm{R}}(\bm{r}) = \left|\psi^{\mathrm{exit}}_{\bm{R}}(\bm{r}) \right|^2$.

The simplest kind of STEM detectors are "monolithic" annular detectors, which integrate the intensity between specified scattering angles.

```{figure} #app:detectors_monolithic
:label: detectors_monolithic_fig
Monolithic detector integration regions.
```

[](#detectors_monolithic_fig) illustrates the integration regions of three popular type of monolithic detectors, namely:
- a bright field detector (with inner and outer collection angles given by 0 and the convergence angle respectively)
- two types of annular dark field detectors, called "medium" or "high" respectively
  - note the exact collection angle ranges defining these can vary

### Line Scans

[](#detectors_line_fig) plots the result of detecting the exit wave along our line scan using these various monolithic detectors.
Note that:
- in-between atomic columns, $\left|R\right|\sim 1.5\AA$, the detected bright field intensity is almost unity, suggesting the direct beam passes by without scattering.
- Over atomic columns, $\left|R\right|=0$, the bright field intensity drops by ~8%.
  - This intensity if mostly transferred to the middle-angle annular dark field detector.
- The signal in the high-angle annular detector is the easiest to interpet
  - However, less than 1 in 10,000 electrons are detected, making it very dose inefficient.

```{figure} #app:detectors_monolithic_line
:label: detectors_line_fig
Monolithic detector line scans.
```

### Grid Scans

Similarly, [](#detectors_grid_fig) plots the result of detecting the exit wave along a raster grid of positions.
The observations above generalize to these results, but note further that weakly-scattering atomic columns, such as the Oxygen columns on the grid faces are completely lost in the annular dark field scans.
We will investigate this lack of sensitivity to light atoms further in [](#phase_problem_page).

```{figure} #app:detectors_monolithic_grid
:label: detectors_grid_fig
Monolithic detector grid scans.
```

## Pixelated Detectors

Perhaps most relevant to our workshop are so-called "pixelated" detectors, which instead of integrating, collect a two-dimensional image of the exit wave intensity. 
This results in a 4D-dataset, $I(\bm{R},\bm{k})$ with two real-space scan dimensions $\bm{R}$, and two reciprocal-space detector dimensions $\bm{k}$, and allows more flexible postprocessing analyses, as we will see.

[](#detectors_pixelated_fig) plots the collected diffraction patterns at one specific probe position, centered on an atomic column.
Since, as we saw above, most of the direct beam passes unscattered through the sample, we include a second visualization with the BF disk "blocked" to see the four-fold symmetric scattered beams.

```{figure} #app:detectors_pixelated
:label: detectors_pixelated_fig
Pixelated detector example diffraction pattern.
```

### Shot Noise

The exit wave intensities we have seen so-far have been normalized to unity.
This suggest they can be interpeted as spatial probability densities for an electron in the column to hit the detector.
What we have plotted so far can thus be interpeted as "infinite dose" simulations.

Real experiments are of-course performed at finite electron dose, and will thus contain [](wiki:Shot_noise).
It is important to include these effects by drawing random samples from a Poisson distribution for each detector pixel.
[](#detectors_pixelated_postprocessed_fig) shows example "noisy" diffraction patterns for a finite electron dose per area of $10^5\, \mathrm{e}^-/\AA^2$.

```{figure} #app:detectors_pixelated_postprocessed
:label: detectors_pixelated_postprocessed_fig
Postprocessed pixelated detector example diffraction pattern.
```

## Frozen Phonons

As we saw in [](#atomic_models_page), the atomic structure is the starting point for all our simulations, from which the scattering structure factors are obtained.
So far, we have assumed these structures are perfectly static.
Atoms in real materials, however, oscillate around their equlibrium positions e.g. due to thermal vibrations.
This has real consequences in electron scattering experiments, notably diffuse inelastic scattering features such as [](wiki:Kikuchi_lines), and must thus be taken into account in our simulations.

Here, we demonstrate a simple yet accurate model called "frozen phonons", which incoherently sums exit wave intensities from multislice simulations for randomly displaced atomic configurations [@10.1103/PhysRevB.82.104103; @10.1016/j.ultramic.2009.01.001].

```{figure} #app:phonons_configurations
:label: phonons_configurations_fig
Displaced atomic configuration of STO [100].
```

[](#phonons_configurations_fig) illustrates one such configuration for 48 layers of STO [100], where each atom is randomly displaced with a standard deviation of $0.1\AA$.
Performing a planewave multislice simulation using scattering potentials from 8 such displaced configurations, we can observe diffuse scattering concentrated in bands eminating from the zone-axis center, known as [](wiki:Kikuchi_lines).
This is shown in [](#phonons_kikuchi_fig).

```{figure} #app:phonons_kikuchi
:label: phonons_kikuchi_fig
SAED patterns for static and frozen-phonons STO [100].
```
