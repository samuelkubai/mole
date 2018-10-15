FROM golang

ARG app_env
ENV APP_ENV $app_env

COPY client /go/src/app
WORKDIR /go/src/app

RUN go get ./
RUN go build

CMD if [ ${APP_ENV} = production ]; \
	then \
	app; \
	else \
	go get github.com/pilu/fresh && \
	fresh; \
	fi
