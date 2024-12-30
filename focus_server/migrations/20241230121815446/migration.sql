BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "routine_segments" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL,
    "lastModifiedAt" timestamp without time zone NOT NULL,
    "title" text NOT NULL,
    "_routinesSegmentsRoutinesId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "routine_steps" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL,
    "lastModifiedAt" timestamp without time zone NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "abilityExpValues" json NOT NULL,
    "_routinesStepsRoutinesId" bigint,
    "_routineSegmentsStepsRoutineSegmentsId" bigint
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "routines" (
    "id" bigserial PRIMARY KEY,
    "createdAt" timestamp without time zone NOT NULL,
    "lastModifiedAt" timestamp without time zone NOT NULL,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "active" boolean NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "tasks" ALTER COLUMN "createdAt" SET NOT NULL;
ALTER TABLE "tasks" ALTER COLUMN "lastModifiedAt" SET NOT NULL;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "routine_segments"
    ADD CONSTRAINT "routine_segments_fk_0"
    FOREIGN KEY("_routinesSegmentsRoutinesId")
    REFERENCES "routines"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "routine_steps"
    ADD CONSTRAINT "routine_steps_fk_0"
    FOREIGN KEY("_routinesStepsRoutinesId")
    REFERENCES "routines"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "routine_steps"
    ADD CONSTRAINT "routine_steps_fk_1"
    FOREIGN KEY("_routineSegmentsStepsRoutineSegmentsId")
    REFERENCES "routine_segments"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR focus
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('focus', '20241230121815446', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20241230121815446', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
