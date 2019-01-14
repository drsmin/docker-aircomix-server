# 1. ubuntu 설치 (패키지 업데이트 + 만든사람 표시)
FROM       ubuntu:18.04
MAINTAINER drs@drs.pe.kr
RUN        apt-get -y update
RUN apt-get -y install language-pack-ko
RUN apt-get -y install fonts-nanum

# 언어 설정
RUN locale-gen ko_KR.UTF-8
ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8
 
# TimeZone 설정
ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 2. apache php 설치
RUN apt-get -y install apache2
RUN apt-get -y install php
RUN apt-get -y install php-zip
RUN apt-get -y install libapache2-mod-php

# 3. 필요파일 복사
COPY ./comix-server /data/comix-server
COPY ./conf/comix.conf /etc/apache2/sites-available
COPY ./docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

# 4. 아파치 수정
RUN a2dissite 000-default
RUN a2ensite comix
RUN a2enmod rewrite

# 5. 초기실행
VOLUME ["/data/manga"]
ENV PASSWORD 1234
EXPOSE 31257
ENTRYPOINT /docker-entrypoint.sh
