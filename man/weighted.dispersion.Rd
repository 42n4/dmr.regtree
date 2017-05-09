\name{weighted.dispersion}
\alias{weighted.dispersion}

\title{An example function from the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R}

\description{An example function from Chapter 9 of the book Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. See Appendix B or http://www.wiley.com/go/data_mining_algorithms for more details.}

\usage{See Section 9.3, Example 9.3.5.}

\arguments{See Section 9.3, Example 9.3.5.}

\details{See Section 9.3, Example 9.3.5.}

\value{See Section 9.3, Example 9.3.5.}

\references{Cichosz, P. (2015): Data Mining Algorithms: Explained Using R. Wiley.}

\author{
Pawel Cichosz <p.cichosz@elka.pw.edu.pl>
}

\note{
}


\seealso{
\code{\link{grow.regtree}}
\code{\link{var1}}
}

\examples{
data(weatherr, package="dmr.data")

  # weighted dispersion of playability for outlook=overcast and outlook!=overcast
weighted.dispersion(weatherr$playability[weatherr$outlook=="overcast"],
                    weatherr$playability[weatherr$outlook!="overcast"])
}

\keyword{models}
