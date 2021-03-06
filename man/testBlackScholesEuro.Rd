% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/testing.R
\name{testBlackScholesEuro}
\alias{testBlackScholesEuro}
\title{Test Black-Scholes European option pricers}
\usage{
testBlackScholesEuro(
  strike,
  maturity,
  type,
  spot,
  rate,
  div,
  volat,
  N = 300,
  M = 300
)
}
\arguments{
\item{strike}{the strike price of the option}

\item{maturity}{the maturity in trading years until expiration}

\item{type}{type of option, "call" or "put"}

\item{spot}{the current spot price}

\item{rate}{the risk-neutral rate}

\item{div}{the continuous dividend yield rate}

\item{volat}{the volatility level}

\item{N}{time resolution}

\item{M}{space resolution}
}
\value{
matrix
}
\description{
{Verify convergence between the three methods: analytic, Monte-Carlo and PDE}
}
