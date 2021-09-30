# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
EXPOSE 8080
COPY "/ConversaoPeso.Web/*.csproj" ./
RUN dotnet restore 

COPY . .
RUN dotnet publish -c Release -o out ConversaoPeso.sln

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]