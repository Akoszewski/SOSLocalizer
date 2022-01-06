# w folderze z apka: flutter build web --no-sound-null-safety (geolokator sobie nie radzi z nullsafety)
# scp -i ../keys/private.pem ../server.js ubuntu@3.68.186.250:~/servers/sosapp/
scp -i ../keys/private.pem -r ../../sos_client_app/build/web/* ubuntu@3.68.186.250:~/docker/test/pliki/
# ssh -i ../keys/private.pem ubuntu@3.68.186.250 'cp -r ~/web/* ~/docker/test/pliki/; rm -r ~/web/;'

scp -i ../keys/private.pem -r ../docker/docker-compose-test.yml ubuntu@3.68.186.250:~/docker/test/docker-compose.yml

scp -i ../keys/private.pem -r ../docker/docker-compose-proxy.yml ubuntu@3.68.186.250:~/docker/nginx/docker-compose.yml


scp -i ../keys/private.pem ../docker/backend/* ubuntu@3.68.186.250:~/docker/backend/
