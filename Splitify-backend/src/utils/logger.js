import { createLogger, format, transports } from 'winston';
import DailyRotateFile from 'winston-daily-rotate-file';
import fs from 'fs';
import path from 'path';


// Create logs folder if not present
const logDir =  path.resolve('src/logs');  // Resolves to backend/src/logs
if (!fs.existsSync(logDir)) {
  fs.mkdirSync(logDir, { recursive: true });
}

const dailyRotateFileTransport = new DailyRotateFile({
  filename: path.join(logDir, 'combined-%DATE%.log'),
  datePattern: 'YYYY-MM-DD',
  zippedArchive: false, // set to true if you want logs compressed
  maxSize: '20m',
  maxFiles: '14d', // keep logs for 14 days
  level: 'info',
});

const errorRotateFileTransport = new DailyRotateFile({
  filename: path.join(logDir, 'error-%DATE%.log'),
  datePattern: 'YYYY-MM-DD',
  zippedArchive: false,
  maxSize: '10m',
  maxFiles: '14d',
  level: 'error',
});

const logger = createLogger({
  level: 'info', // default level
  format: format.combine(
    format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    format.printf(({ timestamp, level, message }) => {
      return `${timestamp} [${level.toUpperCase()}] ${message}`;
    })
  ),
  transports: [
    dailyRotateFileTransport,
    errorRotateFileTransport,
    new transports.Console({ format: format.simple() }) // For development visibility
  ],
  exitOnError: false
});

export default logger;