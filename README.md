# Shadow.BG 

An API built around the RARBG backup, with optional Next.js frontend
ARM based

###### Prerequisites
- Go ([v1.20](https://go.dev/dl/))
- NPM (Optional, to build the frontend)

###### Steps to build
````
git clone https://github.com/xav1erenc/shadowbg && cd shadowbg
go build -o shadow.bg main.go
# Optional
git clone https://github.com/xav1erenc/shadowbg-frontend ../shadowbg-frontend && cd ../shadowbg-frontend
npm install && npm run build
cp -rf out/* ../shadowbg/frontend/
````

###### Usage
You need to download the `rarbg_db.zip` file, unzip it and rename `rarbg_db.sqlite` to `db.sqlite` (Or you can change the `main.go` code to use any other name you want to rename the file to. With that, you can run the API:

````
./shadow.bg --port 8080 --serve-frontend # To serve frontend along with API
OR
./shadow.bg --port 8080                  # To serve only the headless API
````

###### Docker Image
Use the following commands to build and run the docker image. \
Make sure that the original rarbg_db.sqlite exists under /data
```
docker build -t "shadowbg" .
docker run -d --name shadowbg -p 80:80 -v /tmp/rarbg_db.sqlite:/data/rarbg_db.sqlite shadowbg
```
