## a simple regression tree growing implementation
grow.regtree.frac <- function(formula, data, minvar=0.005, minsplit=2, maxdepth=8)
{
  nmn <- function(n) { nodemap[,"node"]==n }            # nodemap entries for node n
  inn <- function(n)
  { nodemap[nodemap[,"node"]==n,"instance"] }                  # instances at node n
  wgn <- function(n) { nodemap[nodemap[,"node"]==n,"weight"] }   # weights at node n

  init <- function()
  {
    tree <<- data.frame(node=1, attribute=NA, value=NA, target=NA,
                        count=NA, mean=NA, variance=NA)
    nodemap <<- cbind(instance=1:nrow(data), node=rep(1, nrow(data)),
                      weight=rep(1, nrow(data)))
    n <<- 1
  }

  next.node <- function(n)
  {
    if (any(opn <- tree$node>n))
      min(tree$node[opn])
    else Inf
  }

  target.summary <- function(n)
  {
    tree$count[tree$node==n] <<- sum(wgn(n))
    tree$mean[tree$node==n] <<- weighted.mean(data[inn(n),target], wgn(n))
    tree$variance[tree$node==n] <<- weighted.var1(data[inn(n),target], wgn(n))
  }

  target.value <- function(n)
  {
    tree$target[tree$node==n] <<- tree$mean[tree$node==n]
  }

  stop.criteria <- function(n)
  {
    n>=2^maxdepth || tree$count[tree$node==n]<minsplit ||
      tree$variance[tree$node==n]<minvar
  }

  split.eval <- function(av, sv, tv, w)
  {
    cond <- if (is.numeric(av)) av<=as.numeric(sv) else av==sv
    cond1 <- !is.na(av) & cond   # true split outcome
    cond0 <- !is.na(av) & !cond  # false split outcome

    v1 <- tv[cond1]
    n1 <- sum(w[cond1])
    w1 <- w[cond1]
    v0 <- tv[cond0]
    n0 <- sum(w[cond0])
    w0 <- w[cond0]
    vm <- tv[is.na(av)]
    nm <- sum(w[is.na(av)])
    wm <- w[is.na(av)]

    if (nm>0)
    {
      p1 <- if (n1+n0>0) n1/(n1+n0) else 0.5
      p0 <- 1-p1
      v1 <- c(v1, vm)
      w1 <- c(w1, p1*wm)
      v0 <- c(v0, vm)
      w0 <- c(w0, p0*wm)
    }

    if (n1>0 && n0>0)
      weighted.dispersion(v1, v0, w1, w0, disp=weighted.var1)
    else
      Inf
  }

  split.select <- function(n)
  {
    splits <- data.frame()
    for (attribute in attributes)
    {
      uav <- sort(unique(data[inn(n),attribute]))
      if (length(uav)>1)
        splits <- rbind(splits,
                        data.frame(attribute=attribute,
                                   value=if (is.numeric(uav))
                                           midbrk(uav)
                                         else as.character(uav),
                                   stringsAsFactors=FALSE))
    }

    if (nrow(splits)>0)
      splits$eval <- sapply(1:nrow(splits),
                            function(s)
                            split.eval(data[inn(n),splits$attribute[s]],
                                       splits$value[s],
                                       data[inn(n),target], wgn(n)))
    if ((best.eval <- min(splits$eval))<Inf)
      tree[tree$node==n,2:3] <<- splits[which.min(splits$eval),1:2]
    best.eval
  }

  split.apply <- function(n)
  {
    tree <<- rbind(tree,
                   data.frame(node=(2*n):(2*n+1), attribute=NA, value=NA, target=NA,
                              count=NA, mean=NA, variance=NA))

    av <- data[nodemap[,"instance"],tree$attribute[tree$node==n]]
    cond <- if (is.numeric(av)) av<=as.numeric(tree$value[tree$node==n])
            else av==tree$value[tree$node==n]
    cond1 <- !is.na(av) & cond   # true split outcome
    cond0 <- !is.na(av) & !cond  # false split outcome

    n1 <- sum(nodemap[nmn(n) & cond1,"weight"])
    n0 <- sum(nodemap[nmn(n) & cond0,"weight"])
    nm <- sum(nodemap[nmn(n) & is.na(av),"weight"])

    nodemap[nmn(n) & cond1,"node"] <<- 2*n
    nodemap[nmn(n) & cond0,"node"] <<- 2*n+1

    if (nm>0)
    {
      p1 <- if (n1+n0>0) n1/(n1+n0) else 0.5
      p0 <- 1-p1
      newnn <- nodemap[nmn(n) & is.na(av),,drop=FALSE]
      nodemap[nmn(n) & is.na(av),"weight"] <<-
        p1*nodemap[nmn(n) & is.na(av),"weight"]
      nodemap[nmn(n) & is.na(av),"node"] <<- 2*n
      newnn[,"weight"] <- p0*newnn[,"weight"]
      newnn[,"node"] <- 2*n+1
      nodemap <<- rbind(nodemap, newnn)
    }
  }

  tree <- nodemap <- n <- NULL
  target <- y.var(formula)
  attributes <- x.vars(formula, data)

  init()
  while (is.finite(n))
  {
    target.summary(n)
    target.value(n)
    if (!stop.criteria(n))
      if (split.select(n)<Inf)
        split.apply(n)
    n <- next.node(n)
  }
  `class<-`(tree, "regtree.frac")
}


## convert a regtree.frac object to a data frame
as.data.frame.regtree.frac <- function(x, row.names=NULL, optional=FALSE, ...)
{ as.data.frame(unclass(x), row.names=row.names, optional=optional) }


if (FALSE)
{

  # grow a regression tree for the weatherr data with missing attribute values
weatherrm <- weatherr
weatherrm$outlook[1] <- NA
weatherrm$humidity[1:2] <- NA
treem <- grow.regtree.frac(playability~., weatherrm)

  # data frame conversion
as.data.frame(treem)

}
