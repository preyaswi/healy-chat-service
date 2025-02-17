FROM golang:1.22-alpine AS build-stage
WORKDIR /chat_svc
COPY ./ /chat_svc
RUN mkdir -p /chat_svc/build
RUN go mod download
RUN go build -v -o /chat_svc/build/api ./cmd


FROM gcr.io/distroless/static-debian11
COPY --from=build-stage /chat_svc/build/api /
COPY --from=build-stage /chat_svc/.env /
EXPOSE 50055
CMD [ "/api" ]