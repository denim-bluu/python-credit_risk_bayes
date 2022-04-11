data {                          
int<lower=0> N;                // number of observations
int<lower=0> K;                // number of regressors
matrix[N, K] X;                // matrix of regressors
int<lower=0,upper=1> y[N];     // response variable
int<lower=1> p_alpha_df;       // prior degrees of freedom for alpha
real p_alpha_loc;              // prior location for alpha
real<lower=0> p_alpha_scale;   // prior scale for alpha
int<lower=1> p_beta_df;        // prior degrees of freedom for beta
real p_beta_loc;               // prior location for beta
real<lower=0> p_beta_scale;    // prior scale for beta
}
parameters {
real alpha;                    // intercept
vector[K] beta;                // coefficients
}
transformed parameters {
    // linear predictor
    vector[N] eta;
    eta = alpha + X * beta;
}
model {
    alpha ~ student_t(p_alpha_df, p_alpha_loc, p_alpha_scale);
    beta ~ student_t(p_beta_df, p_beta_loc, p_beta_scale);
    y ~ bernoulli_logit(eta);
}
generated quantities {
    vector[N] log_lik;
    for (i in 1:N)
        log_lik[i] = bernoulli_logit_lpmf(y[i] | eta[i]);
}
