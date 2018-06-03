:
####################################################################################################
## \file HelpExeList.sh
## \author SENOO, Ken
## \copyright CC0
## \version 1.0.0
## \date Created: 2018-05-27
## \date Updated: 2018-05-27
####################################################################################################

PrintHelpList() {
    printf 'Version';
    for ver in ./ja/*; do
        printf "\t${ver##*/}"
    done
    echo

    ls -1R ja | sort | uniq | grep -o '^[A-Z]*' | while read exe; do
        printf "$exe"
        for ver in ./ja/*; do
            # [ -e $ver/help/$exe.txt ] && printf '\to' || printf '\tx'
            [ -e $ver/help/$exe.txt ] && printf '\to' || printf '\t'
        done
        echo
    done
}

MoveWin10ColumntoLast() {
    HT=$(printf '\t')
    awk -F "$HT" '{
        printf $1
        for (i = 3; i <= NF; ++i) {
            printf "\t"$i
        }
        printf "\t%s\n", $2
    }'
}

PrintHelpList | MoveWin10ColumntoLast