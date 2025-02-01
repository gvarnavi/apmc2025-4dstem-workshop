---
title: Bloch Wave Algorithm
label: bloch_wave_algorithm_page
numbering:
  enumerator: 7.%s
---

The [](#prism_algorithm_page) we have explored in the previous section used a planewave expansion to construct the exit wavefunction, by applying the multislice operator to each planewave.
An alternative expansion, which can be very efficient for small periodic structures, is the Bloch wave formalism which uses [](wiki:Bloch's_theorem) to ensure basis functions respect the crystal periodicity explicitly:
```{math}
:label: blochwave_expansion
\begin{align}
    \psi(\bm{r}) & = \sum_j \alpha_j b_j(\bm{k}_j,\bm{r}) \\
    b_j(\bm{k}_j,\bm{r}) &= \mathrm{e}^{2\pi\, \mathrm{i}\, \bm{k}_j \cdot \bm{r}} \sum_{\bm{g}} c_{\bm{g},j} \mathrm{e}^{2\pi\, \mathrm{i}\, \bm{g}\cdot \bm{r}},
\end{align}
```
where $\bm{k}_j$, $\bm{g}$, and $c_{\bm{g},j}$ are the Bloch wavevectors, reciprocal lattice vectors, and planewave coefficients respectively.

## Bloch's Theorem

Our starting point is once again the time-independent Schrödinger equation, [](#schrodinger_eq):

```{math}
:label: schrodinger_eq_bloch
\left[-\frac{\hbar^{2}}{2 m} \nabla^2 + e V(\bm{r})\right] \phi(\bm{r}) = E \phi(\bm{r}),
```
where we have introduced the slowly-varying envelope function, $\phi(\bm{r})$, by separating the rapidly-oscillating component of the electron wavefunction according to:
```{math}
\psi(\bm{r}) = \mathrm{exp}\left[2\pi\, \mathrm{i}\, k_0 \,z \right] \phi(\bm{r}).
```

To proceed, we expand both $\phi(\bm{r})$ and $V(\bm{r})$ as sums of Bloch waves:
```{math}
:label: bloch_theorem_eq
\begin{align}
    \phi(\bm{r}) & = \sum_{\bm{g}} c_{\bm{g},j} \mathrm{e}^{2\pi\, \mathrm{i}\, \bm{g} \cdot \bm{r}} \\
    V(\bm{r}) & = \sum_{\bm{g}} V_{\bm{g}} \mathrm{e}^{2\pi\, \mathrm{i}\, \bm{g} \cdot \bm{r}},
\end{align}
```
which when substituted back into [](#schrodinger_eq_bloch), result in an infinite set of coupled equations for the planewave coefficients $c_{\bm{g},j}$.

### 1D Toy Example

Before we apply [](#bloch_theorem_eq) to realistic potentials, it is instructive to consider a 1D toy example, which you might have come across in your quantum mechanics courses.

We will consider the following periodic potential with lattice constant $a$:
```{math}
\begin{align}
    V(x) & = 2 V_0\, \mathrm{cos} \left(\frac{2 \pi \,x}{a} \right) \\
         & = V_0 \left(
         \mathrm{e}^{2\pi\, \mathrm{i}\, g\, x} 
         + \mathrm{e}^{-2\pi\, \mathrm{i}\, g\, x} 
         \right),
\end{align}
```
where $g=1/a$ is the 1D reciprocal lattice vector.
If we only include three reciprocal lattice vectors, $g=[-1,0,1]$, in our expansion we can write the coupled set of equations as:

```{math}
:label: central_matrix_3x3
\begin{bmatrix}
    \frac{\hbar^2}{2 m} \left(k_j-g\right)^2 & V_0 & 0 \\
    V_0 & \frac{\hbar^2}{2m} k_j^2 & V_0 \\
    0 & V_0 & \frac{\hbar^2}{2m} \left(k_j+g \right)^2
\end{bmatrix} 
\begin{bmatrix}
    c_{-g,j} \\
    c_{0,j} \\
    c_{g,j}
\end{bmatrix} =
E \begin{bmatrix}
    c_{-g,j} \\
    c_{0,j} \\
    c_{g,j}
\end{bmatrix}.
```

The eigenvectors, $c_{\bm{g},j}$, and eigenvalues, $E$, may now be solved by diagonalizing [](#central_matrix_3x3) for each $k_j$.
[](#toymodel_bloch_fig) plots the eigenvalues for $k_j$ in the first [](wiki:Brillouin_zone), for different values of the potential.

```{figure} #app:toymodel_bloch_widget
:label: toymodel_bloch_fig
:placeholder: ./figures/toymodel_bloch_placeholder.png
```

```{note} Bandgaps
Note that when $V_0=0$, in a model called the empty-lattice approximation, the bands "touch" at the Brillouin zone edge.
As we increase $V_0$, the bands start opening up "band gaps", resulting in inaccessible energy values in the crystal.
```

## Bloch Matrix Eigenvalue Problem

Now that we have built intuition with the toy 1D potential using a 3x3 matrix, we turn our attention back to the formal treatment, following {cite:p}`10.1017/CBO9780511615092`,  by inserting [](#bloch_theorem_eq) into [](#schrodinger_eq_bloch) to give:
```{math}
:label: schrodinger_eq_expansion
\sum_{\bm{g}} \left(k_0 - \left|\bm{k}_j+\bm{g} \right|^2 \right) c_{\bm{g},j} \mathrm{e}^{2\pi\,\mathrm{i}\,\left(\bm{k}_j+\bm{g}\right)\cdot\bm{r}} = - \sum_{\bm{g},\bm{h}} V_{\bm{g}-\bm{h}} c_{\bm{h},j} \mathrm{e}^{2\pi\,\mathrm{i}\,\left(\bm{k}_j+\bm{g}\right)\cdot \bm{r}},
```
which can be recasted as an eigenvalue equation:
```{math}
:label: bloch_eigenvalue
\left[2 k_0 s_{\bm{g}} - 2 \gamma_j k_0 \right]c_{\bm{g},j} + \sum_{\bm{h} \neq \bm{g}} V_{\bm{g}-\bm{h}} c_{\bm{h},j} = 0,
```
where we have defined the eigenvalues, $2\gamma_j k_0$, and **excitation error**, $s_{\bm{g}} = \left(k_0^2 - \left| \bm{k}_0 + \bm{g} +  \right|^2 \right)/2k_0$, which describes how far a specific reciprocal lattice vector is from the exact Bragg condition, which in turns determines how strongly that beam is excited during electron diffraction.

Thickness effects are incorporated by propagating the wavefunction at depth $z$ according to:
```{math}
:label: bloch_propagation
\begin{align}
    \psi(\bm{r}) & = \sum_{\bm{g}} \psi_{\bm{g}}(z) \mathrm{e}^{2 \pi\, \mathrm{i}\, \left(\bm{k}_0 + \bm{g}\right)\cdot \bm{r}} \\
    \psi_{\bm{g}}(z) &= \sum_j \alpha_j c_{\bm{g},j} \mathrm{e}^{2\pi\, \mathrm{i}\, \gamma_j z},
\end{align}
```
The coefficients $\alpha_j$ are chosen to satisfy the Bloch wave expansion of the Fourier components of the input wavefunction, $\psi_{\bm{g}}(z=0)$, according to:

```{math}
:label: bloch_input_wavefunction
\alpha_j = \sum_{\bm{g}} c_{\bm{g},j}^* \psi_{\bm{g}}(0).
```

## Selected Area Diffraction Patterns

As we saw above, planewave diffraction is at the heart of the Blochwave simulation method, so we will explore that first.
All other types of measurements we will discuss can be constructed using individual planewave calculations.

### Kinematical and Dynamical Diffraction

We consider our Si$_3$N$_4$ crystal, viewed along the [001] zone axis.
The first step is to extract the parametrized scattering factors for each atom in our structure, and evaluate them on each of the structure's reciprocal lattice vectors within a specified cutoff distance.
We then use this to form the kinematical SAED patterns, by weighting the structure factor intensities with the reciprocal vector's excitation error $s_{\bm{g}}$ as we saw above.

```{figure} #app:blochwave_kinematical
:label: blochwave_kinematical_fig
```

We can then use [](#bloch_propagation) to model dynamical scattering and plot the resulting SAED patterns as a function of thickness.
Notice how, in addition to overall increased scattering, the modulation of intensities within the pattern changes with thickness.

```{figure} #app:blochwave_thickness
:label: blochwave_dynamical_thickness_fig
```

### Tilted Crystal Electron Diffraction

One of the advantages of the Blochwave algorithm, as compared to multislice, is that scattering from arbitrary orientations of the structure is straightforward to calculate.
[](#blochwave_dynamical_tilted_fig) illustrates this by calculating a 4x4 grid of dynamical SAED patterns, for different x- and y- crystal tilts.
Notice how the Laue circle -- the ring of strongly excited reflections -- shifts around the pattern.
Understanding how the Laue circle corresponds to crystal tilting is essential for successfully bringing a crystal onto a zone axis orientation.

```{figure} #app:blochwave_tilted
:label: blochwave_dynamical_tilted_fig
```

(cbed_section)=
## Converged Beam Electron Diffraction

As we illustrated above, dynamical diffraction causes strong intensity oscillations between diffracted beams, which can be observed by tilting the crystal.
This is typically done by capturing a CBED pattern -- where different angles within the probe's numerical aperture correspond to tilted planewave illumination.

```{note} 
If the convergence angle is small enough such that the diffracted disks don't overlap, then each planewave intensity that makes up the CBED pattern can be calculated independently.
```

Since the excitation of the Bragg beams oscillates as a function of tilt with a period that relates to the crystal thickness, measuring CBED fringes can be used to estimate thickness.
[](#blochwave_dynamical_cbed_fig) illustrates this effect by calculating CBED patterns for Si$_3$N$_4$ using a convergence angle of 5 mrad, for various crystal thicknesses.

```{figure} #app:blochwave_cbed
:label: blochwave_dynamical_cbed_fig
```

An even more robust related technique for estimating crystal thickness is to use a larger convergence angle to form a sub-Ångström focused probe, which is scanned across the sample.
While each individual diffraction pattern is strongly-dependent on the position of the probe within the unit cell -- and thus our "independent" planewaves approach is invalid -- the technique averages across scan positions to produce a single PACBED pattern.
This is mathematically equivalently to incoherently summing the contributions of independent tilted planewave calculations, so we can use the same formalism.

```{figure} #app:blochwave_pacbed
:label: blochwave_dynamical_pacbed_fig
```
