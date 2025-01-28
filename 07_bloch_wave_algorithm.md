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

## 1D Toy Example

Before we apply [](#bloch_theoreom_eq) to realistic potentials, it is instructive to consider a 1D toy example, which you might have come across in your quantum mechanics courses.

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

## Selected Area Diffraction Patterns
