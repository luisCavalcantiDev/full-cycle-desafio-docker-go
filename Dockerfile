# usa a imagem do golang, copia os arquivos e faz o build da app
FROM golang:1.13.8-alpine3.11 as build

WORKDIR /app
COPY . .

# necessário para rodar o app do golang e permissão na pasta
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app

ENTRYPOINT ["go","run","app.go"]


# usa a imagem vazia do Docker e reutiliza o build no stage anterior, e excuta o app
FROM scratch

COPY --from=build /app .
CMD [ "./app" ]


# docker build -t luiscavalcantidev/full-cycle-desafio-docker-go:1.0.0

# docker pull luiscavalcantidev/full-cycle-desafio-docker-go:1.0.0 
# docker run luiscavalcantidev/full-cycle-desafio-docker-go:1.0.0