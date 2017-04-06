library(digest)
library(RSQLite)
library(Rmpfr)

options(help_type="html")
options(encoding="UTF-8")

# Substitute your workstation's path here.
glotPath_sc <- "C:/Program Files/Alteryx/bin/Messages/"
glotFile_sc <- "Glot.dat" 
overrideFile_sc <- "override.txt"
# You can put the word 'Arrows', 'English', 'French', or 'German' in 
# override.txt, depending on which you want to test.
glotDatabaseTable_sc <- "Arrows"

ap_xmsg <- function(
  in.targetString_sc,
  in.firstBindVariable_sc = NULL,
  in.secondBindVariable_sc = NULL,
  in.thirdBindVariable_sc = NULL,
  in.fourthBindVariable_sc = NULL,
  in.fifthBindVariable_sc = NULL,
  in.sixthBindVariable_sc = NULL
){
  # Make sure we don't have a non-null bind-variable value after a null one.
  nullFound_sb <- FALSE
  bindVariableCount_si <- 0
  for (i in 1:6) {
    if (
      is.null(
        switch(
          i,
          in.firstBindVariable_sc,
          in.secondBindVariable_sc,
          in.thirdBindVariable_sc,
          in.fourthBindVariable_sc,
          in.fifthBindVariable_sc,
          in.sixthBindVariable_sc
        )
      )
    ) {
      nullFound_sb <- TRUE # Could overwrite TRUE with TRUE, which is OK.
    } else {
      bindVariableCount_si <- i
      if(nullFound_sb) {
        # Don't wrap the following message string in XMSG()!
        stop.Alteryx(message.string = 
                       "Non-null bind-variable value after null value passed to XMSG!"
        )
      }
    }
  }
  # Convert to UTF-16.
  utf16RawTargetString_vr <- iconv(
    x = in.targetString_sc,
    from = "", # default encoding
    to = "UTF-16LE", # Alteryx is little endian.
    toRaw = TRUE # works with digest() below
  )[[1]] # iconv() produces a list; we just want the first entry.
  # Compute MD5 hash value (hex).
  md5HashValue_sc <- digest(
    object = utf16RawTargetString_vr, 
    algo = "md5", 
    serialize = FALSE # object is raw, so don't serialize
  )
  # The Glot library keeps only the rightmost 15 hex digits.
  md5HashValueRightmost15HexDigits_sc <- substr(
    x = md5HashValue_sc, 
    start = nchar(md5HashValue_sc) - 14, # 14 to get last 15
    stop = nchar(md5HashValue_sc)
  )
  md5HashValueRightmost15DigitsAsDecimal_sc <- mpfr(md5HashValueRightmost15HexDigits_sc, base = 16)
  md5HashValueRightmost15DigitsAsDecimal_sc <- formatMpfr(
    x = md5HashValueRightmost15DigitsAsDecimal_sc, 
    drop0trailing = TRUE
  )  
  # Figure out which table to query.
  glotTableName_sc <- read.table(
    file = paste0(glotPath_sc, overrideFile_sc), 
    header = FALSE, 
    nrows = 1, 
    blank.lines.skip = TRUE, 
    stringsAsFactors = FALSE
  )[1, 1]
  # Get translated string.
  queryString_sc <- paste0(
    'select Message from ',
    glotTableName_sc,
    ' where MsgKey = ',
    md5HashValueRightmost15DigitsAsDecimal_sc
  )
  db_connection_o = dbConnect(
    drv = dbDriver("SQLite"),
    dbname = paste0(glotPath_sc, glotFile_sc)
  )
  # The query returns a string in the native character set.
  translatedString_sc <- enc2utf8(
    dbGetQuery(
      conn = db_connection_o,
      statement = queryString_sc
    )[1]$Message # Result comes back in a data frame.
  )
  dbDisconnect(db_connection_o)
  # length() tests for existence of row in DB, not string length.
  if(length(translatedString_sc) == 0) {
    translatedString_sc <- enc2utf8(in.targetString_sc)
  }
  # Replace bind variables with their values.
  bindVariable_vc <- c(
    in.firstBindVariable_sc,
    in.secondBindVariable_sc,
    in.thirdBindVariable_sc,
    in.fourthBindVariable_sc,
    in.fifthBindVariable_sc,
    in.sixthBindVariable_sc
  ) # This will only include the non-null values.
  if(bindVariableCount_si > 0){
    bindVariable_vc <- enc2utf8(bindVariable_vc)
    boundTranslatedString_sc <- sapply(
      X = 1:bindVariableCount_si,
      FUN = function(bindVariableIndex_si){
        gsub(
          pattern = paste0('@', bindVariableIndex_si),
          replacement = bindVariable_vc[bindVariableIndex_si],
          x = translatedString_sc
        )
      }
    )
  }
  else{
    boundTranslatedString_sc <- translatedString_sc
  }
  return(boundTranslatedString_sc)
}
  
XMSG <- function(
  in.targetString_sc,
  in.firstBindVariable_sc = NULL,
  in.secondBindVariable_sc = NULL,
  in.thirdBindVariable_sc = NULL,
  in.fourthBindVariable_sc = NULL,
  in.fifthBindVariable_sc = NULL,
  in.sixthBindVariable_sc = NULL
){
  # If in Alteryx, call the AlteryxRDataX wrapper for C++ XMSG().
  if(exists("AlteryxDataOutput", .GlobalEnv)){
  #   return(
  #     AlteryxRDataX::XMSG(
  #       targetString_sc = targetString_sc,
  #       in.firstBindVariable_sc = in.firstBindVariable_sc,
  #       in.secondBindVariable_sc = in.secondBindVariable_sc,
  #       in.thirdBindVariable_sc = in.thirdBindVariable_sc,
  #       in.fourthBindVariable_sc = in.fourthBindVariable_sc,
  #       in.fifthBindVariable_sc = in.fifthBindVariable_sc,
  #       in.sixthBindVariable_sc = in.sixthBindVariable_sc
  #     )
  #   )
    # Do this until AlteryxRDataX::XMSG works.
    return(
      ap_xmsg(
        in.targetString_sc = in.targetString_sc,
        in.firstBindVariable_sc = in.firstBindVariable_sc,
        in.secondBindVariable_sc = in.secondBindVariable_sc,
        in.thirdBindVariable_sc = in.thirdBindVariable_sc,
        in.fourthBindVariable_sc = in.fourthBindVariable_sc,
        in.fifthBindVariable_sc = in.fifthBindVariable_sc,
        in.sixthBindVariable_sc = in.sixthBindVariable_sc
      )
    )
  }
  # Not in Alteryx, so query the Glot database directly.
  return(
    ap_xmsg(
      in.targetString_sc = in.targetString_sc,
      in.firstBindVariable_sc = in.firstBindVariable_sc,
      in.secondBindVariable_sc = in.secondBindVariable_sc,
      in.thirdBindVariable_sc = in.thirdBindVariable_sc,
      in.fourthBindVariable_sc = in.fourthBindVariable_sc,
      in.fifthBindVariable_sc = in.fifthBindVariable_sc,
      in.sixthBindVariable_sc = in.sixthBindVariable_sc
    )
  )
}
