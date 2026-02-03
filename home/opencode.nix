{ pkgs, ... }:

let
  # Define your models in one place for consistency (DRY)
  models = {
    small = "ollama/qwen3:4b";
    coding = "ollama/qwen3:pro";
    reasoning = "ollama/qwq:pro";
    embedding = "ollama/nomic-embed-text";
  };
in
{
  # This writes the file to ~/.config/opencode/config.json
  home.file.".config/opencode/config.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    instructions = ["AGENTS.md"];

    # FIXED: "agents" -> "agent" (Singular key to fix the schema error)
    agent = {
      analysis = { model = models.small; };
      chat = { model = models.small; };

      # Senior roles get the 'pro' models
      coder = {
        model = models.coding;
        prompt = "Skip showing your internal chain-of-thought. Provide only the final code or answer. Use concise sub-headings to summarize your reasoning steps (e.g., ### Analysis, ### Implementation).";
      };
      planner = {
        model = models.reasoning;
        prompt = "Do not output raw thinking tags. Provide a structured final plan using sub-headings to indicate the stages of your reasoning.";
      };
      "code-reviewer" = {
        model = models.reasoning;
        prompt = "Skip showing your internal chain-of-thought. Provide only the final code or answer. Use concise sub-headings to summarize your reasoning steps (e.g., ### Analysis, ### Implementation).";
      };
      "test-generator" = { model = models.coding; };

      # Documentation
      "doc-writer" = { model = models.small; };

      # Indexing/Embeddings often require explicit model definition here
      # or under a top-level "embeddings" key depending on version.
      # Mapping them as agents for safety based on your original config:
      embeddings = { model = models.embedding; };
      indexer = { model = models.embedding; };
    };

    provider = {
      ollama = {
        name = "Ollama (local)";
        npm = "@ai-sdk/openai-compatible";
        options = {
          baseURL = "http://localhost:11434/v1";
        };
        # Explicitly listing models helps the CLI validate availability
        models = {
          "nomic-embed-text" = { name = "Nomic Embed Text (local)"; };
          "qwen3:pro" = { name = "Qwen3 30B A3B (local)"; };
          "qwen3:4b" = { name = "Qwen3 4B (local)"; };
          "qwq:pro" = { name = "QwQ 32B (local)"; };
          "gpt-oss:pro" = { name = "GPT OSS 20B (local)"; };
        };
      };
    };
  };
}