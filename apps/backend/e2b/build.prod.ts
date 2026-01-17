import { config } from "dotenv";
import { Template, defaultBuildLogger } from "e2b";
import { reactTemplate } from "./e2b-template";
config();
async function main() {
  await Template.build(reactTemplate, {
    alias: "lovable-homelab-base",
    cpuCount: 1,
    memoryMB: 1024,
    onBuildLogs: defaultBuildLogger(),
  });
  console.log("Built Successful");
}

main().catch(console.error);
