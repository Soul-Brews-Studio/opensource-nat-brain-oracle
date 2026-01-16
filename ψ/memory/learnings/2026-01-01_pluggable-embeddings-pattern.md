# Pluggable Embeddings Pattern

**Date**: 2026-01-01
**Context**: Data-Aware RAG v6 - Multi-provider embeddings

## The Pattern

### 1. Provider Interface

```typescript
export interface EmbeddingProvider {
  name: string;
  embed(texts: string[]): Promise<number[][]>;
  dimensions: number;
}

export type EmbeddingProviderType = 'chromadb' | 'openai' | 'ollama';
```

Key fields:
- `name`: For logging/debugging
- `dimensions`: Vector size (affects ChromaDB collection)
- `embed()`: Batch embedding function

### 2. Provider Implementations

```typescript
// OpenAI - cloud, high quality
class OpenAIEmbeddings implements EmbeddingProvider {
  dimensions = 1536; // text-embedding-3-small

  async embed(texts: string[]): Promise<number[][]> {
    const response = await fetch('https://api.openai.com/v1/embeddings', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.apiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        input: texts,
        model: 'text-embedding-3-small',
      }),
    });
    const data = await response.json();
    return data.data.map(d => d.embedding);
  }
}

// Ollama - local, free
class OllamaEmbeddings implements EmbeddingProvider {
  dimensions = 768; // nomic-embed-text

  async embed(texts: string[]): Promise<number[][]> {
    const embeddings = [];
    for (const text of texts) {
      const response = await fetch(`${this.baseUrl}/api/embeddings`, {
        method: 'POST',
        body: JSON.stringify({ model: this.model, prompt: text }),
      });
      const data = await response.json();
      embeddings.push(data.embedding);
    }
    return embeddings;
  }
}
```

### 3. Factory Pattern

```typescript
export function createEmbeddingProvider(config: EmbeddingConfig): EmbeddingProvider {
  switch (config.provider) {
    case 'openai':
      return new OpenAIEmbeddings({ apiKey: config.apiKey });
    case 'ollama':
      return new OllamaEmbeddings({ baseUrl: config.baseUrl });
    default:
      return new ChromaDBEmbeddings();
  }
}
```

### 4. Environment Config

```typescript
export function loadEmbeddingConfig(): EmbeddingConfig {
  return {
    provider: process.env.EMBEDDING_PROVIDER || 'chromadb',
    model: process.env.EMBEDDING_MODEL,
    apiKey: process.env.OPENAI_API_KEY,
    baseUrl: process.env.OLLAMA_BASE_URL || 'http://localhost:11434',
  };
}
```

### 5. CLI Integration

```bash
# Use default (ChromaDB)
bunx data-rag index ./data

# Use OpenAI
bunx data-rag index ./data --embeddings openai

# Use Ollama
bunx data-rag index ./data --embeddings ollama --embedding-model nomic-embed-text
```

## Provider Comparison

| Provider | Dims | Speed | Cost | Quality |
|----------|------|-------|------|---------|
| ChromaDB | 384 | Fast | Free | Good |
| OpenAI | 1536 | Medium | $ | Excellent |
| Ollama | 768 | Slow | Free | Very Good |

## Anti-Patterns

```typescript
// BAD: Hardcoded provider
const embeddings = await openai.embed(texts);

// GOOD: Provider abstraction
const provider = createEmbeddingProvider(config);
const embeddings = await provider.embed(texts);

// BAD: Check provider in every function
if (config.provider === 'openai') {
  // OpenAI code
} else if (config.provider === 'ollama') {
  // Ollama code
}

// GOOD: Polymorphism via interface
const provider = getEmbeddingProvider();
const embeddings = await provider.embed(texts);
```

## Key Decisions

| Decision | Rationale |
|----------|-----------|
| Interface-based | Easy to add new providers |
| Singleton pattern | Reuse initialized provider |
| Env-based config | No config file needed |
| Batch API | OpenAI accepts arrays |

---

*Pluggable embeddings: Interface + Factory + Environment config*
