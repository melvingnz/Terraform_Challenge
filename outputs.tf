output "Challenge_for_Interview_Public_IP" {
  value = aws_instance.challenge_for_interview.public_ip
}

output "Challenge_for_Interview_Private_IP" {
  value = aws_instance.challenge_for_interview.private_ip
}

output "Challenge_for_Interview_Instance_ID" {
  value = aws_instance.challenge_for_interview.id
}
