\name{grow.modtree}
\alias{grow.modtree}
\alias{as.data.frame.modtree}

\title{Example functions from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{Example functions from Chapter 8 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.8, Example 9.8.1.}

\arguments{See Section 9.8, Example 9.8.1.}

\details{See Section 9.8, Example 9.8.1.}

\value{See Section 9.8, Example 9.8.1.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{predict.modtree}}
\code{\link{grow.regtree}}
}

\examples{
data(weatherr, package="dmr.data")

  # grow a model tree for the weatherr data
mtree <- grow.modtree(playability~., weatherr)
  # tree structure
mtree$structure

}

\keyword{models}
