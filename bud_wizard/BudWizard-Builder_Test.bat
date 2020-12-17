echo Step 1) Build the Docker container for Bud Wizard
docker-compose --project-name budwizard build --build-arg BASE_URL="https://localhost:9001/api/v1/" --build-arg CERTIFICATEFILE="budwizard.crt" --build-arg CERTIFICATEKEY="budwizard.key" --build-arg NGINXCONF="nginx_prod.conf"

echo Step 2) Tag the created Docker Images appropriately
docker tag danksolution/budwizard danksolution/budwizard-test:1.0.0

echo Step 3) Push the Docker images we just created to Docker Hub
docker push danksolutions/budwizard-test:1.0.0

REM echo Step 4) Run the Docker container we just created 
REM start cmd /k docker-compose --project-name budwizard up

pause