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
    read -p "Enter your choice [ 1-9 ] " choice; echo ""
    case $choice in
    9) echo "Bye!"; break;;
    1)
        read -p "Please enter 'movie id' (1~1682): " movie_id; echo ""
        cat $1 | awk -F\| -v id=$movie_id '$1==id {print}'; echo ""
        ;;
    2)
        read -p "Do you want to get the data of ‘action’ genre movies from 'u.item’?(y/n): " is_on; echo ""
        if [ $is_on == 'y' ]; then
            cat $1 | awk -F\| '$7==1 {print $1, $2}' | head -n 10
        fi; echo ""
        ;;
    3);;
    4);;
    5);;
    6);;
    7);;
    8);;
    *) echo $choice ;;
    esac
done