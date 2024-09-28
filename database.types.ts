export type Database = {
  public: {
    Tables: {
      receipt_items: {
        Row: {
          amount: string;
          description: string;
          id: number;
          product_type: string;
          quantity: number;
          receipt_id: string;
          unit_price: number;
          vat_amount: number;
          vat_percentage: string;
        };
        Insert: {
          amount: string;
          description: string;
          id?: number;
          product_type: string;
          quantity: number;
          receipt_id: string;
          unit_price: number;
          vat_amount: number;
          vat_percentage: string;
        };
        Update: {
          amount?: string;
          description?: string;
          id?: number;
          product_type?: string;
          quantity?: number;
          receipt_id?: string;
          unit_price?: number;
          vat_amount?: number;
          vat_percentage?: string;
        };
        Relationships: [
          {
            foreignKeyName: 'receipt_items_receipt_id_fkey';
            columns: ['receipt_id'];
            isOneToOne: false;
            referencedRelation: 'receipts';
            referencedColumns: ['receipt_id'];
          },
        ];
      };
      receipts: {
        Row: {
          address: string;
          company_name: string;
          created_at: string | null;
          fiscal_code: string;
          fiscal_receipt_number: string;
          id: number;
          manufacturing_number: string;
          payment_method: string;
          purchased_at: string | null;
          receipt_id: string;
          registration_number: string;
          total_amount: number;
        };
        Insert: {
          address: string;
          company_name: string;
          created_at?: string | null;
          fiscal_code: string;
          fiscal_receipt_number: string;
          id?: number;
          manufacturing_number: string;
          payment_method: string;
          purchased_at?: string | null;
          receipt_id: string;
          registration_number: string;
          total_amount: number;
        };
        Update: {
          address?: string;
          company_name?: string;
          created_at?: string | null;
          fiscal_code?: string;
          fiscal_receipt_number?: string;
          id?: number;
          manufacturing_number?: string;
          payment_method?: string;
          purchased_at?: string | null;
          receipt_id?: string;
          registration_number?: string;
          total_amount?: number;
        };
        Relationships: [];
      };
      threads: {
        Row: {
          created_at: string | null;
          id: number;
          mega_message_id: string;
          thread_id: string;
          user_id: string;
        };
        Insert: {
          created_at?: string | null;
          id?: number;
          mega_message_id: string;
          thread_id: string;
          user_id: string;
        };
        Update: {
          created_at?: string | null;
          id?: number;
          mega_message_id?: string;
          thread_id?: string;
          user_id?: string;
        };
        Relationships: [];
      };
    };
    Views: {
      [_ in never]: never;
    };
    Functions: {
      [_ in never]: never;
    };
    Enums: {
      [_ in never]: never;
    };
    CompositeTypes: {
      [_ in never]: never;
    };
  };
};

type PublicSchema = Database[Extract<keyof Database, 'public'>];

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema['Tables'] & PublicSchema['Views'])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions['schema']]['Tables'] &
        Database[PublicTableNameOrOptions['schema']]['Views'])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions['schema']]['Tables'] &
      Database[PublicTableNameOrOptions['schema']]['Views'])[TableName] extends {
      Row: infer R;
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema['Tables'] &
        PublicSchema['Views'])
    ? (PublicSchema['Tables'] &
        PublicSchema['Views'])[PublicTableNameOrOptions] extends {
        Row: infer R;
      }
      ? R
      : never
    : never;

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema['Tables']
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions['schema']]['Tables']
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions['schema']]['Tables'][TableName] extends {
      Insert: infer I;
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema['Tables']
    ? PublicSchema['Tables'][PublicTableNameOrOptions] extends {
        Insert: infer I;
      }
      ? I
      : never
    : never;

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema['Tables']
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions['schema']]['Tables']
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions['schema']]['Tables'][TableName] extends {
      Update: infer U;
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema['Tables']
    ? PublicSchema['Tables'][PublicTableNameOrOptions] extends {
        Update: infer U;
      }
      ? U
      : never
    : never;

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema['Enums']
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions['schema']]['Enums']
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions['schema']]['Enums'][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema['Enums']
    ? PublicSchema['Enums'][PublicEnumNameOrOptions]
    : never;
