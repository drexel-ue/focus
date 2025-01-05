BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "routine_steps" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "routine_segments" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "routine_records" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL,
    "lastModifiedAt" timestamp without time zone NOT NULL,
    "userId" bigint NOT NULL,
    "routineId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'running'::text
);

--
-- ACTION DROP TABLE
--
DROP TABLE "routines" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "routines" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL,
    "lastModifiedAt" timestamp without time zone NOT NULL,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "steps" json NOT NULL,
    "buffs" json NOT NULL,
    "debuffs" json NOT NULL
);


--
-- MIGRATION VERSION FOR focus
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('focus', '20250105230123639', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250105230123639', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
