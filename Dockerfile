FROM crosbymichael/golang

RUN apt-get update && apt-get install --no-install-recommends --fix-missing -y \
	pkg-config \
	libtool \
	autoconf \
	automake \
	make \
	g++ \
	uuid-dev \
	wget

# Compile zeroMQ from source
WORKDIR /tmp
RUN wget http://download.zeromq.org/zeromq-4.0.4.tar.gz && tar -xvf zeromq-4.0.4.tar.gz && cd zeromq-* && ./configure && make install && ldconfig && cd .. && rm -rf zeromq*

# Clean up the container
RUN apt-get purge -y \
    libtool \
    autoconf \
    automake \
    make \
    g++ \
    uuid-dev \
    wget

# Reset the workdir
WORKDIR /
