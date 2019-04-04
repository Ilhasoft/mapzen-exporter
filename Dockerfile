FROM ubuntu:trusty

ENV APP_PATH /mapzen-exporter
WORKDIR $APP_PATH

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update \
    && apt-get install -y libgdal-dev python-dev build-essential wget \
    libyaml-dev libspatialindex-dev python-virtualenv nodejs-legacy npm git

RUN git clone https://github.com/ehealthafrica/mapzen-exporter .

RUN npm config set strict-ssl false \
    && npm install -g fences-builder

RUN virtualenv mapzen_env \
    && . mapzen_env/bin/activate

#Installing GDAL
RUN cd /
RUN wget http://download.osgeo.org/gdal/1.11.2/gdal-1.11.2.tar.gz
RUN tar xzf gdal-1.11.2.tar.gz
RUN cd gdal-1.11.2 \
    && ./configure \
    && make \
    && make install

RUN cd $APP_PATH \
    && pip install --upgrade setuptools pip \
    && pip install -r pip-required.txt

RUN cd exporter

CMD ["python", "exporter.py", "run_all"]
