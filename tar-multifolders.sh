cd /Users/rumenlishkov/Desktop/mega/www/19.01.2019/html 
for dir in */
do
  base=$(basename "$dir")
  tar -czf "${base}.tar.gz" "$dir"
done
