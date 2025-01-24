---
title: Multislice Algorithm
label: multislice_algorithm_page
numbering:
  enumerator: 5.%s
---

Armed with our numerical scattering potentials (the "object") and our incident electron wavefunction (the "probe"), we are now ready to simulate our STEM measurements.

In this section we will introduce the most popular way of simulating electron scattering experiments, the **multislice method**, introduced by {cite:t}`10.1107/S0365110X57002194`.
In [](#bloch_wave_algorithm_page), we introduce an alternative approach better suited for periodic calculations of small unit-cells.

## Scaled Schrödinger equation

Our starting point is the time-independent Schrödinger equation introduced in [](#scattering_potentials_page):

```{embed} #schrodinger_eq
```
where recall $V(\bm{r})$ is the crystal potential and $E$ is the energy of the electron wavefunction $\psi(\bm{r})$.

In the quantum-mechanical wave picture above, we define the De Broglie wavelength ([](wiki:Matter_wave)) of relativistic free electrons as

```{math}
:label: wavelength_eq
\lambda(U_0) = \frac{h c}{\sqrt{e U_0 \left(2 m c^2 + e U_0 \right)}},
```
where $h$ is the [](wiki:Planck_constant), $c$ is the [](wiki:Speed_of_light), $e$ is the [](wiki:Elementary_charge) of electrons, and $U_0$ is the accelerating voltage of our microscope's electron gun.

```{embed} #app:relativistic_wavelength
:remove-input: false
```

This allows us to define the electron-potential interaction parameter:
```{math}
:label: sigma_eq
\sigma(U_0) = \frac{2\pi \,m\, e\, \lambda(U_0)}{h^2},
```
and express [](#schrodinger_eq) as:
```{math}
:label: scaled_schrodinger_eq
\left[\nabla^2 + 4 \pi^2 k_0^2(U_0) \right]\psi(\bm{r}) = -4\pi^2 \sigma V(\bm{r})\psi(\bm{r}),
```
where we have introduced the in-plane electron wavevector, $k_0(U_0) = 1/ \lambda(U_0)$.

## Multislice assumptions

To proceed, the multislice method makes two assumptions:
- The $\partial^2 / \partial z^2$ term in the Laplacian can be neglected, since the wavefunction variation along the beam direction (z-axis) is much lower than the in-plane variation  
- The in-plane wavevector $k_0$ is much larger than the in-plane variations of the wavefunction, i.e. $k_0(U_0) \gg \left| \nabla^2_{x,y}\right|$

Using these assumptions [](#scaled_schrodinger_eq) can be simplified further to highlight the separation in timescales between the axial and in-plane components {cite:p}`10.1007/978-3-030-33260-0`:
```{math}
:label: multislice_eq
\frac{\partial}{\partial z} \psi(\bm{r}) = \frac{i \lambda(U_0)}{4\pi} \nabla^2_{x,y} \psi(\bm{r}) + i \sigma V(\bm{r}) \psi(\bm{r}).
```

[](#multislice_eq) outlines the numerical scheme we will use to solve it.
Namely, for a wavefunction $\psi_0$ at a specific depth inside the sample, $z_0$, we can evaluate the operators on the right-hand side over a distance $\Delta z$ to calculate a new wavefunction $\psi(\bm{r})$ at position $z_0 + \Delta z$.

For small $\Delta z$, the solution to [](#multislice_eq) is given by {cite:p}`10.1007/978-3-030-33260-0`:
```{math}
:label: small_dz_sol_eq
\psi(\bm{r}) = \mathrm{exp} \left[\frac{i \lambda(U_0)}{4 \pi}\Delta z \nabla^2_{x,y} + i \sigma V_{\Delta z}(\bm{r}) \right] \psi_0 (\bm{r}),
```
where
```{math}
V_{\Delta z}(\bm{r}) = \int_{z_0}^{z_0 + \Delta z} V(\bm{r}) dz,
```
is one slice of the numerical-grid representation of our scattering potential we described in [](#scattering_potentials_page).

## Split-step Solution

Unfortunately, the two operators in [](#small_dz_sol_eq) don't commute with one another, so a closed-form solution is out of reach.
Instead, the multislice method solves [](#small_dz_sol_eq) numerically, by alternating between solving each of the two operators independently.

### Transmission Operator

Assuming an infinitesimally thin potential slice, we can drop the $\nabla^2_{x,y}$ term in [](#small_dz_sol_eq) to obtain the solution {cite:p}`10.1007/978-3-030-33260-0`:
```{math}
:label: transmission_eq
\psi(\bm{r}) = \psi_0(\bm{r}) \mathrm{exp} \left[i\, \sigma(U_0)\, V_{\Delta z}(\bm{r}) \right].
```

Intuitively, this can be understood as the electron wavefunction acquiring a positive phase-shift proportional to the scattering potential in a particular slice.

### Propagation Operator

```{figure} #app:multislice_widget
:placeholder: ./figures/multislice_placeholder.png
```
