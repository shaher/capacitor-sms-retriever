import { WebPlugin } from '@capacitor/core';

import type { CapacitorSmsRetrieverPlugin, HashCodeResponse, PresentOptions, StartSuccessResponse } from './definitions';

export class CapacitorSmsRetrieverWeb extends WebPlugin implements CapacitorSmsRetrieverPlugin {
  async startListening(): Promise<StartSuccessResponse> {
    console.warn('Capacitor SMS Retriever not available on web');
    return Promise.resolve({ body: 'Capacitor SMS Retriever not available on web' });
  }
  async stopListening(): Promise<void> {
    return Promise.reject(new Error('Capacitor SMS Retriever not available on web'));
  }

  async present(options?: PresentOptions): Promise<{ code: string }> {
    console.log('Present options:', options);
    return Promise.reject(new Error('Capacitor SMS Retriever not available on web'));
  }

  async getHashCode(): Promise<HashCodeResponse> {
    return Promise.reject(new Error('Capacitor SMS Retriever getHashCode not available on web'));
  }
}
