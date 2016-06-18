# Show duplicate lines of $1

echo "$1" | sort | uniq -d
