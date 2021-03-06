#' Test Black-Scholes European option pricers
#'
#' @param strike the strike price of the option
#' @param maturity the maturity in trading years until expiration
#' @param type type of option, "call" or "put"
#' @param spot the current spot price
#' @param rate the risk-neutral rate
#' @param div the continuous dividend yield rate
#' @param volat the volatility level
#' @param N time resolution
#' @param M space resolution
#'
#' @description {Verify convergence between the three methods: analytic, Monte-Carlo and PDE}
#' @return matrix
#' @export testBlackScholesEuro
testBlackScholesEuro <- function(strike, maturity, type, spot, rate, div, volat, N = 300, M = 300)
{
  prices <- matrix(0, 3)
  prices[1] <- analyticBlackScholesPrice(strike, maturity, type, spot, rate, div, volat)
  prices[2] <- monteCarloBlackScholes(strike, maturity, type, spot, rate, div, volat)
  prices[3] <- blackScholesPDE(strike, maturity, type, spot, rate, div, volat, c(N, M), FALSE)
  absErrors <- abs(prices-prices[1])
  relErrors <- absErrors/prices[1]
  perErrors <- relErrors*100
  output <- cbind(prices, absErrors, relErrors, perErrors)
  rownames(output) <- c("exact", "monte-carlo", "pde")
  colnames(output) <- c("price", "abs-error", "rel-error", "% error")
  return(output)

}

#' Test Poisson-pricer for European option prices
#'
#' @param strike the strike price of the option
#' @param maturity the maturity in trading years until expiration
#' @param type type of option, "call" or "put"
#' @param spot the current spot price
#' @param rate the risk-neutral rate
#' @param a the Poisson coefficient
#' @param b the drift coefficient
#' @param N time resolution
#' @param M space resolution
#'
#' @description {Verify convergence between the three methods: analytic, Monte-Carlo and PDE}
#' @return matrix
#' @export testPoissonEuro
testPoissonEuro <- function(strike, maturity, type, spot, rate, a, b, N = 300, M = 300)
{
  prices <- matrix(0, 3)
  prices[1] <- analyticPoissonPrice(strike, maturity, type, spot, rate, a, b)
  prices[2] <- monteCarloPoisson(strike, maturity, type, spot, rate, a, b)
  prices[3] <- cpoisPDE(strike, maturity, type, spot, rate, a, b, res = c(N, M), FALSE)
  absErrors <- abs(prices-prices[1])
  relErrors <- absErrors/prices[1]
  perErrors <- relErrors*100
  output <- cbind(prices, absErrors, relErrors, perErrors)
  rownames(output) <- c("exact", "monte-carlo", "pde")
  colnames(output) <- c("price", "abs-error", "rel-error", "% error")
  return(output)

}


#' Test Merton pricer for European option prices
#'
#' @param strike the strike price of the option
#' @param maturity the maturity in trading years until expiration
#' @param type type of option, "call" or "put"
#' @param spot the current spot price
#' @param rate the risk-neutral rate
#' @param div the continuous dividend yield rate
#' @param volat the volatility level
#' @param lambda the mean number of jumps per year
#' @param jm the mean jump size
#' @param jv the jump size volatility
#' @param N time resolution
#' @param M space resolution
#'
#' @description {Verify convergence between the three methods: analytic, Monte-Carlo and PDE}
#' @return matrix
#' @export testMertonEuro
testMertonEuro <- function(strike, maturity, type, spot, rate, div, volat, lambda, jm, jv, N = 300, M = 300)
{
  prices <- matrix(0, 3)
  prices[1] <- analyticMertonPrice(strike, maturity, type, spot, rate, div, volat, lambda, jm, jv)
  prices[2] <- monteCarloMertonPrice(strike, maturity, type, spot, rate, div, volat, lambda, jm, jv)
  prices[3] <- pricerPIDE(strike, maturity, type, spot, rate, div, volat, lambda, "norm", c(jm, jv), c(N, M), FALSE)
  absErrors <- abs(prices-prices[1])
  relErrors <- absErrors/prices[1]
  perErrors <- relErrors*100
  output <- cbind(prices, absErrors, relErrors, perErrors)
  rownames(output) <- c("exact", "monte-carlo", "pide")
  colnames(output) <- c("price", "abs-error", "rel-error", "% error")
  return(output)

}

