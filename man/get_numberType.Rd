% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_attributes_table.R
\name{get_numberType}
\alias{get_numberType}
\title{Returns the numberType (either "real", "integer", "whole", or "natural") of input values}
\usage{
get_numberType(values)
}
\arguments{
\item{values}{A vector of values. If vector is non-numeric will return NA}
}
\value{
The numberType of \code{values} (either "real", "integer", "whole", or "natural").
}
\description{
Returns the numberType (either "real", "integer", "whole", or "natural") of input values
}
\examples{
\dontrun{
# To get numberType for each column in a data.frame \\code{df}:
unlist(lapply(df, function(x) get_numberType(x)))
}
}
