#include <Rcpp.h>
#include "Tridiag.h"
#include "Payoffs.h"
#include "ProblemProcessor.h"

Rcpp::NumericMatrix implicitSolver(bool american, Rcpp::NumericVector payoff, std::vector<int> res, double r, double q, double v, double h, double k)
{
  int N = res[0];
  int M = res[1];
  Rcpp::NumericMatrix u(N + 1, M + 1);
  //u = u.Zero(N + 1, M + 1);
  u = ProblemProcessor::initial_cond(u, payoff);
  u = ProblemProcessor::boundary_cond(u, payoff, res);
  double a = (r - q - 0.5 * v * v) / (2 * h);
  double b = (v * v) / (2 * h * h);
  double alpha = b - a;
  double beta = -r - 2 * b;
  double delta = a + b;
  for (int i = 1; i < N + 1; i++)
  {
    // RHS of tridiagonal system
    Rcpp::NumericVector d(M - 1);
    for (int j = 0; j < M - 1; j++)
    {
      d[j] = u(i-1, j + 1);
    }
    d[0] += k*alpha * u(0, 0);
    d[M - 2] += k*delta * u(0, M);
    // Solving the system and repopulating
    Rcpp::NumericVector sol = Tridiag::thomasAlgorithm(-k * alpha, 1 - k * beta, -k * delta, d);
    u = ProblemProcessor::post_step(i, 0, u, sol, payoff, american);
  }
  return u;
}

// [[Rcpp::export]]
Rcpp::NumericMatrix implicitScheme(double strike, double maturity, std::string type, double spot, double r, double q, double v, std::vector<int> res, bool american = true)
{
  int N = res[0];
  int M = res[1];
  double B = 0.5*v*M*std::sqrt(3*maturity/N);
  double h = (2*B)/M;
  double k = (maturity/N);
  Rcpp::NumericVector x = ProblemProcessor::discretize(-B, B, M);
  Rcpp::NumericVector payoff = Payoffs::computePayoff(type, strike, spot, x, res);
  Rcpp::NumericMatrix u = implicitSolver(american, payoff, res, r, q, v, h, k);
  return u;
}

//' Price options via Black-Scholes PDE
//' @param strike the strike price of the option contract
//' @param maturity the time until maturity
//' @param type either "put" or "call
//' @param spot the spot price
//' @param r the risk free rate
//' @param q the continuous dividend yield
//' @param v the volatiltiy
//' @param res the grid resolution
//' @param american bool for american options
//'
//' @description {Compute European/American options via a finite difference solver for the
//' Black-Scholes PDE.}
//' @return numeric
//' @export blackScholesPDE
// [[Rcpp::export]]
double blackScholesPDE(double strike, double maturity, std::string type, double spot, double r, double q, double v, std::vector<int> res, bool american = true)
{
  Rcpp::NumericMatrix u = implicitScheme(strike, maturity, type, spot, r, q, v, res, american);
  return u(res[0], res[1]/2);
}