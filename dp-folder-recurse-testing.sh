#!/bin/bash
set -e

rm -f 'file-analysis.log'
rm -f 'sha-one-analysis.log'

# Manifest Location
MANIFEST='/home/digital/Desktop/dp-testing/recurse-testing/opf-format-corpus-directory-manifest.txt'

# Corpus Location
CORPUSLOC='/home/digitalr/Desktop/dp-testing/opf-format-corpus'

dp_analysis ()
{
   FUID=$(uuidgen)
   DIRN=$(dirname "$file")
   BASN=$(basename "$file")

	# Truncate rather than append as we don't need to keep all results...
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "file" '\t' $(file -b -n -p "$file") '\t' $(file -b -i -n -p "$file") > file-analysis.log 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "sha-1" '\t' $(sha1sum -b "$file") > sha-one-analysis.log
}

# Find loop...
oIFS=$IFS
IFS=$'\n'

time(find "$CORPUSLOC" -type f | while read -r file; do
   dp_analysis "$file"
done)

IFS=$oIFS

#Globstar loop...
shopt -s globstar
time(for file in "$CORPUSLOC"/**
do
	if [ -f "$file" ]; then   
		dp_analysis "$file"   
	fi
done)

# Manifest loop...
time(while read file;do
	if [ -f "$file" ]; then
   	dp_analysis "$file"
	fi
done < $MANIFEST)
