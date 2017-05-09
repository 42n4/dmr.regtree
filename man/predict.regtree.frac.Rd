\name{predict.regtree.frac}
\alias{predict.regtree.frac}

\title{An example function from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{An example function from Chapter 9 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.7, Example 9.7.2.}

\arguments{See Section 9.7, Example 9.7.2.}

\details{See Section 9.7, Example 9.7.2.}

\value{See Section 9.7, Example 9.7.2.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{grow.regtree.frac}}
\code{\link{predict.regtree}}
\code{\link{predict.modtree}}
}

\examples{
data(weatherr, package="dmr.data")

  # grow a regression tree for the weatherr data with missing attribute values
weatherrm <- weatherr
weatherrm$outlook[1] <- NA
weatherrm$humidity[1:2] <- NA
treem <- grow.regtree.frac(playability~., weatherrm)

  # regression tree prediction for the weatherr data with missing attribute values
predict(treem, weatherrm)

}

\keyword{models}
