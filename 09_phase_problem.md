---
title: Phase Problem in Electron Microscopy
short_title: Phase Problem in EM
label: phase_problem_page
numbering:
  enumerator: 9.%s
---

While all the electron wavefunctions we have simulated are complex-valued, our physical detectors only allow us to capture the intensity (squared amplitude, $I(\bm{r}) = \left|\psi(\bm{r})\right|^2$) of the exit waves, as we saw in [](#detectors_phonons_page).
This loss of phase information is a well-known limitation of electron microscopy (and all other diffraction and microscopy fields), known as the [](wiki:Phase_problem).
To overcome this, one of the most powerful operating modes for HRTEM is [](wiki:Phase-contrast_imaging) (PCI) where imaging optics or detector configurations are used to convert phase modulations of the electron beam into intensity variations {cite:p}`10.1007/978-3-319-26651-0`.


```{figure} #app:phase_contrast_imaging
:label: phase_contrast_imaging
:placeholder: ./figures/phase_contrast_imaging_placeholder.png
**Plane wave HRTEM imaging simulation of apoferritin.**
When the defocus is zero, this weakly-scattering sample produces only a small amount of amplitude contrast.
By defocusing the scattered electron wave or introducing a Zernike phase plate, we can increase the contrast.
This produces measurable intensity variations even for very low electron fluence at high resolution.
```

## Imaging with Defocus

The simplest method to produce phase contrast in HRTEM imaging is to apply under- or over-focus to the electron wave after it interacts with the sample, shown in [](#phase_contrast_imaging).
The protein sample shown here is [apoferritin](https://www.rcsb.org/structure/8RQB), which produces very weak diffraction of the electron beam.
To produce usable contrast from defocus, we must either apply a large defocus or increase the electron fluence, colloquially referred to as the electron dose {cite:p}`10.1016/j.ultramic.2021.113363`. 

Defocusing an electron wavefunction $\psi_0(\bm{r})$ by a distance $\Delta f$ to produce the output wave $\psi(\bm{r})$ can be modeled mathematically using the expression
```{math}
:label: eq:defocus

\begin{align}
\psi(\bm{r}) &= \psi_0(\bm{r})
	\circledast \frac{i}{\lambda \Delta f}
	\exp \left( \frac{i |\bm{r}|^2}{2 \lambda \Delta f} \right) \\

\psi(\bm{k}) &= \psi_0(\bm{k})
	\exp \left( -i \pi \lambda \Delta f \right)

\end{align}
```
The electron wavefunction after interacting with a weakly-scattering sample can be approximated as
```{math}
:label: eq:weak_phase_object
\psi_0(\bm{r}) = 
	1 + i \phi(\bm{r}),
```
where the $\phi(\bm{r})$ is the phase shift imparted by the sample, and it is considered to be a weak phase object {cite:p}`10.1016/j.ultramic.2013.08.002`. 
Combining equations [](#eq:defocus)
 and [](#eq:weak_phase_object), we can derive the measured intensity for a weak phase object to be
```{math}
:label: eq:intensity_wpo_defocus
I(\bm{r}) = 
	1 - 2 \phi(\bm{r}) 
	\circledast 
	\mathscr{F}_{k \rightarrow r}\{  
		\sin \left( \pi \lambda \Delta f \right)
	\}
```

## Imaging with Phase Plates

An alternative PCI method for plane wave TEM is to use a post-specimen phase plate which advances the phase of the unscattered zero beam with respect to the scattered electrons, or vice versa.
These phase plates have various designs, including a Zernike phase plate {cite:p}`10.1016/S0031-8914(42)80079-8`, Boersch phase plate {cite:p}`10.1515/zna-1947-11-1204`, Volta phase plate {cite:p}`10.1073/pnas.1418377111`, or the recently developed laser phase plates {cite:p}`10.1364/OE.25.014453`.
An ideal phase plate can be modeled in diffraction space using the expression
```{math}
:label: eq:phase_plate
\psi(\bm{k}) = \psi_0(\bm{k}) (1 - \delta(\bm{k})) + i \delta(\bm{k})
```
where $\delta(\bm{k})$ is the [](wiki:Dirac_delta_function).
The sample intensity for a weak phase object is given by the expression
```{math}
:label: eq:intensity_wpo_phase_plate
I(\bm{r}) = 
	1 + 2 \phi(\bm{r}) 
```

[](#phase_contrast_imaging) shows how Zernike phase plate PCI compares to defocusing the sample. 
We note however that practical implementations of phase plates remaining challenging, and typically do not perform as well as the ideal case shown above{cite:p}`10.1093/jmicro/dfr037`.

