#!/bin/bash

exchange_term='All'
country='All'
faculty='All'
student_type='All'
language='All'
# page_num='1'

# # Exit if script does not have 2 arguments
# if [ $# -ne 2 ] ; then
#     echo "Usage: scraping_courses.sh <year> <course-prefix>"
#     exit 1
# fi

# # Exit if argument 1 is a string
# if [[ $1 =~ ^[0-9]+$ ]]
# then 
#     :
# else
#     echo "./scraping_courses.sh: argument 1 must be an integer between 2019 and 2022"
#     exit 1
# fi

# # Exit if year is out of range
# if [ $1 -lt 2019 -o $1 -gt 2022 ] ; then
#     echo "./scraping_courses.sh: argument 1 must be an integer between 2019 and 2022"
#     exit 1
# fi
rm "partner_urls.txt"
touch "partner_urls.txt"

for page_num in $(seq 0 20) ; do
    exchange_url="https://www.student.unsw.edu.au/partners?field_term_of_study_tid=${exchange_term}&field_country_tid=${country}&field_faculty_tid=${faculty}&field_student_type_tid=${student_type}&field_language_of_instruction_tid=${language}&combine=&page=${page_num}"

    undergrad_result=$(curl -sL $exchange_url | grep -E "<a href=/partners/.*>" | sed -r 's/.*\<a href=\/partners\/(.*)>/\1/')
    result=$(printf "$undergrad_result\n")

    echo $exchange_url
    echo $page_num
    printf "$undergrad_result\n" >> partner_urls.txt
done

# undergrad_result=$(curl -sL $undergrad_api | 2041 jq '.' | grep -E "(\"code\"|\"title\")" | sed -r 's/.*\"code\": \"(.*)\",/\1/' | sed -r 's/     \"title\": \"(.*)\",/\1\t/' | tr -d "\n" | tr "\t" "\n" )
# result=$(printf "$undergrad_result\n" )
# printf "$result" | sort | uniq -c | cut -c 9-999 | sed -r 's/  / /'