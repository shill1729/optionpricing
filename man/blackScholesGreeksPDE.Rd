% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{blackScholesGreeksPDE}
\alias{blackScholesGreeksPDE}
\title{Compute price and greeks of European and American options via Black-Scholes PDE}
\usage{
blackScholesGreeksPDE(
  strike,
  maturity,
  type,
  spot,
  r,
  q,
  v,
  res,
  american = TRUE
)
}
\arguments{
\item{strike}{the strike price of the option contract}

\item{maturity}{the time until maturity}

\item{type}{either "put" or "call}

\item{spot}{the spot price}

\item{r}{the risk free rate}

\item{q}{the continuous dividend yield}

\item{v}{the volatiltiy}

\item{res}{the grid resolution}

\item{american}{bool for american options}
}
\value{
numeric
}
\description{
{Compute European/American options via a finite difference solver for the
Black-Scholes PDE.}
}
