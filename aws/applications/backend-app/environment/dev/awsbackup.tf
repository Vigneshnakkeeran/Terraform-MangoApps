# module "destination_vault" {

#   source = "../../../../modules/backup"
#   providers = {
#     aws = aws.useast1
#   }

#   # Vault
#   vault_name = "destination-vault"

#  }

resource "aws_backup_vault" "destination_vault" {
  provider = aws.us-east-1
  name     = "destination-vault"
}

module "aws_backup_selection" {

  source = "../../../../modules/backup"

  # Vault
  vault_name = "source-vault"

  # Plan
  plan_name = "cross-region-selection-tags-plan"

  # Multiple rules using a list of maps
  rules = [
    {
      name                = "cross-region"
      schedule            = "cron(0 0 * * ? *)"
      target_vault_name   = "source-vault"             #module.destination_vault.vault_id
      start_window        = 120
      completion_window   = 360
    #   lifecycle           = {}
      copy_actions        = [
        {
          lifecycle = {
            cold_storage_after = 0
            delete_after       = 90
          },
          destination_vault_arn = "${aws_backup_vault.destination_vault.arn}"
        }
      ]
    }
  ]

  # Multiple selections
  #  - Selection-1: By tags: Environment = prod, Owner = devops
  selections = [
    {
      name = "selection-1"
      selection_tags = [
        {
          type  = "STRINGEQUALS"
          key   = "Backup"
          value = "True"
        }
      ]
    }
  ]

#   tags = {
#     Owner       = "devops"
#     Environment = "prod"
#     Terraform   = true
#   }

}
