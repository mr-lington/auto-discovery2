resource "aws_iam_user" "ansible_user" {
  name = "ansible_user"
}
resource "aws_iam_access_key" "ansible_user" {
  user = aws_iam_user.ansible_user.name
}
resource "aws_iam_group" "ansible_group" {
  name = "ansible_group"
}
resource "aws_iam_user_group_membership" "ansible" {
  user = aws_iam_user.ansible_user.name
  groups = [aws_iam_group.ansible_group.name]
}
resource "aws_iam_group_policy_attachment" "ansible_policy" {
  group      = aws_iam_group.ansible_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}