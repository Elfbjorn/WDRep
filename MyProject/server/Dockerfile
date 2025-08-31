# .NET 8 Web API Dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY server.csproj ./
RUN dotnet restore ./server.csproj
COPY . .
RUN dotnet publish server.csproj -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
CMD ["dotnet", "server.dll"]
