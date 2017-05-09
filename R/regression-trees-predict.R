## regression tree prediction
predict.regtree <- function(tree, data)
{
  descend <- function(n)
  {
    if (!is.na(tree$attribute[tree$node==n]))  # unless reached a leaf
    {
      av <- data[[tree$attribute[tree$node==n]]]
      cond <- !is.na(av) & (if (is.numeric(av))
                              av<=as.numeric(tree$value[tree$node==n])
                            else av==tree$value[tree$node==n])
      nodemap[nodemap==n & cond] <<- 2*n
      nodemap[nodemap==n & !cond] <<- 2*n+1
      descend(2*n)
      descend(2*n+1)
    }
  }

  nodemap <- rep(1, nrow(data))
  descend(1)
  tree$target[match(nodemap, tree$node)]
}


if (FALSE)
{

  # regression tree prediction for the weatherr data
predict(tree, weatherr)

}
