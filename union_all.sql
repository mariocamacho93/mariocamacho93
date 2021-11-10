SELECT id, first_name, last_name
FROM  (SELECT 1 as Id,
    "John" AS first_name,
    "Doe" AS last_name
  UNION ALL
  SELECT 2 as Id,
    "Jane" AS first_name,
    "Smith" AS last_name
  UNION ALL
  SELECT 3 as Id,
    "Joe" AS first_name,
    "Jackson" AS last_name);
