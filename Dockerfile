FROM amazonlinux
COPY . .
RUN yum install python3 -y
RUN yum install python3-pip -y
RUN pip3 install -r requirements.txt
EXPOSE 80
CMD ["python3", "app.py"]
