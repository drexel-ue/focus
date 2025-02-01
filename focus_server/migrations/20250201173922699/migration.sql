BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "tasks" DROP COLUMN "abilityExpValues";

--
-- MIGRATION VERSION FOR focus
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('focus', '20250201173922699', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250201173922699', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
