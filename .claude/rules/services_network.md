## 4. Services & Network

**Service pattern (cache-first with fallback):**
1. If not `forceRefresh`, try cache first (`repository.getAll()`). Return if non-empty.
2. Call API via `ProductNetworkModel`.
3. On success: map to models, save to cache (`deleteAll` then `save` each), return models.
4. On error: fallback to cache. Return cached data or empty list.

**Network result handling:**
- Use `result.fold(onSuccess:, onError:)` — never raw try-catch around network calls.
- API endpoints live in `lib/product/constants/api_endpoints.dart`.
