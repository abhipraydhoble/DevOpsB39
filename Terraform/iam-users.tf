resource "aws_iam_user" "u1" {
   name = "Laksha" 
}

resource "aws_iam_user" "u2" {
    name = "dhananjay-mane"
  
}

resource "aws_iam_user" "u3" {
    name = "tatya-vinchu"
}

resource "aws_iam_user" "u4" {
    name = "mahesh"
  
}

resource "aws_iam_group" "g1" {
    name = "Zapatlela"
  
}

resource "aws_iam_group_membership" "grpadd" {
    name = "useradd"

    users = [
      aws_iam_user.u1.name,
      aws_iam_user.u2.name,
      aws_iam_user.u3.name,
      aws_iam_user.u4.name  
    ]

    group = aws_iam_group.g1.name
  
}




