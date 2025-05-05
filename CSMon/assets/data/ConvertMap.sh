#!/bin/bash

FILE="DAT0.s"

echo ";File Made my 'ConvertMap.sh'" > $FILE
echo -e "jmp __MAPDATAFILEEND\n" >> $FILE

NUMBERSET="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

for mapFile in $(find -name '*DATA.txt'); do
	while read -r dataLine; do
		if [ "${dataLine:0:1}" = "\"" ]; then
			echo -n "string ${dataLine%\"*}\"" >> $FILE
		else
			dataLine=`echo $dataLine | cut -d ' ' -f1`
			if [ "${dataLine:0:1}" = "_" ]; then
				echo -n $dataLine >> $FILE
			elif [ "${dataLine:0:1}" = "*" ]; then
				echo -n "integer ${dataLine:1}" >> $FILE
			elif [ "${dataLine:0:1}" = "%" ]; then
				echo -n "float ${dataLine:1}" >> $FILE
			elif [ "${dataLine:0:1}" = "&" ]; then
				echo -n "pointer ${dataLine:1}" >> $FILE
			elif [ ${#dataLine} -gt 0 ]; then
				character=${dataLine:0:1}
				character=${NUMBERSET#*$character}
				echo -n "integer " >> $FILE
				echo -n $(( ${#NUMBERSET} - ${#character} - 1 )) >> $FILE
				for (( i=1; i<${#dataLine}; i++ )); do
					character=${dataLine:$i:1}
					character=${NUMBERSET#*$character}
					character=$(( ${#NUMBERSET} - ${#character} - 1 ))
					echo -n ', ' >> $FILE
					printf "%2s" $character >> $FILE
				done
			fi
		fi
		echo -n -e '\n' >> $FILE
	done <$mapFile
done

echo "__MAPDATAFILEEND:" >> $FILE
