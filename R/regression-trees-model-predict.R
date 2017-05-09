## model tree prediction
predict.modtree <- function(mtree, data, m=10)
{
  descend <- function(n)
  {
    predn <- predict(models[[which(tree$node==n)]], data[nodemap==n,])
    if (is.na(tree$attribute[tree$node==n]))  # reached a leaf
      pred[nodemap==n] <<- predn
    else
    {
      av <- data[[tree$attribute[tree$node==n]]]
      cond <- !is.na(av) & (if (is.numeric(av))
                              av<=as.numeric(tree$value[tree$node==n])
                            else av==tree$value[tree$node==n])
      nodemap[left <- nodemap==n & cond] <<- 2*n
      nodemap[right <- nodemap==n & !cond] <<- 2*n+1
      descend(2*n)
      descend(2*n+1)

      leftn <- match(which(left), which(left|right))
      rightn <- match(which(right), which(left|right))
      pred[left] <<- (tree$count[tree$node==2*n]*pred[left] + m*predn[leftn])/
                     (tree$count[tree$node==2*n]+m)
      pred[right] <<- (tree$count[tree$node==2*n+1]*pred[right] + m*predn[rightn])/
                      (tree$count[tree$node==2*n+1]+m)
     }
  }

  models <- mtree$models
  tree <- mtree$structure
  nodemap <- rep(1, nrow(data))
  pred <- rep(NA, nrow(data))
  descend(1)
  pred
}


if (FALSE)
{

  # model tree prediction for the weatherr data
predict(mtree, weatherr, m=2)

}
