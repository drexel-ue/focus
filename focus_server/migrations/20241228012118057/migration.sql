BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tasks" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone,
    "lastModifiedAt" timestamp without time zone,
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
    VALUES ('focus', '20241228012118057', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20241228012118057', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
