import { applyDecorators, Type } from '@nestjs/common';
import { ApiResponse, ApiExtraModels, getSchemaPath } from '@nestjs/swagger';
import { ApiResponseDto } from '../models/api-response.dto';

// Add an optional "isArray" flag to indicate if the response data is an array or a single object
export const ApiGenericResponse = <TModel extends Type<any>>(
  model: TModel,
  isArray: boolean = false,
) => {
  return applyDecorators(
    ApiExtraModels(ApiResponseDto, model),
    ApiResponse({
      status: 200,
      schema: {
        allOf: [
          { $ref: getSchemaPath(ApiResponseDto) },
          {
            properties: {
              data: isArray
                ? { type: 'array', items: { $ref: getSchemaPath(model) } } // Array of models
                : { $ref: getSchemaPath(model) }, // Single model
              error: {
                type: 'string',
                nullable: true,
                example: null,
                description:
                  'An optional error message if something went wrong',
              },
            },
          },
        ],
      },
    }),
  );
};
