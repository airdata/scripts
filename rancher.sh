curl -u "9382DC076B24320EBB22:zhCSMWgQ9rnF8QWkPMKH5hCEErJ3apjGpxaRtYyQ" \
  -X POST \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{ "toServiceStrategy": { "startFirst": true } }' \
  'http://cattle.lab/v2-beta/projects/1a21/services/1s1279?action=upgrade'

curl -u "9382DC076B24320EBB22:zhCSMWgQ9rnF8QWkPMKH5hCEErJ3apjGpxaRtYyQ" \
  -X POST \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{}' \
  'http://cattle.lab/v2-beta/projects/1a21/services/1s1279/?action=finishupgrade'

`curl -u "9382DC076B24320EBB22:zhCSMWgQ9rnF8QWkPMKH5hCEErJ3apjGpxaRtYyQ" \
  -X GET \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{}' \
  'http://cattle.lab/v2-beta/projects/1a21/services/1s1279'`
