
# optionpricing

<!-- badges: start -->
<!-- badges: end -->

This package provides option pricers for a variety of models of price dynamics 
generally with three methods available per model: analytic (when available), Monte-Carlo, and via P(I)DE-solvers. The models are divided into the following categories:

## Continuous diffusions
- [x] Black-Scholes (geometric Brownian motion)
- [ ] Brigo-Mercurio volatility mixture 
## Jump-diffusions
- [x] Merton's jump diffusion (GBM + compound Poisson of log-normal jumps)
- [x] Kou's jump diffusion (GBM + compound Poisson of exponential-mixture jumps)
## Pure jump processes
- [x] geometric linear Poisson dynamics
- [ ] geometric compsenated compound Poisson dynamics

## Installation

You can install the latest github version via devtools

``` r
devtools::install_github("shill1729/optionpricing")
```

## Example

TODO


