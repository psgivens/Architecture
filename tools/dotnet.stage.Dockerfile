FROM microsoft/dotnet:2.2-sdk

RUN apt-get update 
RUN apt-get install -y unzip
RUN apt-get install -y libcurl3

RUN mkdir -p /vsdbg
RUN curl -sSL https://aka.ms/getvsdbgsh \
  | /bin/sh /dev/stdin -v latest -l /vsdbg


  