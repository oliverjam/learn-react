workflow "Prose lint" {
  on = "push"
  resolves = ["node"]
}

action "node" {
  uses = "node:10"
  runs = "npx alex"
}
