BEGIN {
  split(ARGV[ARGC-1], directoryNameSplit, ".")
  dirPath = length(path) ? path : ENVIRON["PWD"]
  dirName = length(subdir) ? subdir : directoryNameSplit[1]
  outputDirectory = dirPath "/" dirName
  system("mkdir -p " outputDirectory)
}

match($0, /^((func(tion)?)?\s*?\w+)\s*?(\(.*?\))?\s*?{/, matched) {
  if ( sub(/func(tion)? /, "", matched[1]) ) {
    functionName = $2
  }
  else {
    functionName = $1
  }
  sanitizedName = tolower(/\S\(\)/ ? substr(functionName, 1, length(functionName)-2) : functionName)
  inFunction = 1
}

inFunction {
  concat = functionBody ~ /^$/ ? "" : functionBody "\n"
  functionBody = concat $0
}

/^}$/ {
  inFunction = 0
  print functionBody > outputDirectory "/" sanitizedName
  functionBody = ""
}