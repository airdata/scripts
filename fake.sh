while true; do 
  curl -s "http://elasticsearch:9200/?pretty" | grep "name"
  if [[ "$?" -ne 1 ]]; then 
    break
  fi
  sleep 120
done
