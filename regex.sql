SELECT
  email,
  REGEXP_CONTAINS(email, r"@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+") AS is_valid
FROM
  (SELECT
    ["foo@example.com", "bar@example.org", "www.example.net"]
    AS addresses),
  UNNEST(addresses) AS email;