#' Test Kou pricer for European option prices
#'
#' @param strike the strike price of the option
#' @param maturity the maturity in trading years until expiration
#' @param type type of option, "call" or "put"
#' @param spot the current spot price
#' @param rate the risk-neutral rate
#' @param div the continuous dividend yield rate
#' @param volat the volatility level
#' @param lambda the mean number of jumps per year
#' @param p the probability of jump upward
#' @param alpha the mean jump size up
#' @param beta the mean jump size down
#' @param N time resolution
#' @param M space resolution
#'
#' @description {Verify convergence between the three methods: analytic, Monte-Carlo and PDE}
#' @return matrix
#' @export testKouEuro
testKouEuro <- function(strike, maturity, type, spot, rate, div, volat, lambda, p, alpha, beta, N = 300, M = 300)
{
  prices <- matrix(0, 2)
  # prices[1] <- analyticMertonPrice(strike, maturity, type, spot, rate, div, volat, lambda, jm, jv)
  prices[1] <- monteCarloKouPrice(strike, maturity, type, spot, rate, div, volat, lambda, c(p, alpha, beta, 0, 0))
  prices[2] <- pricerPIDE(strike, maturity, type, spot, rate, div, volat, lambda, "kou", c(p, alpha, beta), c(N, M), FALSE)
  absErrors <- abs(prices-prices[1])
  relErrors <- absErrors/prices[1]
  perErrors <- relErrors*100
  output <- cbind(prices, absErrors, relErrors, perErrors)
  rownames(output) <- c("monte-carlo", "pide")
  colnames(output) <- c("price", "abs-error", "rel-error", "% error")
  return(output)

}

#' Test Displaced-Kou pricer for European option prices
#'
#' @param strike the strike price of the option
#' @param maturity the maturity in trading years until expiration
#' @param type type of option, "call" or "put"
#' @param spot the current spot price
#' @param rate the risk-neutral rate
#' @param div the continuous dividend yield rate
#' @param volat the volatility level
#' @param lambda the mean number of jumps per year
#' @param p the probability of jump upward
#' @param alpha the mean jump size up
#' @param beta the mean jump size down
#' @param ku displacement upward
#' @param kd displacement downard
#' @param N time resolution
#' @param M space resolution
#'
#' @description {Verify convergence between the three methods: analytic, Monte-Carlo and PDE}
#' @return matrix
#' @export testDisplacedKouEuro
testDisplacedKouEuro <- function(strike, maturity, type, spot, rate, div, volat, lambda, p, alpha, beta, ku, kd, N = 300, M = 300)
{
  prices <- matrix(0, 2)
  # prices[1] <- analyticMertonPrice(strike, maturity, type, spot, rate, div, volat, lambda, jm, jv)
  prices[1] <- monteCarloKouPrice(strike, maturity, type, spot, rate, div, volat, lambda, c(p, alpha, beta, ku, kd))
  prices[2] <- pricerPIDE(strike, maturity, type, spot, rate, div, volat, lambda, "dkou", c(p, alpha, beta, ku, kd), c(N, M), FALSE)
  absErrors <- abs(prices-prices[1])
  relErrors <- absErrors/prices[1]
  perErrors <- relErrors*100
  output <- cbind(prices, absErrors, relErrors, perErrors)
  rownames(output) <- c("monte-carlo", "pide")
  colnames(output) <- c("price", "abs-error", "rel-error", "% error")
  return(output)

}
