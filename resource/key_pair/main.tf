/**
* ## Usage
* ##### キーペア自動生成(非推奨)
* ```hcl
* module "ssh_key_pair" {
*   source              = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/SATT-POC//module/key_pair"
*   key_name            = "satt-poc"
*   ssh_public_key_path = "secrets"
*   generate_ssh_key    = true
* }
* ```
* 
* ##### キーペア持参
* 事前にsecretsディレクトリ配下にsatt-poc2.pubを配置しておく
* ```hcl
* module "ssh_key_pair2" {
*   source              = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/SATT-POC//module/key_pair"
*   key_name            = "satt-poc2"
*   ssh_public_key_path = "secrets"
* }
* ```
*
* ## Note
*
* generate_ssh_keyオプションを使用することでキーペアの自動生成とAWSへの登録が可能になる。
* しかし、この方法でキーを生成＆登録するのは以下の観点から非推奨である。
*
* - 自動生成されたプライベートキーをGitリポジトリに残すミスをする危険性があるから。
* - Terraform stateファイル上にプライベートキーの内容が記録されてしまうから。
* - ローカル環境にキーペアが出力されるため、CodebuildのようなCIサーバ上で生成されたキーペアはCI終了時になくなるため
*
* よって自動生成は開発環境で一時的にキーペアを作成する必要がある場合や、キーペアを簡単に生成したい場合に用いること。
* Terraform管理外で作成されたキーペアを持参する方法で、キーを登録することが推奨される。
*/

locals {
  public_key_filename = format(
    "%s/%s%s",
    var.ssh_public_key_path,
    var.key_name,
    var.public_key_extension
  )

  private_key_filename = format(
    "%s/%s%s",
    var.ssh_public_key_path,
    var.key_name,
    var.private_key_extension
  )
}

resource "aws_key_pair" "imported" {
  count      = var.generate_ssh_key == false ? 1 : 0
  key_name   = var.key_name
  public_key = file(local.public_key_filename)
}

resource "tls_private_key" "default" {
  count     = var.generate_ssh_key == true ? 1 : 0
  algorithm = var.ssh_key_algorithm
}

resource "aws_key_pair" "generated" {
  count      = var.generate_ssh_key == true ? 1 : 0
  depends_on = [tls_private_key.default]
  key_name   = var.key_name
  public_key = tls_private_key.default[0].public_key_openssh
}

resource "local_file" "public_key_openssh" {
  count      = var.generate_ssh_key == true ? 1 : 0
  depends_on = [tls_private_key.default]
  content    = tls_private_key.default[0].public_key_openssh
  filename   = local.public_key_filename
}

resource "local_file" "private_key_pem" {
  count             = var.generate_ssh_key == true ? 1 : 0
  depends_on        = [tls_private_key.default]
  sensitive_content = tls_private_key.default[0].private_key_pem
  filename          = local.private_key_filename
  file_permission   = "0600"
}

