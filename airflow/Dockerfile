FROM apache/airflow:2.10.3-python3.11

USER root

RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    ant \
    gcc \
    curl \
    build-essential \
    libssl-dev \
    libsasl2-dev \
    libffi-dev \
    python3-dev \
    procps \
    vim \
    git \
    wget \
    zip \
    libaio1 \
    libaio-dev \
    telnet \
    && apt-get clean

#RUN apt-get install openjdk-11-jdk -y
#RUN apt-get update && apt-get install -y openjdk-11-jdk

# fluent-bit 설치
RUN curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
RUN curl https://packages.fluentbit.io/fluentbit.key | gpg --dearmor > /usr/share/keyrings/fluentbit-keyring.gpg

RUN apt-get update && \
  apt-get install fluent-bit

  
# JAVA 설치 
RUN sudo echo "deb http://deb.debian.org/debian unstable main non-free contrib" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y openjdk-11-jdk

ENV JAVA_HOME=/usr/lib/jvm/default-java/
ENV PATH=$JAVA_HOME/bin:$PATH

# 모든 사용자에게 비밀번호 없이 sudo 사용 권한 부여
RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY airflow.cfg /opt/airflow/airflow.cfg
COPY flunetbit/ /opt/fluent-bit/

RUN chmod 777 -R /opt/fluent-bit/
RUN chmod 777 /opt/airflow/airflow.cfg

USER airflow

COPY requirements.txt /home/airflow/requirements.txt
RUN sudo pip3 install -r /home/airflow/requirements.txt