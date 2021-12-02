terraform {
  backend "remote" {
    organization = "MelvinGonzalez"

    workspaces {
      name = "Challenge_for_Interview"
    }
  }
}
