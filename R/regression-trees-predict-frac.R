## regression tree prediction
## with missing value support using fractional instances
predict.regtree.frac <- function(tree, data)
{
  nmn <- function(n) { nodemap[,"node"]==n }  # nodemap entries for node n

  descend <- function(n)
  {
    if (!is.na(tree$attribute[tree$node==n]))  # unless reached a leaf
    {
      av <- data[nodemap[,"instance"],tree$attribute[tree$node==n]]
      cond <- if (is.numeric(av)) av<=as.numeric(tree$value[tree$node==n])
              else av==tree$value[tree$node==n]
      cond1 <- !is.na(av) & cond   # true split outcome
      cond0 <- !is.na(av) & !cond  # false split outcome

      nodemap[nmn(n) & cond1, "node"] <<- 2*n
      nodemap[nmn(n) & cond0, "node"] <<- 2*n+1

      if (sum(nodemap[nmn(n) & is.na(av), "weight"])>0)
      {
        n1 <- tree$count[tree$node==2*n]
        n0 <- tree$count[tree$node==2*n+1]
        p1 <- if (n1+n0>0) n1/(n1+n0) else 0.5
        p0 <- 1-p1

        newnn <- nodemap[nmn(n) & is.na(av),,drop=FALSE]
        nodemap[nmn(n) & is.na(av),"weight"] <<-
          p1*nodemap[nmn(n) & is.na(av),"weight"]
        nodemap[nmn(n) & is.na(av), "node"] <<- 2*n
        newnn[,"weight"] <- p0*newnn[,"weight"]
        newnn[,"node"] <- 2*n+1
        nodemap <<- rbind(nodemap, newnn)
      }

      descend(2*n)
      descend(2*n+1)
    }
  }

  nodemap <- cbind(instance=1:nrow(data), node=rep(1, nrow(data)),
                   weight=rep(1, nrow(data)))
  descend(1)

  votes <- merge(nodemap, as.data.frame(tree)[,c("node", "target")])
  as.numeric(by(votes, votes$instance,
                function(v) weighted.mean(v$target, v$weight)))
}


if (FALSE)
{

  # regression tree prediction for the weatherr data with missing attribute values
predict(treem, weatherrm)

}
