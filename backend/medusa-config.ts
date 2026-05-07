import { defineConfig } from "@medusajs/framework";
import { Modules } from "@medusajs/framework/utils";

export const config = defineConfig({
  projectConfig: {
    http: {
      storeCors: process.env.STORE_CORS || "http://localhost:8000",
      adminCors: process.env.ADMIN_CORS || "http://localhost:9000",
      authCors: process.env.AUTH_CORS || "http://localhost:8000",
      jwtSecret: process.env.JWT_SECRET || "supersecret",
      cookieSecret: process.env.COOKIE_SECRET || "supersecret",
    },
    database: {
      clientUrl: process.env.DATABASE_URL || "sqlite://db.sqlite",
      url: process.env.DATABASE_URL || "sqlite://db.sqlite",
    },
    admin: {
      disable: process.env.MEDUSA_DISABLE_ADMIN === "true" ? true : false,
    },
  },
  modules: [
    {
      resolve: "@medusajs/medusa/event-bus-local",
      options: {
        mode: process.env.MEDUSA_WORKER_MODE || "shared",
      },
    },
    {
      resolve: "@medusajs/medusa/cache-inmemory",
    },
    {
      resolve: "@medusajs/framework/utils",
    },
  ],
});
