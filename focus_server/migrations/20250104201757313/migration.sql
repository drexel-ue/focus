BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "tasks" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tasks" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL,
    "lastModifiedAt" timestamp without time zone NOT NULL,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "completed" boolean NOT NULL DEFAULT false,
    "abilityExpValues" json NOT NULL
);


--
-- MIGRATION VERSION FOR focus
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('focus', '20250104201757313', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250104201757313', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
