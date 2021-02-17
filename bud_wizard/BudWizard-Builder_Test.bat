echo Step 1) Build the Docker container for Bud Wizard
echo use this in the future for production: --build-arg CERTIFICATEFILE="budwizard.crt" --build-arg CERTIFICATEKEY="budwizard.key" --build-arg NGINXCONF="nginx_prod.conf"
docker-compose --project-name budwizard build --build-arg BASE_URL="https://159.89.127.191:9000/api/v1/"

echo Step 2) Tag the created Docker Images appropriately
docker tag danksolutions/budwizard registry.digitalocean.com/bud-wizard-image-repo/budwizard-test:1.0.10

echo Step 3) Push the Docker images we just created to Docker Hub
docker push registry.digitalocean.com/bud-wizard-image-repo/budwizard-test:1.0.10

REM echo Step 4) Run the Docker container we just created 
REM start cmd /k docker-compose --project-name budwizard up

pause