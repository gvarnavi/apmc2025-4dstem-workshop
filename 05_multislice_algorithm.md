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
\left[\nabla^2 + 4 \pi^2 k_0^2 \right]\psi(\bm{r}) = -4\pi^2 \sigma V(\bm{r})\psi(\bm{r}),
```
where we have introduced the in-plane electron wavevector, $k_0 = 1/ \lambda(U_0)$.
Note this has an implicit dependence on the accelerating voltage, which we omit for notational convenience.

## Multislice assumptions

To proceed, the multislice method makes two assumptions:
- The $\partial^2 / \partial z^2$ term in the Laplacian can be neglected, since the wavefunction variation along the beam direction (z-axis) is much lower than the in-plane variation  
- The in-plane wavevector $k_0$ is much larger than the in-plane variations of the wavefunction, i.e. $k_0 \gg \left| \nabla^2_{x,y}\right|$

Using these assumptions [](#scaled_schrodinger_eq) can be simplified further to highlight the separation in timescales between the axial and in-plane components {cite:p}`10.1007/978-3-030-33260-0`:
```{math}
:label: multislice_eq
\frac{\partial}{\partial z} \psi(\bm{r}) = \frac{i \lambda(U_0)}{4\pi} \nabla^2_{x,y} \psi(\bm{r}) + i \sigma V(\bm{r}) \psi(\bm{r}).
```

Equation [](#multislice_eq) outlines the numerical scheme we will use to solve it.
Namely, for a wavefunction $\psi_n$ at a specific depth inside the sample, $z_n$, we can evaluate the operators on the right-hand side over a distance $\Delta z$ to calculate a new wavefunction $\psi_n^{\prime}(\bm{r})$ at position $z_n + \Delta z$.

For small $\Delta z$, the solution to [](#multislice_eq) is given by {cite:p}`10.1007/978-3-030-33260-0`:
```{math}
:label: small_dz_sol_eq
\psi_n^{\prime}(\bm{r}) = \mathrm{exp} \left[\frac{i \lambda(U_0)}{4 \pi}\Delta z \nabla^2_{x,y} + i \sigma V_n^{\Delta z}(\bm{r}) \right] \psi_n (\bm{r}),
```
where
```{math}
V_n^{\Delta z}(\bm{r}) = \int_{z_n}^{z_n + \Delta z} V(\bm{r}) dz,
```
is one slice of the numerical-grid representation of our scattering potential we described in [](#scattering_potentials_page).

## Split-step Solution

Unfortunately, the two operators in [](#small_dz_sol_eq) don't commute with one another, so a closed-form solution is out of reach.
Instead, the multislice method solves [](#small_dz_sol_eq) numerically, by alternating between solving each of the two operators independently.

### Transmission Operator

Assuming an infinitesimally thin potential slice, we can drop the $\nabla^2_{x,y}$ term in [](#small_dz_sol_eq) to obtain the solution {cite:p}`10.1007/978-3-030-33260-0`:
```{math}
:label: transmission_eq
\begin{align}
	\psi_n^{\prime}(\bm{r}) & = \mathrm{exp} \left[i\, \sigma(U_0)\, V_n^{\Delta z}(\bm{r}) \right] \psi_n(\bm{r}) \\
	                        & \equiv t_n(\bm{r}) \psi_n(\bm{r}),                                                        
