# Using latest base image  from DockerHub
FROM python:latest

#Creating working directory inside container#
WORKDIR /flask-s3-app

#Copy source code into working directory inside container
COPY . /flask-s3-app

#Install flask inside container
RUN pip install -r requirements.txt

#Expose container port
EXPOSE 8080

#Start flask app
ENTRYPOINT ["python"]
CMD ["app.py"]
