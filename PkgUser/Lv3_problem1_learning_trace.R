example(trace)
?trace


f <- function(x, y) {
  y <- pmax(y, 0.001)
  if (x > 0) x ^ y else stop("x must be positive")
}

# Look f
f

## arrange to call the browser on entering and exiting
## function f
trace("f", quote(browser(skipCalls = 4)),
      exit = quote(browser(skipCalls = 4)))

# Look f
f

# Look body(f)
body(f)

# call f
f(3,4)
untrace("f")
f(3,4)


# an other sample code in help
as.list(body(f))
trace("f", quote(print(c(x,y))), at = c(3))

# call f
f(3,4)
untrace("f")
f(3,4)

