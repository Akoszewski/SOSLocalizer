scp -i ../keys/private.pem ../server.js ubuntu@3.68.186.250:~/servers/sosapp/
scp -i ../keys/private.pem -r ../../sos_client_app/build/ ubuntu@3.68.186.250:~/
ssh -i ../keys/private.pem ubuntu@3.68.186.250 'sudo cp ~/build/web/* /var/www/html/; sudo cp -r ~/build/* /var/www/html/; sudo rm -rf /var/www/html/web/; rm -r ~/build/;'
