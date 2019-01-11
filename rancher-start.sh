curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1064/?action=deactivate' 
curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1271/?action=activate'


curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1132/?action=activate'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1268/?action=activate'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1040/?action=activate'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/stacks/1st288/?action=activateservices' 

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/stacks/1st326/?action=activateservices' 
