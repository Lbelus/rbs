#!/usr/bin/env bash

deps=('01/' '02/' '03/' '04/' '05/' '06/' '07/' '08/' '09/' '10/' '11/' '12/' '13/' '14/' '15/' '16/' '17/' '18/' '19/' '21/' '22/' '23/' '24/' '25/' '26/' '27/' '28/' '29/' '2A/' '2B/' '30/' '31/' '32/' '33/' '34/' '35/' '36/' '37/' '38/' '39/' '40/' '41/' '42/' '43/' '44/' '45/' '46/' '47/' '48/' '49/' '50/' '51/' '52/' '53/' '54/' '55/' '56/' '58/' '59/' '60/' '61/' '62/' '63/' '64/' '65/' '66/' '69/' '70/' '71/' '72/' '73/' '74/' '75/' '76/' '77/' '78/' '79/' '80/' '81/' '82/' '83/' '84/' '85/' '86/' '87/' '88/' '89/' '90/' '91/' '92/' '93/' '94/' '95/' '971/' '972/' '973/' '974/')

for YEAR in {2021..2023}
    do mkdir $YEAR
    cd $YEAR
    for dep in "${deps[@]}"; do
        mkdir "${dep::-1}"
        cd "${dep::-1}"
        wget https://files.data.gouv.fr/geo-dvf/latest/csv/$YEAR/departements/${dep::-1}.csv.gz
        for COM in {001..999}
        do
            wget https://files.data.gouv.fr/geo-dvf/latest/csv/$YEAR/communes/${dep::-1}/${dep::-1}$COM.csv
        done
        cd ..
    done
    cd ..
done
wget https://files.data.gouv.fr/geo-dvf/latest/csv/$YEAR/full.csv.gz
