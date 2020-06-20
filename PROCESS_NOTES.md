# Process Notes

Here's where I take notes on this project. May contain errors and dead ends. Enjoy!

## Serving Datasette from Docker

Here's my power-up script.

```
cd data-library
docker run -p 8001:8001 -v `pwd`:/mnt \
    datasetteproject/datasette \
    datasette -p 8001 -h 0.0.0.0 /mnt/my-app/
```

Then take a look at [http://localhost:8001/](http://localhost:8001/)

## Uploading to Fly

First had to `pipenv install datasette-publish-fly ` into the environment.

This errors with something about a secret:
```
pipenv shell
datasette publish fly ./my-app/*.db --app="johnkeefe-datasette" -m ./my-app/metadata.json

```

Other way ...

First set up a fly app using:

```
flyctl apps create
```

Note that I called both the fly app above and the docker container below `johnkeefe-datasette`, which was probably not necessary. Then:

```
pipenv shell
datasette package ./my-app/*.db --port 8080 -t johnkeefe-datasette -m ./my-app/metadata.json 
flyctl deploy -i johnkeefe-datasette
```

Says the image size is 1.1GB! Oof.

Note can check pricing and resources using `flyctl scale vm`.

Can find it live at [https://johnkeefe-datasette.fly.dev/](https://johnkeefe-datasette.fly.dev/)

## Subdomain hosting

Pointed a CNAME record to `johnkeefe-datasette.fly.dev.`

Then ran `flyctl certs create datasette.johnkeefe.net` to make it https.


