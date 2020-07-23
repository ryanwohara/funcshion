BEGIN {
  split(ARGV[ARGC-1], directoryNameSplit, "/")

  # Running length() on an array is only supported by GNU awk
  for ( item in directoryNameSplit ) ++arrayLength

  split(directoryNameSplit[arrayLength], fileNameSplit, ".")
  dirPath = length(path) > 0 ? path : "/tmp"
  dirName = length(subdir) > 0 ? subdir : fileNameSplit[1]
  outputDirectory = dirPath "/" dirName

  system("mkdir -p " outputDirectory)
}

match($0, /^(func(tion)? )?[a-zA-Z_][a-zA-Z0-9_]* ?(\(\.*\))? ?{/) {
  if ( match($1 $2, /func(tion)? /) ) {
    functionName = $2
  }
  else {
    functionName = $1
  }
  split(functionName, splitFunctionName, "(")
  sanitizedName = splitFunctionName[1]
  if ( length(specificFunction) == 0 || tolower(specificFunction) ~ tolower(functionName) ) {
    inFunction = 1
  }
}

inFunction {
  concat = functionBody ~ /^$/ ? "" : functionBody "\n"
  functionBody = concat $0
}

/^}$/ {
  if ( inFunction == 1 ) {
    fullPath = outputDirectory "/" sanitizedName
    inFunction = 0
    print functionBody > fullPath
    if ( stdout == 1 ) {
      print fullPath
    }
    functionBody = ""
  }
}