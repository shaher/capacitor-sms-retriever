# @shaher/capacitor-sms-retriever

A comprehensive Capacitor plugin for SMS retrieval on Android with advanced hash code generation capabilities.

## Features

- ✅ **Android SMS Auto-Retrieval** - Uses Google's SMS Retriever API
- ✅ **iOS Manual PIN Input** - Beautiful PIN input dialog
- ✅ **App Signature Hash Generation** - Get the required hash for SMS messages
- ✅ **TypeScript Support** - Full TypeScript definitions included
- ✅ **No Permissions Required** - Uses official SMS Retriever API

## Installation

```bash
npm install @shaher/capacitor-sms-retriever
npx cap sync
```

## API Methods

### `startListening()` - Android Only
Starts listening for incoming SMS messages using the SMS Retriever API.

### `stopListening()` - Android Only  
Stops listening for SMS messages.

### `present(options?)` - iOS Only
Shows a PIN input dialog for manual OTP entry.

### `getHashCode()` - Android Only ⭐ NEW
Gets the app signature hash required for SMS Retriever API.

## Usage Examples

### Android - Automatic SMS Retrieval

```typescript
import { CapacitorSmsRetriever } from '@shaher/capacitor-sms-retriever';

// Get the app signature hash (needed for your backend)
const hashResult = await CapacitorSmsRetriever.getHashCode();
console.log('App Hash:', hashResult.hashCode); // e.g., "FA+9qCX9VSu"

// Start listening for SMS
CapacitorSmsRetriever.startListening().then((result) => {
  console.log('SMS received:', result.body);
  // Extract OTP from SMS body
}).catch((error) => {
  console.error('SMS retrieval failed:', error);
});

// Stop listening when done
CapacitorSmsRetriever.stopListening();
```

### iOS - Manual PIN Input

```typescript
import { CapacitorSmsRetriever } from '@shaher/capacitor-sms-retriever';

// Show PIN input dialog (4 digits by default)
CapacitorSmsRetriever.present({ numberOfCharacters: 6 }).then((result) => {
  console.log('PIN entered:', result.code);
}).catch((error) => {
  console.error('PIN input cancelled:', error);
});
```

### SMS Message Format (Android)

Your backend should send SMS messages in this format:

```
Your verification code is: 123456

<#> Your App Name
Your code: 123456
FA+9qCX9VSu
```

Where `FA+9qCX9VSu` is the hash returned by `getHashCode()`.

## Platform Support

| Method | Android | iOS | Web |
|--------|---------|-----|-----|
| `startListening()` | ✅ | ❌* | ❌* |
| `stopListening()` | ✅ | ❌* | ❌* |
| `present()` | ❌* | ✅ | ❌* |
| `getHashCode()` | ✅ | ❌* | ❌* |

*Platform returns appropriate error message

## Requirements

- **Android**: API level 14+ (SMS Retriever API requires API 14+)
- **iOS**: iOS 14.0+
- **Capacitor**: v7.0.0+

## License

MIT

## Credits

Based on @skmd87/capacitor-sms-retriever with added iOS support and getHashCode functionality.