curl https://files.data.gouv.fr/geo-sirene/2024-11/communes/ >> geo-sirene.html


CITY_CODE_ARRAY=($(grep '<a href="' geo-sirene.html | sed -n 's/.*<a href="\([^"]*\)">.*/\1/p'))


for ((i = 0; i < ${#CITY_CODE_ARRAY[@]}; i++)); do
    wget https://files.data.gouv.fr/geo-sirene/2024-11/communes/${CITY_CODE_ARRAY[i]}
done
