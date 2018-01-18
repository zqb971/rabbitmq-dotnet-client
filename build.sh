#!/bin/sh

set -e

SCRIPT=$0
SCRIPT_DIR=$(cd $(dirname "$SCRIPT") && pwd)

dotnet restore ./RabbitMQDotNetClient.sln
dotnet run -p $SCRIPT_DIR/projects/client/Apigen/Apigen.csproj --apiName:AMQP_0_9_1 $SCRIPT_DIR/docs/specs/amqp0-9-1.stripped.xml $SCRIPT_DIR/gensrc/autogenerated-api-0-9-1.cs
# we have to use msbuild or else multi-targeting doesn't work
dotnet msbuild $SCRIPT_DIR/projects/client/RabbitMQ.Client/RabbitMQ.Client.csproj
dotnet build $SCRIPT_DIR/projects/client/Unit/Unit.csproj
