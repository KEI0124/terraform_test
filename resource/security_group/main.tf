/**
* ## Usage
* ```
* module "security_group1" {
*   source = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/SATT-POC//module/security_group"
*   vpc_id = module.vpc.vpc_id
*   name   = "sg1"
*   ingress_rule = {
*     1 = {
*       description = "web port"     ←オプション：セキュリティグループの詳細
*       from_port   = 80,　　　　　 　 ←必須：ポートレンジ開始
*       to_port     = 80,　　　       ←必須：ポートレンジ終了
*       protocol    = "tcp"　　       ←必須：プロトコル
*       cidr_blocks = ["0.0.0.0/0"]　←必須：cidr_blocksまたはsource_security_group_idのどちらか必須。cidr_blocksの場合はlist(string)。source_security_group_idの場合はstring
*     },
*     2 = {
*       from_port                = 22,
*       to_port                  = 22,
*       protocol                 = "tcp"
*       source_security_group_id = module.security_group2.security_group_id
*     }
*   }
* }
* ```
*/

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = merge(var.tags, { "Name" = var.name })
}

resource "aws_security_group_rule" "ingress" {
  for_each                 = var.ingress_rule
  security_group_id        = aws_security_group.this.id
  description              = lookup(each.value, "description", null)
  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

resource "aws_security_group_rule" "egress" {
  for_each                 = var.egress_rule
  security_group_id        = aws_security_group.this.id
  description              = lookup(each.value, "description", null)
  type                     = "egress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}