# Build the DockerFile

cd git/devops/portfolio/coffee-ratings
workflow:

cd project-root

docker build -t coffee-ratings . (optional)

docker-compose up -d --build

Check logs: docker-compose logs -f

Access the app at localhost:4000

Stop containers: docker-compose down


Connect to database
docker exec -it coffee-db psql -U coffeeuser -d coffeeratings
