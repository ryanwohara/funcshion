# Funcshion

Given a Bash script with functions declared, funcshion will create one file per function. Each file contains the full function and is named after the (lowercased) function.

To utilize the tool just pass the script to awk:

```
awk -f find-functions.sh script-name.sh
```

Change the path to where the subdirectory should be generated:

```
awk -f find-functions.sh -v path=/tmp script-name.sh
```

Change the name of the generated subdirectory:

```
awk -f find-functions.sh -v subdir=directoryName script-name.sh
```

Change both the path and the subdirectory names:
```
awk -f find-functions.sh -v subdir=directoryName -v path=/tmp script-name.sh
```

Put the files directly into /tmp without creating a subdirectory:

```
awk -f find-functions.awk -v path=/tmp -v subdir=/ script-name.sh
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

$ awk -f find-functions.sh sample.sh

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