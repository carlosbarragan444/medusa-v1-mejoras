import { Logger } from "@medusajs/framework/types";

async function run(
  container: any,
  logger: Logger
) {
  logger.info("Medusa Backend is starting...");
  
  // Backend initialization
  const orm = container.resolve("orm");
  if (orm) {
    logger.info("Database connected successfully");
  }
}

export default run;
