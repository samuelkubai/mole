FROM golang

ARG app_env
ENV APP_ENV $app_env

COPY server /go/src/server
WORKDIR /go/src/server

RUN go get ./
RUN go build

CMD if [ ${APP_ENV} = production ]; \
	then \
	server; \
	else \
	go get github.com/pilu/fresh && \
	fresh; \
	fi
