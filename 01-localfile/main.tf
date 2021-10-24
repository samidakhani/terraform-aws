resource "local_file" "creatfile" {
  filename = var.filename
  content  = "Random pet generated with value: ${random_pet.pet1.id}"
  depends_on = [
    random_pet.pet2
  ]
}

resource "random_pet" "pet1" {
  prefix    = "Mr"
  separator = "."
  length    = 1
}

resource "random_pet" "pet2" {
  prefix    = "Mrs"
  separator = "."
  length    = 1
}

output petname {
  value = random_pet.pet2.id
}