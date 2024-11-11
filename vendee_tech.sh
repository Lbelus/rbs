#!/usr/bin/env bash
#vendetech script

TOTAL_PAGES=10
for ((i = 1; i <= TOTAL_PAGES; i++)); do
  echo "Fetching page $i..."
  curl "https://www.vendeefrenchtech.com/les-membres/nos-membres/page-$i.html" >> combined_output_02.html
done

echo "Pages have been fetched"

IFS=$'\n'

MAIL_ARRAY=($(grep '<strong>E-mail :</strong><a href="mailto:' combined_output.html | sed 's/^.*:\(.*\)\"$/\1/'))
OWNER_ARRAY=($(grep '<strong>Dirigeant :</strong><span class="txt-capital">' combined_output.html | sed 's/^.*l">\(.*\)<\/span>$/\1/'))

unset IFS
COMBINED=()

for ((i = 0; i < ${#MAIL_ARRAY[@]}; i++)); do
  COMBINED+=("${OWNER_ARRAY[i]},${MAIL_ARRAY[i]}")
done

SORTED=$(printf "%s\n" "${COMBINED[@]}" | sort -u)

echo 'owner,email' > result.csv
printf "%s\n" "$SORTED" >> result.csv

cat result.csv
