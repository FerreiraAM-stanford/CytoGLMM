/*
 * Low-dimensional covariance multinomial regression
 * Author: Christof Seiler
 */
data {
  int<lower=1> n; // num of cells
  int<lower=1> d; // num of markers
  int<lower=1> p; // num of explanatory variables (including intercept)
  int<lower=0> Y[n,d]; // observed cell counts
  vector[p] X[n]; // design matrix
}
parameters {
  real gamma[n];
  vector<lower=0>[d] sigma;
  matrix[d,p] A;
  matrix[d,p] B;
  vector[d] theta[n];
}
model {
  gamma ~ normal(0,1);
  to_vector(A) ~ normal(0, 1);
  to_vector(B) ~ normal(0, 1);
  for (i in 1:n) {
    theta[i] ~ normal(A * X[i] + gamma[i] * B * X[i], sigma);
    Y[i] ~ multinomial(softmax(theta[i]));
  }
  //Y[i] ~ multinomial(softmax(B * X[i]));
}