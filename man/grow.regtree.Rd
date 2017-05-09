\name{grow.regtree}
\alias{grow.regtree}
\alias{as.data.frame.regtree}

\title{Example functions from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{Example functions from Chapter 9 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.3, Example 9.3.8.}

\arguments{See Section 9.3, Example 9.3.8.}

\details{See Section 9.3, Example 9.3.8.}

\value{See Section 9.3, Example 9.3.8.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{predict.regtree}}
\code{\link{grow.regtree.frac}}
\code{\link{grow.modtree}}
}

\examples{
data(weatherr, package="dmr.data")

  # grow a regression tree for the weatherr data
tree <- grow.regtree(playability~., weatherr)

  # data frame conversion
dftree <- as.data.frame(tree)

}

\keyword{models}
