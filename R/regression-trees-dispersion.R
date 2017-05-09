weighted.dispersion <- function(v1, v0, w1, w0, disp=var1)
{
  if (missing(w1) || missing(w0))
    weighted.mean(c(disp(v1), disp(v0)), c(length(v1), length(v0)))
  else
    weighted.mean(c(disp(v1, w1), disp(v0, w0)), c(length(v1), length(v0)))
}


if (FALSE)
{

  # weighted dispersion of playability for outlook=overcast and outlook!=overcast
weighted.dispersion(weatherr$playability[weatherr$outlook=="overcast"],
                    weatherr$playability[weatherr$outlook!="overcast"])

}
