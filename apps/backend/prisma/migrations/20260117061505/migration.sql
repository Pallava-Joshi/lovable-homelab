/*
  Warnings:

  - The values [GET_CONTEXT,SAVE_CONTEXT] on the enum `ToolCall` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `ProjectContext` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ToolCall_new" AS ENUM ('CREATE_FILE', 'READ_FILE', 'DELETE_FILE', 'EXECUTE_COMMAND', 'RENAME_FILE', 'LIST_DIRECTORIES', 'TEST_BUILD', 'WRITE_MULTIPLE_FILES', 'CHECK_MISSING_DEPENDENCIES', 'ADD_DEPENDENCY');
ALTER TABLE "Conversation" ALTER COLUMN "toolCall" TYPE "ToolCall_new" USING ("toolCall"::text::"ToolCall_new");
ALTER TYPE "ToolCall" RENAME TO "ToolCall_old";
ALTER TYPE "ToolCall_new" RENAME TO "ToolCall";
DROP TYPE "public"."ToolCall_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "ProjectContext" DROP CONSTRAINT "ProjectContext_projectId_fkey";

-- DropTable
DROP TABLE "ProjectContext";

-- DropEnum
DROP TYPE "ContextType";
