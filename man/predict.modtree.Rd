\name{predict.modtree}
\alias{predict.modtree}

\title{An example function from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{An example function from Chapter 9 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.8, Example 9.8.2.}

\arguments{See Section 9.8, Example 9.8.2.}

\details{See Section 9.8, Example 9.8.2.}

\value{See Section 9.8, Example 9.8.2.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{grow.modtree}}
\code{\link{predict.regtree}}
}

\examples{
data(weatherr, package="dmr.data")

  # grow a model tree for the weatherr data
mtree <- grow.modtree(playability~., weatherr)

  # model tree prediction for the weatherr data
predict(mtree, weatherr, m=2)
}

\keyword{models}
