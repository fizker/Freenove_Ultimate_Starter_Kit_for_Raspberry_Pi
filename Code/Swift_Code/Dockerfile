FROM swift:6.1-noble

RUN apt update && apt install wget
RUN wget https://github.com/WiringPi/WiringPi/releases/download/3.14/wiringpi_3.14_arm64.deb
RUN apt install ./wiringpi_3.14_arm64.deb
RUN rm wiringpi_3.14_arm64.deb
