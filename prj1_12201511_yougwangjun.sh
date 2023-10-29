#!/bin/bash

echo "------------------------------"
echo "User Name: yougwangjun"
echo "Student Number: 12201511"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'
2. Get the data of action genre movies from 'u.item’
3. Get the average 'rating’ of the movie identified by specific 'movie id' from 'u.data’
4. Delete the ‘IMDb URL’ from ‘u.item
5. Get the data about users from 'u.user’
6. Modify the format of 'release date' in 'u.item’
7. Get the data of movies rated by a specific 'user id' from 'u.data'
8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'
9. Exit"
echo "------------------------------"

while True
do
    read -p "Enter your choice [ 1-9 ] " choice;
    case $choice in
    1)
        echo
        read -p "Please enter 'movie id' (1~1682): " movie_id; echo
        cat $1 | awk -F\| -v id=$movie_id '$1==id {print}'; echo
        ;;
    2)
        echo
        read -p "Do you want to get the data of ‘action’ genre movies from 'u.item’?(y/n): " is_on; echo
        if [ $is_on == 'y' ]; then
            cat $1 | awk -F\| '$7==1 {print $1, $2}' | head -n 10
        fi; echo
        ;;
    3)
        echo
        read -p "Please enter 'movie id' (1~1682): " movie_id; echo
        echo -n "average rating of $movie_id: "
        cat $2 | awk -v id=$movie_id '$2==id {sum+=$3; count+=1}END{print sum/count}'; echo
        ;;
    4)
        echo
        read -p "Do you want to delete the 'IMDb URL' from 'u.item’?(y/n): " is_on; echo
        if [ $is_on == 'y' ]; then
            cat $1 | head -n 10 | sed -E 's/http[^\)]*\)//g'; echo
        fi; echo
        ;;
    5)  
        echo
        read -p "Do you want to get the data about users from 'u.user’?(y/n): " is_on; echo
        if [ $is_on == 'y' ]; then
            cat $3 | head -n 10 | sed -E 's/^/user /
                                          s/\|/ is /
                                          s/\|/ years old /
                                          s/M/male/; s/F/female/
                                          s/\|/ /
                                          s/\|.*//'; echo
        fi; echo
        ;;
    6)
        echo
        read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n): " is_on; echo
        if [ $is_on == 'y' ]; then
            cat $1 | tail -n 10 | sed -E 's/Jan/01/; s/Feb/02/; s/Mar/03/; s/Apr/04/; s/May/05/; s/Jun/06/; s/Jul/07/; s/Auc/08/; s/Sep/09/; s/Oct/10/; s/Nov/11/; s/Dec/12/;
                                          s/([0-9]{2})-([0-9]{2})-([0-9]{4})/\3\2\1/'; echo
        fi; echo
        ;;
    7)
        echo
        read -p "Please enter the ‘user id’(1~943): " user_id; echo
        filter=$(cat $2 | awk -v id=$user_id '$1==id {print $2}' | sort -n)
        echo $filter | tr ' ' '\|'; echo

        for movie_id in $(echo "$filter" | head -n 10); do
            cat $1 | awk -F\| -v id=$movie_id '$1==id {print $1 "|" $2}'
        done; echo
        ;;
    8)
        echo
        read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n) " is_on; echo
        if [ $is_on == 'y' ]; then
            users=$(cat $3 | awk -F\| '$2>=20 && $2<=29 && $4=="programmer" {print $1}')

            arr=()
            for user in $(echo "$users"); do
                arr+=$(cat $2 | awk -v id=$user '$1==id {print $2 "|" $3}')
                arr+=$'\n'
            done;
            echo "$arr" | awk -F\| '{sum[$1]+=$2; count[$1]++}END{for (ind in sum) if (ind > 0) {print ind, sum[ind]/count[ind]}}'
        fi; echo
        ;;
    9) echo "Bye!"; break ;;
    *) echo "bad choice" ;;
    esac
done