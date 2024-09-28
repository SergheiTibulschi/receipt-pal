import { Database } from '../../database.types';

export type ReceiptItemInsert =
  Database['public']['Tables']['receipt_items']['Insert'];

export type ReceiptVarDetailsInsert =
  Database['public']['Tables']['vat_details']['Insert'];
