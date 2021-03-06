\name{growth}
\alias{growth}
\title{Fit Growth Curve Models}
\description{
Fit a Growth Curve model.}
\usage{
growth(model = NULL, data = NULL, ordered = NULL, sampling.weights = NULL,
       sample.cov = NULL, sample.mean = NULL, sample.nobs = NULL, 
       group = NULL, cluster = NULL, 
       constraints = "", WLS.V = NULL, NACOV = NULL,
       ...) 
}
\arguments{
\item{model}{A description of the user-specified model. Typically, the model
    is described using the lavaan model syntax. See            
    \code{\link{model.syntax}} for more information. Alternatively, a
    parameter table (eg. the output of the \code{lavaanify()} function) is also
    accepted.}
\item{data}{An optional data frame containing the observed variables used in
    the model. If some variables are declared as ordered factors, lavaan will
    treat them as ordinal variables.}
\item{ordered}{Character vector. Only used if the data is in a data.frame. 
    Treat these variables as ordered (ordinal) variables, if they are 
    endogenous in the model. Importantly, all other variables will be treated 
    as numeric (unless they are declared as ordered in the original data.frame.)}
\item{sampling.weights}{A variable name in the data frame containing
   sampling weight information. Currently only available for non-clustered 
   data. Sampling weights must be nonnegative, and sum to the total number
   of observations. If this is not the case, the weights will be rescaled
   so that they sum to the total number of observations. Only available
   if estimator is ML in combination with robust standard errors and
   a robust test statistic. By default, the estimator will be
   \code{"MLR"}.}
\item{sample.cov}{Numeric matrix. A sample variance-covariance matrix.
    The rownames and/or colnames must contain the observed variable names.
    For a multiple group analysis, a list with a variance-covariance matrix
    for each group. Note that if maximum likelihood estimation is used and 
    \code{likelihood="normal"}, the user provided covariance matrix is
    internally rescaled by multiplying it with a factor (N-1)/N, to ensure
    that the covariance matrix has been divided by N. This can be turned off
    by setting the \code{sample.cov.rescale} argument to \code{FALSE}.}
\item{sample.mean}{A sample mean vector. For a multiple group analysis,
    a list with a mean vector for each group.}
\item{sample.nobs}{Number of observations if the full data frame is missing
    and only sample moments are given. For a multiple group analysis, a list
    or a vector with the number of observations for each group.}
\item{group}{A variable name in the data frame defining the groups in a
    multiple group analysis.}
\item{cluster}{Not used yet.}
\item{constraints}{Additional (in)equality constraints not yet included in the
    model syntax. See \code{\link{model.syntax}} for more information.}
\item{WLS.V}{A user provided weight matrix to be used by estimator \code{"WLS"};
    if the estimator is \code{"DWLS"}, only the diagonal of this matrix will be
    used. For a multiple group analysis, a list with a weight matrix
    for each group. The elements of the weight matrix should be in the
    following order (if all data is continuous): first the means (if a
    meanstructure is involved), then the lower triangular elements of the
    covariance matrix including the diagonal, ordered column by column. In
    the categorical case: first the thresholds (including the means for
    continuous variables), then the slopes (if any), the variances of
    continuous variables (if any), and finally the lower triangular elements
    of the correlation/covariance matrix excluding the diagonal, ordered
    column by column.}
\item{NACOV}{A user provided matrix containing the elements of (N times)
    the asymptotic variance-covariance matrix of the sample statistics.
    For a multiple group analysis, a list with an asymptotic
    variance-covariance matrix for each group. See the \code{WLS.V}
    argument for information about the order of the elements.}
\item{...}{Many more additional options can be defined, using 'name = value'.
    See \code{\link{lavOptions}} for a complete list.}
}
\details{
    The \code{growth} function is a wrapper for the more general
    \code{\link{lavaan}} function, using the following default arguments:
    \code{meanstructure = TRUE}, 
    \code{int.ov.free = FALSE}, \code{int.lv.free = TRUE},
    \code{auto.fix.first = TRUE} (unless \code{std.lv = TRUE}),
    \code{auto.fix.single = TRUE}, \code{auto.var = TRUE},
    \code{auto.cov.lv.x = TRUE}, 
    \code{auto.th = TRUE}, \code{auto.delta = TRUE},
    and \code{auto.cov.y = TRUE}.
}
\value{
  An object of class \code{\linkS4class{lavaan}}, for which several methods
  are available, including a \code{summary} method.
}
\references{
Yves Rosseel (2012). lavaan: An R Package for Structural Equation
Modeling. Journal of Statistical Software, 48(2), 1-36. URL
http://www.jstatsoft.org/v48/i02/.}
\seealso{
\code{\link{lavaan}}
}
\examples{
## linear growth model with a time-varying covariate
model.syntax <- '
  # intercept and slope with fixed coefficients
    i =~ 1*t1 + 1*t2 + 1*t3 + 1*t4
    s =~ 0*t1 + 1*t2 + 2*t3 + 3*t4

  # regressions
    i ~ x1 + x2
    s ~ x1 + x2

  # time-varying covariates
    t1 ~ c1
    t2 ~ c2
    t3 ~ c3
    t4 ~ c4
'

fit <- growth(model.syntax, data=Demo.growth)
summary(fit)
}
