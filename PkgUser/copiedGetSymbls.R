copiedGetSymbls <- function (Symbols = NULL, env = parent.frame(), reload.Symbols = FALSE, 
          verbose = FALSE, warnings = TRUE, src = "yahoo", symbol.lookup = TRUE, 
          auto.assign = getOption("getSymbols.auto.assign", TRUE), 
          ...) 
{
  if (getOption("getSymbols.warning4.0", TRUE)) {
    message(paste("    As of 0.4-0,", sQuote("getSymbols"), 
                  "uses env=parent.frame() and\n", "auto.assign=TRUE by default.\n\n", 
                  "This  behavior  will be  phased out in 0.5-0  when the call  will\n", 
                  "default to use auto.assign=FALSE. getOption(\"getSymbols.env\") and \n", 
                  "getOptions(\"getSymbols.auto.assign\") are now checked for alternate defaults\n\n", 
                  "This message is shown once per session and may be disabled by setting \n", 
                  "options(\"getSymbols.warning4.0\"=FALSE). See ?getSymbols for more details."))
    options(getSymbols.warning4.0 = FALSE)
  }
  importDefaults("getSymbols")
  if (missing(env) && !is.null(getOption("getSymbols.env"))) 
    env <- getOption("getSymbols.env")
  if (is.null(env)) 
    auto.assign <- FALSE
  if (!auto.assign && length(Symbols) > 1) 
    stop("must use auto.assign=TRUE for multiple Symbols requests")
  force(Symbols)
  if (symbol.lookup && missing(src)) {
    symbols.src <- getOption("getSymbols.sources")
  }
  else {
    symbols.src <- src[1]
  }
  if (is.character(Symbols)) {
    Symbols <- unlist(strsplit(Symbols, ";"))
    tmp.Symbols <- vector("list")
    for (each.symbol in Symbols) {
      if (each.symbol %in% names(symbols.src)) {
        tmp.src <- symbols.src[[each.symbol]]$src[1]
        if (is.null(tmp.src)) {
          tmp.Symbols[[each.symbol]] <- src[1]
        }
        else {
          tmp.Symbols[[each.symbol]] <- tmp.src
        }
      }
      else {
        tmp.Symbols[[each.symbol]] <- src[1]
      }
    }
    Symbols <- tmp.Symbols
  }
  old.Symbols <- NULL
  if (auto.assign && exists(".getSymbols", env, inherits = FALSE)) {
    old.Symbols <- get(".getSymbols", env)
  }
  if (reload.Symbols) {
    Symbols <- c(Symbols, old.Symbols)[unique(names(c(Symbols, 
                                                      old.Symbols)))]
  }
  if (!auto.assign && length(Symbols) > 1) 
    stop("must use auto.assign=TRUE when reloading multiple Symbols")
  if (!is.null(Symbols)) {
    Symbols <- as.list(unlist(lapply(unique(as.character(Symbols)), 
                                     FUN = function(x) {
                                       Symbols[Symbols == x]
                                     })))
    all.symbols <- list()
    for (symbol.source in unique(as.character(Symbols))) {
      current.symbols <- names(Symbols[Symbols == symbol.source])
      symbols.returned <- do.call(paste("getSymbols.", 
                                        symbol.source, sep = ""), list(Symbols = current.symbols, 
                                                                       env = env, verbose = verbose, warnings = warnings, 
                                                                       auto.assign = auto.assign, ...))
      if (!auto.assign) 
        return(symbols.returned)
      for (each.symbol in symbols.returned) all.symbols[[each.symbol]] <- symbol.source
    }
    req.symbols <- names(all.symbols)
    all.symbols <- c(all.symbols, old.Symbols)[unique(names(c(all.symbols, 
                                                              old.Symbols)))]
    if (auto.assign) {
      assign(".getSymbols", all.symbols, env)
      return(req.symbols)
    }
  }
  else {
    warning("no Symbols specified")
  }
}