export interface StartSuccessResponse {
  body: string;
}

export interface ErrorResponse {
  reason: string;
}

export interface HashCodeResponse {
  hashCode: string;
}

export interface CapacitorSmsRetrieverPlugin {
  startListening(): Promise<StartSuccessResponse>;
  stopListening(): Promise<void>;
  present(): Promise<{ code: string }>;
  getHashCode(): Promise<HashCodeResponse>;
}
