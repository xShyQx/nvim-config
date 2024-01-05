local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local config_dir = jdtls_dir .. "/config_linux"
local plugins_dir = jdtls_dir .. "/plugins/"
local jar_path = plugins_dir .. "org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar"
local lombok_path = jdtls_dir .. "/lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir " .. workspace_dir)

local java_home = os.getenv("JAVA_HOME")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local config = {
  cmd = {
    java_home .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar", jar_path,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      home = java_home,
    },
  },
  init_options = {
    bundles = {},
  },
  capabilities = capabilities,
}

require("jdtls").start_or_attach(config)
