BEGIN {
  split(ARGV[ARGC-1], directoryNameSplit, "/")

  # Running length() on an array is only supported by GNU awk
  for ( item in directoryNameSplit ) ++arrayLength

  split(directoryNameSplit[arrayLength], fileNameSplit, ".")
  dirPath = length(path) > 0 ? path : ENVIRON["PWD"]
  dirName = length(subdir) > 0 ? subdir : fileNameSplit[1]
  outputDirectory = dirPath "/" dirName

  system("mkdir -p " outputDirectory)
}

match($0, /^(func(tion)?)? ?[a-zA-Z]+ ?(\(\.*\))? ?{/) {
  if ( match($1, /func(tion)?/) ) {
    functionName = $2
  }
  else {
    functionName = $1
  }
  sanitizedName = tolower(match(functionName, /\(/) ? substr(functionName, 1, length(functionName)-2) : functionName)
  inFunction = 1
}

inFunction {
  concat = functionBody ~ /^$/ ? "" : functionBody "\n"
  functionBody = concat $0
}

/^}$/ {
  fullPath = outputDirectory "/" sanitizedName
  inFunction = 0
  print functionBody > fullPath
  functionBody = ""
}