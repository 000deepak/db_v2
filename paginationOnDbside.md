If you’re dealing with millions of records, pagination **must happen at the database level**, not in memory—otherwise performance will collapse quickly. In Spring Boot (typically with Spring Data JPA), there are a few solid approaches depending on your use case.

---

## 1. Standard Pagination with `Pageable` (OFFSET-based)

This is the easiest and built-in way.

### Repository

```java
public interface UserRepository extends JpaRepository<User, Long> {
    Page<User> findAll(Pageable pageable);
}
```

### Service / Usage

```java
Pageable pageable = PageRequest.of(pageNumber, pageSize, Sort.by("id").ascending());
Page<User> page = userRepository.findAll(pageable);

List<User> users = page.getContent();
```

### SQL generated (roughly)

```sql
SELECT * FROM users
ORDER BY id
LIMIT 20 OFFSET 40;
```

### ⚠️ Problem with large data

OFFSET becomes slow for deep pages because the database still scans skipped rows.

---

## 2. Keyset Pagination (Recommended for Millions of Rows)

This is **much more efficient** for large datasets.

Instead of OFFSET, you paginate using a **cursor (last seen value)**.

### Example (using ID as cursor)

### Repository

```java
@Query("SELECT u FROM User u WHERE u.id > :lastId ORDER BY u.id ASC")
List<User> findNextPage(@Param("lastId") Long lastId, Pageable pageable);
```

### Usage

```java
Pageable pageable = PageRequest.of(0, 20); // always page 0
List<User> users = userRepository.findNextPage(lastSeenId, pageable);
```

### SQL

```sql
SELECT * FROM users
WHERE id > 1000
ORDER BY id ASC
LIMIT 20;
```

### Why this is better

* Uses index efficiently
* No row skipping
* Constant performance even for large datasets

### ⚠️ Requirement

* You need a **stable, indexed column** (e.g., `id`, `created_at`)

---

## 3. Slice Instead of Page (Avoid Count Query)

If you don’t need total count (which is expensive for big tables):

```java
Slice<User> slice = userRepository.findAll(pageable);
```

* Avoids `SELECT COUNT(*)`
* Faster for large datasets

---

## 4. Native Query Pagination (More Control)

```java
@Query(
  value = "SELECT * FROM users ORDER BY id LIMIT :limit OFFSET :offset",
  nativeQuery = true
)
List<User> findUsers(@Param("limit") int limit, @Param("offset") int offset);
```

Use this if:

* You need custom joins
* You want DB-specific optimizations

---

## 5. Indexing is Critical

Pagination performance depends heavily on indexing.

Make sure:

```sql
CREATE INDEX idx_users_id ON users(id);
```

Or for sorting:

```sql
CREATE INDEX idx_users_created_at ON users(created_at);
```

---

## 6. When to Use What

* Small/medium datasets → `Pageable` (OFFSET is fine)
* Large datasets (millions+) → **Keyset pagination**
* Infinite scroll APIs → **Keyset + Slice**
* Analytics queries → Native queries

---

## 7. Common Mistakes to Avoid

* ❌ Fetching all records and paginating in Java
* ❌ Using OFFSET for very large page numbers
* ❌ Missing indexes on sort/filter columns
* ❌ Using `Page` when count is unnecessary

---

## Quick Rule of Thumb

If your query looks like this:

```sql
LIMIT 20 OFFSET 1000000
```

You’re already in trouble.

Switch to:

```sql
WHERE id > last_seen_id LIMIT 20
```

---

If you want, I can show:

* Cursor-based pagination API design (REST)
* Spring Boot implementation with DTOs
* How to handle sorting with keyset pagination (slightly tricky but doable)