\end{align}
```
where we have defined the transmission operator, $t_n(\bm{r})$.
Intuitively, this can be understood as the electron wavefunction acquiring a positive phase-shift proportional to the scattering potential in a particular slice.

### Propagation Operator

In the next half-step, we need to propagate the electron wavefunction from one slice to the next using [](#small_dz_sol_eq).
Setting the space between the slices empty, $V(\bm{r})=0$, and Taylor expanding, we obtain:

```{math}
:label: propagation_eq
\begin{align}
	\psi_{n+1}(\bm{r}) & = \mathrm{exp} \left[ \frac{\mathrm{i\, \lambda(U_0) \Delta z}}{4 \pi} \nabla^2_{x,y} \right] \psi_n^{\prime}(\bm{r}) \\
	                   & = \left[                                                                                                              
	\sum_{m=0}^{\infty}\left(\frac{\mathrm{i}\,\lambda(U_0) \Delta z}{4 \pi}\right)^m \frac{\partial^{2m} \psi_{n}^{\prime}(\bm{r})}{\partial x^{2m}}
	\right]
	\left[
	\sum_{l=0}^{\infty}\left(\frac{\mathrm{i}\,\lambda(U_0) \Delta z}{4 \pi}\right)^l \frac{\partial^{2l} \psi_{n}^{\prime}(\bm{r})}{\partial y^{2l}}
	\right].
\end{align}
```
Equation [](#propagation_eq) simplifies further when expressed in Fourier space, $\Psi_{n+1}(\bm{k}) = \mathcal{F}_{\bm{r}\rightarrow \bm{k}} \left[ \psi_{n+1}(\bm{r}) \right]$:


```{math}
:label: propagation_fourier_eq
\begin{align}
	\Psi_{n+1}(\bm{k}) & = 
	\left[
	\sum_{m=0}^{\infty} \left(- \mathrm{i}\,\pi \lambda(U_0) \Delta z k^2_x  \right)^m
	\right] 
	\left[
	\sum_{l=0}^{\infty} \left(- \mathrm{i}\,\pi \lambda(U_0) \Delta z k^2_y  \right)^l
	\right] 
	\\
	                   & = 
	\mathrm{exp}\left(-\mathrm{i}\,\pi \lambda(U_0) \Delta z k^2_x\right)
	\mathrm{exp}\left(-\mathrm{i}\,\pi \lambda(U_0) \Delta z k^2_y\right)
	\Psi_{n}^{\prime}(\bm{k}) \\ 
	                   & = 
	\mathrm{exp}\left(-\mathrm{i}\,\pi \lambda(U_0) \Delta z \left|k\right|^2\right) \Psi_{n}^{\prime}(\bm{k}) \\
                       & \equiv
    \mathcal{P}_{\Delta z}(\bm{k}) \Psi_{n}^{\prime}(\bm{k}),
\end{align}
```
where we have defined the [Fresnel propagator](wiki:Fresnel_diffraction), $\mathcal{P}_{\Delta z}(\bm{k})$.

### Iterative Fourier Implementation

The two propagators can be combined efficiently using the convolution property of the Fourier transform to obtain:

```{math}
:label: multislice_operator_slice
\begin{align}
    \psi_{n+1}(\bm{r}) & = \mathcal{F}_{\bm{k}\rightarrow \bm{r}}^{-1} 
        \left[
            \mathcal{P}_{\Delta z}(\bm{k}) \mathcal{F}_{\bm{r} \rightarrow \bm{k}}
                \left[
                    t_n(\bm{r}) \psi_{n}(\bm{r})
                \right]
        \right] \\
                       & \equiv \mathcal{M}_n \psi_n(\bm{r}),
\end{align}
```
where we have defined the multislice operator, $\mathcal{M}_n$.
Equation [](#multislice_operator_slice) can be applied iteratively until all the potential slices have been traversed, to return the exit wavefunction $\psi_N(\bm{r})$:

```{math}
:label: multislice_operator
\psi_{N}(\bm{r}) = \mathcal{M}_{N-1} \mathcal{M}_{N-2} \dots \mathcal{M}_0 \psi_0(\bm{r}).
```
[](#multislice_widget) illustrates the above equations interactively, illustrating the effect of each operator separately.
Click somewhere on the potential to position the incoming electron wavefunction, and use the buttons to transmit/propagate the wavefunction through the potential.

```{figure} #app:multislice_widget
:name: multislice_widget
:placeholder: ./figures/multislice_placeholder.png
```
