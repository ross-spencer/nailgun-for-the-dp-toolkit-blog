#!/bin/bash
set -e

JHOVE_HOME='/home/digital/dp-toolkit/jhove-1_11'
TIKA_HOME='/home/digital/dp-toolkit/tika-1.5'

#Load JHOVE and TIKA into Nailgun CLASSPATH
$(ng ng-cp ${JHOVE_HOME}/bin/JhoveApp.jar)
$(ng ng-cp ${TIKA_HOME}/tika-app-1.5.jar) 

# Corpus Manifest Location
MANIFEST='/home/digital/Desktop/dp-testing/nailgun-timing/opf-format-corpus-directory-manifest.txt'

# Analysis log files
FILELOG='file-analysis.log'
TIKAMDLOG='tika-md-analysis.log'
TIKATYPELOG='tika-type-analysis.log'
JHOVELOG='jhove-analysis.log'
SHAONELOG='sha-one-analysis.log'

dp_analysis_no_ng ()
{
   FUID=$(uuidgen)
   DIRN=$(dirname "$file")
   BASN=$(basename "$file")

   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "file-5.11" '\t' $(file -b -n -p "$file") '\t' $(file -b -i -n -p "$file") >> ${LOGNAME}${FILELOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "tika-1.5-md" '\t' $(java -jar ${TIKA_HOME}/tika-app-1.5.jar -m "$file") >> ${LOGNAME}${TIKAMDLOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "tika-1.5-type" '\t' $(java -jar ${TIKA_HOME}/tika-app-1.5.jar -d "$file") >> ${LOGNAME}${TIKATYPELOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "jhove-1_11" '\t' $(java -jar ${JHOVE_HOME}/bin/JhoveApp.jar "$file") >> ${LOGNAME}${JHOVELOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "sha-1-8.20" '\t' $(sha1sum -b "$file") >> ${LOGNAME}${SHAONELOG}
}

dp_analysis_ng ()
{
   FUID=$(uuidgen)
   DIRN=$(dirname "$file")
   BASN=$(basename "$file")

   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "file-5.11" '\t' $(file -b -n -p "$file") '\t' $(file -b -i -n -p "$file") >> ${LOGNAME}${FILELOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "tika-1.5-md" '\t' $(ng org.apache.tika.cli.TikaCLI -m "$file") >> ${LOGNAME}${TIKAMDLOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "tika-1.5-type" '\t' $(ng org.apache.tika.cli.TikaCLI -d "$file") >> ${LOGNAME}${TIKATYPELOG} 
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "jhove-1_11" '\t' $(ng Jhove "$file") >> ${LOGNAME}${JHOVELOG}   
   echo -e ${FUID} '\t' "$file" '\t' ${DIRN} '\t' ${BASN} '\t' "sha-1-8.20" '\t' $(sha1sum -b "$file") >> ${LOGNAME}${SHAONELOG}
}

# NO-NG Log name
LOGNAME='no-ng-'

rm -f ${LOGNAME}${FILELOG} 
rm -f ${LOGNAME}${TIKAMDLOG} 
rm -f ${LOGNAME}${TIKATYPELOG} 
rm -f ${LOGNAME}${JHOVELOG} 
rm -f ${LOGNAME}${SHAONELOG}

# Manifest loop...
time(while read file;do
	if [ -f "$file" ]; then
   	dp_analysis_no_ng "$file"
	fi
done < $MANIFEST)

# NG Log name
LOGNAME='ng-'

rm -f ${LOGNAME}${FILELOG} 
rm -f ${LOGNAME}${TIKAMDLOG} 
rm -f ${LOGNAME}${TIKATYPELOG} 
rm -f ${LOGNAME}${JHOVELOG} 
rm -f ${LOGNAME}${SHAONELOG}

# Manifest loop...
time(while read file;do
	if [ -f "$file" ]; then
   	dp_analysis_ng "$file"
	fi
done < $MANIFEST)
