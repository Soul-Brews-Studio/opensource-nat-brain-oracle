---
title: Password hashing security: Use Argon2id (preferred) or bcrypt - never MD5/SHA1/S
tags: [password, hashing, bcrypt, argon2, security]
created: 2026-01-03
source: Knowledge gap fill
---

# Password hashing security: Use Argon2id (preferred) or bcrypt - never MD5/SHA1/S

Password hashing security: Use Argon2id (preferred) or bcrypt - never MD5/SHA1/SHA256 alone. Set cost factor high enough for 100-500ms hash time. Use unique salt per password (handled automatically by Argon2/bcrypt). Never store plaintext or reversible encryption. Implement rate limiting on login attempts.

---
*Added via Oracle Learn*
