# w folderze z apka: flutter build web --no-sound-null-safety (geolokator sobie nie radzi z nullsafety)
scp -i ../keys/private.pem ../server.js ubuntu@3.68.186.250:~/servers/sosapp/
scp -i ../keys/private.pem -r ../../sos_client_app/build/web ubuntu@3.68.186.250:~/
ssh -i ../keys/private.pem ubuntu@3.68.186.250 'sudo cp -r ~/web/* /var/www/html/; rm -r ~/web/;'
