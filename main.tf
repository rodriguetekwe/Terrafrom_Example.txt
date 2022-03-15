terraform {
  required_providers {
    template = "~> 2.1.2"
  }
}

data "template_file" "example" {
  count = var.number
  vars = {
    flower = var.flower
  }
  template = <<EOF
       %{ for i in range(var.number) }
        ${i+1} A $${flower} by any other name would smell as sweet.
    %{ endfor }
  EOF
  
}

resource "local_file" "example" {
  count = var.number_of_files
  content = data.template_file.example[count.index].rendered
  filename = "example${count.index +1}.txt"
}
variable "flower" {
  description = "a variable for our template"
  default = "rose"
}
variable "number" {
  description = "number of line in the file"
  default = 4
}
variable "number_of_files" {
  description = "number of files to create"
  default = 3
}