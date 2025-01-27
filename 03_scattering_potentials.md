---
title: Scattering Potentials
label: scattering_potentials_page
numbering:
  enumerator: 3.%s
---

## Independent atom model

We can use the collection of atoms we defined in [](#atomic_models_page) to compute the electrostatic scattering potential an incident electron wavefunction experiences as it traverses the sample.

The electrostatic potential of an atom with atomic number $Z$ can be derived as the sum of a negative term due to the Coulomb attraction of the nucleus and a positive term arising from the Coulomb repulsion of the electrons with density $\rho(\bm{r})$:
```{math}
:label: electrostatic_potential
V(\bm{r})=-\frac{Z e^{2}}{|\bm{r}|}+\int_{-\infty}^{+\infty} \frac{e^{2} \rho\left(\bm{r}^{\prime}\right)}{\left|\bm{r}-\bm{r}^{\prime}\right|} \mathrm{d}^{3} \bm{r}^{\prime},
```
where $e$ is the elementary charge.

### Bound electron wavefunctions

The bound electron wavefunction density of a system is mathematically given by the solution of the time-independent [Schrödinger equation](wiki:Schrödinger_equation)

```{math}
:label: schrodinger_eq
    \left[-\frac{\hbar^{2}}{2 m} \frac{\partial^{2}}{\partial \bm{r}^{2}}+V(\bm{r})\right] \psi(\bm{r}) = E\psi(\bm{r}),
```
where $\hbar$ is the reduced Planck constant, $m$ is the electron mass, $V(\bm{r})$ is the Coulomb potential of the nucleus, $\psi(\bm{r})$ is the electron wavefunction, and $E$ is the total energy of the system, which are associated with the eigenvectors and eigenvalues of Equation [](#schrodinger_eq) respectively.

Equation [](#schrodinger_eq) can only be solved analytically for a handful of elements, and you might recall from your studies that the ground state electron density of a hydrogen atom is given by:
```{math}
:label: hydrogen_density
\rho(r) \equiv \left| \psi(r) \right|^2 = \frac{1}{\pi a_0^3} \mathrm{e^{-2 r / a_0}},
```
which decays exponentially with increasing normalized distance $r/a_0$ away from the hydrogen nucleus, where $a_0$ is the [Bohr radius](wiki:Bohr_radius).

### Atomic scattering factors

To generalize this to scattering from other atoms, we proceed by making the [first Born approximation](wiki:Born_approximation).
Under this approximation, the electron wavefunction is given by a sum of incident and scattered wavefunctions {cite:p}`10.1007/978-3-642-29761-8`

```{math}
:label: born_approx
\begin{align}
\psi(\bm{r}) &\equiv \psi_{\mathrm{inc}}(\bm{r}) + \psi_{\mathrm{scatt}}(\bm{r}) \\
 &= \mathrm{e}^{\mathrm{i}\bm{k_0} \cdot \bm{r}} - \frac{m}{2 \pi \hbar^2} \frac{\mathrm{e}^{\mathrm{i}\bm{k}\cdot \bm{r}}}{|\bm{r}|} \int V\left(\bm{r}^{\prime}\right) \mathrm{e}^{\mathrm{i}\left(\bm{k_0-k}\right)\cdot \bm{r}^{\prime}}  d^3 \bm{r}^{\prime} \\
 &= \mathrm{e}^{\mathrm{i}\bm{k_0} \cdot \bm{r}} + \frac{\mathrm{e}^{\mathrm{i}\bm{k}\cdot r}}{|\bm{r}|} f(\Delta\bm{k}).
\end{align}
```
Here, $\Delta \bm{k} \equiv \bm{k-k_0}$ and $f(\bm{k}) = \mathcal{F}_{k}\left[ V(\bm{r})\right]$ is referred to as the electron scattering factor which can be related to the electron density using the [Mott-Bethe formula](wiki:Mott–Bethe_formula):
```{math}
:label: mott_bethe
f(\Delta \bm{k})=\frac{2 m e^2}{\hbar^{2} \Delta k^{2}} \left(Z-\frac{m c^2}{e^2}f_{x}(\Delta \bm{k})\right),
```
where $f_x(k) = \mathcal{F}_k\left[\rho(\bm{r})\right]$ is referred to as the x-ray scattering factor {cite:p}`10.1007/978-3-030-33260-0`

### Atomic potential parametrizations

While the radial dependence of the electrostatic potential (or equivalently in reciprocal space the electron scattering factor) for different elements cannot be computed analytically, we expect it to follow a similar functional form as that of the Hydrogen atom.

This is indeed confirmed by computationally-expensive first-principles calculations, and thus a sensible way forward is to parametrize these scattering factors using numerical fits of first-principle calculations.
This is shown in [](#scattering_factors) for five selected elements, in both real- and reciprocal-space using the Lobato parametrization {cite:p}`10.1107/S205327331401643X`. 

```{figure} #app:scattering_factors
:name: scattering_factors
```

Finally, the sample potential $V(r)$ can be obtained under the independent atom model (IAM) using a superposition of independent atom potentials $V_i(\bm{r})$ for atom centered at $\bm{r}_i$.

```{math}
:label: iam
V(\bm{r}) = \sum_i V_i(\bm{r} -\bm{r}_i)
```

## Numerical potential grids

Equation [](#iam) is implemented numerically in `abTEM` on a rectilinear grid of $N_x \times N_y$ in-plane grip points (`gpts`) and $N_z$ slices.

```python
potential = abtem.Potential(
    Si3N4_orthorhombic,
    sampling = 0.1,
    slice_thickness = 0.75,
    parametrization = 'lobato',
    projection = 'finite',
)

```

We can visualize the sliced potential by plotting the first few potential slices as in [](#sliced_potential)

```{figure} #app:sliced_potential
:name: sliced_potential
Si$_3$N$_4$ super-cell potential sliced along the beam-dimension.
```

or projecting along the beam direction as in [](#projected_potential).

```{figure} #app:projected_potential
:name: projected_potential
Si$_3$N$_4$ super-cell potential projected along the beam-dimension.
```

:::{admonition} Sampling Considerations
:class: information
:label: sampling_callout

Given an orthorhombic cell with in-plane cell dimensions $L_x$ and $L_y$ and rectilinear grid points $N_x$ and $N_y$ respectively, the real-space sampling is given by 

```{math}
\begin{align}
 \Delta x &= L_x / N_x \\
 \Delta y &= L_y / N_y.
\end{align}
```

This means that the real-space coordinates will take discrete values of

```{math}
\begin{align}
 x_i &= i \Delta x \qquad i = 0, 1, \dots, N_x -1  \\
 y_j &= j \Delta y \qquad j = 0, 1, \dots, N_y -1.
\end{align}
```

The reciprocal-space dual-grids will also have $N_x$ by $N_y$ grid points and take values of

```{math}
\begin{align}
 k_{x,i} &= -k_{x,\mathrm{max}} + i \Delta k_x \qquad i = 0, 1, \dots, N_x -1  \\
 k_{y,j} &= -k_{y,\mathrm{max}} + j \Delta k_y \qquad j = 0, 1, \dots, N_y -1,
\end{align}
```

where $\Delta k_x = 1/L_x$ and $\Delta k_y = 1/L_y$ and $k_{x,\mathrm{max}} = \frac{1}{2 \Delta x}$ and $k_{y,\mathrm{max}} = \frac{1}{2 \Delta y}$, which highlights the important duality between the two grids.

:::
