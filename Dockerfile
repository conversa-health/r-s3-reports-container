FROM rocker/verse:4.1.0

RUN apt-get update && \
	  apt-get install -y --no-install-recommends \
		curl libssl-dev libudunits2-dev

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

WORKDIR /usr/local/src/reporting
COPY install_deps.r /usr/local/src/reporting
RUN Rscript install_deps.r

COPY run.sh /usr/local/src/reporting

CMD ["./run.sh"]
