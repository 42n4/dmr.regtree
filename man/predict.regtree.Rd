\name{predict.regtree}
\alias{predict.regtree}

\title{An example function from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{An example function from Chapter 9 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.5, Example 9.5.1.}

\arguments{See Section 9.5, Example 9.5.1.}

\details{See Section 9.5, Example 9.5.1.}

\value{See Section 9.5, Example 9.5.1.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{grow.regtree}}
\code{\link{predict.regtree.frac}}
\code{\link{predict.modtree}}
}

\examples{
data(weatherr, package="dmr.data")

  # grow a regression tree for the weatherr data
tree <- grow.regtree(playability~., weatherr)

  # regression tree prediction for the weatherr data
predict(tree, weatherr)

}

\keyword{models}
