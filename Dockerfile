FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update
RUN apt-get install -y libgdal-dev python-dev build-essential libyaml-dev libspatialindex-dev python-virtualenv
RUN apt-get install -y nodejs-legacy npm
RUN apt-get install -y git

RUN git clone https://github.com/ehealthafrica/mapzen-exporter && cd mapzen-exporter
RUN npm install -g fences-builder
RUN virtualenv mapzen_env
RUN source mapzen_env/bin/activate

#Installing GDAL
RUN apt-get install -y wget
RUN wget http://download.osgeo.org/gdal/1.11.2/gdal-1.11.2.tar.gz
RUN tar xzf gdal-1.11.2.tar.gz
RUN cd gdal-1.11.2
RUN ./configure
RUN make
RUN make install
RUN cd ..

RUN pip install -r pip-required.txt