FROM localstack/localstack:1.2.0

ENV TF_VERSION=1.5.6

RUN apt-get update && apt-get install wget

RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform && \
    rm terraform_${TF_VERSION}_linux_amd64.zip

COPY ./examples/ /etc/localstack/init/ready.d/examples/
COPY ./examples/init-aws.sh /etc/localstack/init/ready.d/
COPY ./examples/tf-plan-apply.sh /etc/localstack/init/ready.d/
COPY main.tf /etc/localstack/init/ready.d/
COPY outputs.tf /etc/localstack/init/ready.d/
COPY variables.tf /etc/localstack/init/ready.d/

RUN chmod -R 744 /etc/localstack/init/ready.d/

ENTRYPOINT ["docker-entrypoint.sh"]