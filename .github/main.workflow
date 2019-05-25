workflow "Prose lint" {
  on = "push"
  resolves = ["node"]
}

action "node" {
  uses = "docker://node:10"
  runs = "npx alex **/*.md"
}