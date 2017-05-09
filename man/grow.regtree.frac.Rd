\name{grow.regtree.frac}
\alias{grow.regtree.frac}
\alias{as.data.frame.regtree.frac}

\title{Example functions from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{Example functions from Chapter 9 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.7, Example 9.7.1.}

\arguments{See Section 9.7, Example 9.7.1.}

\details{See Section 9.7, Example 9.7.1.}

\value{See Section 9.7, Example 9.7.1.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{predict.regtree.frac}}
\code{\link{grow.regtree}}
\code{\link{grow.modtree}}
}

\examples{
data(weatherr, package="dmr.data")

  # grow a regression tree for the weatherr data with missing attribute values
weatherrm <- weatherr
weatherrm$outlook[1] <- NA
weatherrm$humidity[1:2] <- NA
treem <- grow.regtree.frac(playability~., weatherrm)

  # data frame conversion
dftreem <- as.data.frame(treem)

}

\keyword{models}
