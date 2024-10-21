# Указываем базовый образ
FROM node

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package.json /app

# Устанавливаем зависимости
RUN npm install
	
# Копируем весь проект в рабочую директорию
COPY . /app

EXPOSE 3000
# Команда для запуска приложения
CMD [ "node", "app.js" ]

