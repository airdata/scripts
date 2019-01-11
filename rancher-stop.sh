 curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/stacks/1st288/?action=deactivateservices' 

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1271/?action=deactivate'


curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1132/?action=deactivate'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1268/?action=deactivate'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1040/?action=deactivate'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/stacks/1st210/?action=deactivateservices'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/stacks/1st326/?action=deactivateservices' 

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/stacks/1st210/?action=activateservices'

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1064/?action=activate' 

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{"inServiceStrategy":null, "toServiceStrategy":null}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1064/?action=upgrade' 

 curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1064/?action=upgrade' 

curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
'http://cattle1.lab:8080/v2-beta/projects/1a21/services/1s1064/?action=finishupgrade' 
