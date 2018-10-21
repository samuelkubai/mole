FROM golang

ARG app_env
ENV APP_ENV $app_env

COPY client /go/src/client
WORKDIR /go/src/client

RUN go get ./
RUN go build

CMD if [ ${APP_ENV} = production ]; \
	then \
	client; \
	else \
    go get github.com/oxequa/realize && \
    realize start --name="mole-client" --install; \
	fi
