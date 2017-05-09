## a simple model tree growing implementation
grow.modtree <- function(formula, data, minvar=0.005, minsplit=2, maxdepth=8)
{
  init <- function()
  {
    tree <<- data.frame(node=1, attribute=NA, value=NA,
                        count=NA, mean=NA, variance=NA)
    models <<- list()
    nodemap <<- rep(1, nrow(data))
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
    tree$count[tree$node==n] <<- sum(nodemap==n)
    tree$mean[tree$node==n] <<- mean(data[[target]][nodemap==n])
    tree$variance[tree$node==n] <<- var1(data[[target]][nodemap==n])
  }

  model <- function(n)
  {
    attrs <- drop1val(attributes, data[nodemap==n,])
    models <<- c(models,
                 list(lm(make.formula(target, if (length(attrs)==0) 1 else attrs),
                         data[nodemap==n,])))
  }

  stop.criteria <- function(n)
  {
    n>=2^maxdepth || tree$count[tree$node==n]<minsplit ||
      tree$variance[tree$node==n]<minvar
  }

  split.eval <- function(av, sv, tv)
  {
    cond <- !is.na(av) & (if (is.numeric(av)) av<=as.numeric(sv) else av==sv)
    v1 <- tv[cond]
    n1 <- sum(cond)
    v0 <- tv[!cond]
    n0 <- sum(!cond)
    if (n1>0 && n0>0)
      weighted.dispersion(v1, v0)
    else
      Inf
  }

  split.select <- function(n)
  {
    splits <- data.frame()
    for (attribute in attributes)
    {
      uav <- sort(unique(data[nodemap==n,attribute]))
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
                            split.eval(data[nodemap==n,splits$attribute[s]],
                                       splits$value[s],
                                       data[nodemap==n,target]))
    if ((best.eval <- min(splits$eval))<Inf)
      tree[tree$node==n,2:3] <<- splits[which.min(splits$eval),1:2]
    best.eval
  }

  split.apply <- function(n)
  {
    tree <<- rbind(tree,
                   data.frame(node=(2*n):(2*n+1), attribute=NA, value=NA,
                              count=NA, mean=NA, variance=NA))

    av <- data[[tree$attribute[tree$node==n]]]
    cond <- !is.na(av) & (if (is.numeric(av))
                            av<=as.numeric(tree$value[tree$node==n])
                          else av==tree$value[tree$node==n])
    nodemap[nodemap==n & cond] <<- 2*n
    nodemap[nodemap==n & !cond] <<- 2*n+1
  }

  tree <- models <- nodemap <- n <- NULL
  target <- y.var(formula)
  attributes <- x.vars(formula, data)

  init()
  while (is.finite(n))
  {
    target.summary(n)
    model(n)
    if (! stop.criteria(n))
      if (split.select(n)<Inf)
        split.apply(n)
    n <- next.node(n)
  }
  `class<-`(list(structure=tree, models=models), "modtree")
}


if (FALSE)
{

  # grow a model tree for the weatherr data
mtree <- grow.modtree(playability~., weatherr)
  # tree structure
mtree$structure

}
