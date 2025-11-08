FROM node:22-bullseye

# Set working directory
WORKDIR /app

# --------------------------
# Backend
# --------------------------

COPY backend/package*.json ./backend/
RUN cd backend && npm install

COPY backend/ ./backend
COPY backend/init_db.sql /app/init_db.sql

# --------------------------
# Frontend
# --------------------------

COPY frontend/package*.json ./frontend/
RUN cd frontend && npm install

COPY frontend/ ./frontend
RUN cd frontend && npm run build && \
    mkdir -p /app/backend/public && \
    cp -r dist/* /app/backend/public/

# Prepare uploads
RUN mkdir -p /app/uploads && chmod 777 /app/uploads

# Expose port
EXPOSE 4000

# Start backend
WORKDIR /app/backend
CMD ["node", "server.js"]
