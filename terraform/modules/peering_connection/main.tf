resource "aws_vpc_peering_connection" "project_peering" {
  peer_vpc_id = var.requester_vpc_id
  vpc_id      = var.accepter_vpc_id
  auto_accept = true
  tags = {
    Name = var.peering_name
  }
}
