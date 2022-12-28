provider "local" {
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default =["aws00-neo", "aws02-trinity", "aws02-morpheus"]
  }



output "for_directive" {
  value = <<EOF
		%{for name in var.user_names}
      %${name}
		%{endfor}
			EOF
}



