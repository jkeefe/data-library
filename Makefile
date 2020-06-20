# usage make name=minneapolis
# or make database db=minneapolis

# first item in the makefile is run by default
database:
	pipenv run csvs-to-sqlite ./csvs/${db}/*.csv ./my-app/${db}.db
	
live:
	pipenv run datasette package ./my-app/*.db \
		--port 8080 \
		-t johnkeefe-datasette \
		-m ./my-app/metadata.json 
	pipenv run flyctl deploy -i johnkeefe-datasette
	
local:
	docker run -p 8001:8001 -v `pwd`:/mnt \
	    datasetteproject/datasette \
	    datasette -p 8001 -h 0.0.0.0 /mnt/my-app/
		
		
	
	