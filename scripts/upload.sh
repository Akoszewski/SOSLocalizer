cd ../sos_client_app/; flutter build web; cd -

# wrzucanie skompilowanego kodu
scp -i ../keys/private.pem -r ../sos_client_app/build/web/* ubuntu@3.68.186.250:~/docker/sos_app/pliki/

# wrzucanie plikow docker-compose (trzeba jesli byly edytowane)
scp -i ../keys/private.pem -r ../docker/docker-compose-client.yml ubuntu@3.68.186.250:~/docker/sos_app/docker-compose.yml
ssh -i ../keys/private.pem ubuntu@3.68.186.250 'cd ~/docker/sos_app/; docker-compose up -d'

scp -i ../keys/private.pem -r ../docker/docker-compose-proxy.yml ubuntu@3.68.186.250:~/docker/nginx_proxy/docker-compose.yml
ssh -i ../keys/private.pem ubuntu@3.68.186.250 'cd ~/docker/nginx_proxy/; docker-compose up -d'

# wrzucanie backendu
scp -i ../keys/private.pem ../server_app/backend/* ubuntu@3.68.186.250:~/docker/backend/
scp -i ../keys/private.pem -r ../docker/docker-compose-backend.yml ubuntu@3.68.186.250:~/docker/sos_app/docker-compose.yml
ssh -i ../keys/private.pem ubuntu@3.68.186.250 'cd ~/docker/backend/; docker build -t backend .; docker-compose up -d'
