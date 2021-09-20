K3S_CLUSTER_NAME			:= k3s-develop
TERRAFORM_BIN 				:= /usr/local/bin/terraform
TERRAFORM_STATE_NAME	:= tf-states-${K3S_CLUSTER_NAME}
TERRAFORM_VARFILE     := variables.tfvars
AWS_ACCESS_KEY_ID 		?= 112233445566
AWS_SECRET_ACCESS_KEY ?= 112233445566
AWS_REGION						:= us-east-1

.PHONY: init init-state init-dynamodb

.DEFAULT_GOAL := plan

test-creds:
	aws sts get-caller-identity

init-state:
	@echo Creating S3 state and DynamoDB lock
	aws --no-cli-pager s3api create-bucket \
		--bucket ${TERRAFORM_STATE_NAME} \
		--acl private \
		--region ${AWS_REGION}
	aws s3api put-bucket-versioning \
		--bucket ${TERRAFORM_STATE_NAME} \
		--versioning-configuration Status=Enabled \
		--no-cli-pager

render-state:
	@echo ToDo: Renders TF files state

init-dynamodb:
	@echo Creating S3 state and DynamoDB lock

init:
	${TERRAFORM_BIN} init

validate:
	${TERRAFORM_BIN} validate

plan: validate
	${TERRAFORM_BIN} plan -var-file=$(TERRAFORM_VARFILE)

vplan: validate
	TF_LOG=DEBUG ${TERRAFORM_BIN} plan -var-file=$(TERRAFORM_VARFILE) -no-color | tee vplan_out

apply: validate
	${TERRAFORM_BIN} apply -var-file=$(TERRAFORM_VARFILE)

create: validate
	${TERRAFORM_BIN} apply -var-file=$(TERRAFORM_VARFILE) -auto-approve \
		-no-color

destroy:
	terraform destroy -var-file=$(TERRAFORM_VARFILE)

destroy-now:
	terraform destroy -auto-approve -var-file=$(TERRAFORM_VARFILE)

copy-repo-remote:
	@echo Copy repo
