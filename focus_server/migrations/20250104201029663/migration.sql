BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "users" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone,
    "lastModifiedAt" timestamp without time zone,
    "clerkUserId" text,
    "firstName" text,
    "lastName" text,
    "profileImageUrl" text,
    "abilityStats" json NOT NULL,
    "buffs" json NOT NULL,
    "debuffs" json NOT NULL
);


--
-- MIGRATION VERSION FOR focus
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('focus', '20250104201029663', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250104201029663', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
