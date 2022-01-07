# w folderze z apka: flutter build web

# wrzucanie skompilowanego kodu
scp -i ../keys/private.pem -r ../../sos_client_app/build/web/* ubuntu@3.68.186.250:~/docker/test/pliki/

# wrzucanie plikow docker-compose (jesli byly edytowane)
scp -i ../keys/private.pem -r ../docker/docker-compose-test.yml ubuntu@3.68.186.250:~/docker/test/docker-compose.yml
scp -i ../keys/private.pem -r ../docker/docker-compose-proxy.yml ubuntu@3.68.186.250:~/docker/nginx/docker-compose.yml
# + trzeba uruchomic kontenery "docker-compose up -d" albo "docker-compose restart" w odpowiednich folderach

# wrzucanie backendu
scp -i ../keys/private.pem ../docker/backend/* ubuntu@3.68.186.250:~/docker/backend/
# + na serwerze "docker build -t backend ."; "docker-compose up -d"
