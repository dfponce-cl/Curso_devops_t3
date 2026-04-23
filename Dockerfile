# Etapa 1: Build
FROM node:24 AS build

WORKDIR /app

# Copiar dependencias
COPY package*.json ./
RUN npm install

# Copiar código fuente
COPY . .

# Compilar aplicación
RUN npm run build

# Etapa 2: Imagen liviana de salida
FROM node:24-alpine

WORKDIR /app

# Copiar solo lo necesario desde la etapa build
COPY --from=build /app/dist ./dist
#COPY --from=build /app/node_modules ./node_modules
COPY package*.json ./
RUN npm install --only=production

# Exponer puerto
EXPOSE 3000

# Comando de ejecución
CMD ["node", "dist/main.js"]