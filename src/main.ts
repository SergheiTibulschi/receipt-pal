import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import * as fs from 'fs';
import {
  DocumentBuilder,
  SwaggerDocumentOptions,
  SwaggerModule,
} from '@nestjs/swagger';
import { stringify } from 'yaml';
import { AppLogger } from './logging/app-logger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useLogger(new AppLogger());

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  const config = new DocumentBuilder()
    .setTitle('ReceiptPal')
    .setDescription('ReceiptPal API description')
    .setVersion('1.0')
    .addTag('receipt-pal')
    .build();

  const options: SwaggerDocumentOptions = {
    operationIdFactory: (_, methodKey: string) => methodKey,
  };

  const document = SwaggerModule.createDocument(app, config, options);
  SwaggerModule.setup('api', app, document);
  const yamlString: string = stringify(document, {});
  fs.writeFileSync('receipt-pal-api-doc.yaml', yamlString);

  await app.listen(3000);
}
bootstrap();
