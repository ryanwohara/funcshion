# Funcshion

<img src="./funcshion.svg" width="50%">

## Description

Given a Bash script with functions declared, funcshion will create one file per function. Each file contains the full function and is named after the (lowercased) function.

## Warnings

Please note this script does make assumptions.
1. Functions can be declared in the following ways with no indentation before it:
   1. function Name() {}
   2. func Name(){}
   3. Name() {}
2. The opening and closing brackets of the function must have no indentation.
   1. The body can be indented as much as you want.

## Usage

To utilize the tool just pass the script to awk:

```
awk -f funcshion.awk script-name.sh
```

Change the path to where the subdirectory should be generated:

```
awk -f funcshion.awk -v path=/tmp script-name.sh
```

Change the name of the generated subdirectory:

```
awk -f funcshion.awk -v subdir=directoryName script-name.sh
```

Change both the path and the subdirectory names:
```
awk -f funcshion.awk -v subdir=directoryName -v path=/tmp script-name.sh
```

Put the files directly into /tmp without creating a subdirectory:

```
awk -f funcshion.awk -v path=/tmp -v subdir=/ script-name.sh
```

Example:

```
$ cat sample.sh
a() {
    echo "a"
}
b() {
    echo "b"
}
c() {
    echo "c"
}

$ ls sample
ls: cannot access 'sample': No such file or directory

$ awk -f funcshion.awk sample.sh

$ ls sample
a  b  c

$ cat sample/a
a() {
    echo "a"
}

$ cat sample/b
b() {
    echo "b"
}

$ cat sample/c
c() {
    echo "c"
}
```