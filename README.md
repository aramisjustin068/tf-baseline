# tf-baseline

A small Terraform module that creates the network layer almost every AWS account
ends up needing: one VPC, public and private subnets across N availability
zones, and the routing that makes both useful. Nothing else.

## What it creates

- VPC with DNS support and DNS hostnames enabled
- One public and one private subnet per availability zone
- Internet gateway and a public route table
- Optional single NAT gateway and a private route table pointing at it

## Usage

```hcl
module "network" {
  source = "github.com/aramisjustin068/tf-baseline"

  name       = "staging"
  cidr_block = "10.20.0.0/16"
  az_count   = 2

  enable_nat_gateway = true

  tags = {
    Environment = "staging"
    Owner       = "platform"
  }
}
```

Then `terraform init`, `terraform plan -out tfplan`, `terraform apply tfplan`.

## Inputs

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | string | — | Prefix for resource names and the `Name` tag |
| `cidr_block` | string | `10.0.0.0/16` | VPC CIDR, must fit `/20` subnets |
| `az_count` | number | `2` | Availability zones to span, 1 to 4 |
| `enable_nat_gateway` | bool | `true` | Create one NAT gateway for private egress |
| `tags` | map(string) | `{}` | Extra tags merged into every resource |

## Outputs

`vpc_id`, `vpc_cidr_block`, `public_subnet_ids`, `private_subnet_ids`,
`nat_gateway_id`.

## Notes

- One NAT gateway, not one per zone: cheaper, and fine for non-critical
  environments. Need zonal redundancy? Fork the routing section.
- Subnets come from `cidrsubnet(var.cidr_block, 4, ...)`: a `/16` gives `/20`
  subnets with a wide gap between the public and private ranges.
- Requires Terraform >= 1.5 and the AWS provider 5.x.

## License

Released under the MIT License.
