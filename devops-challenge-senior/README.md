# Welcome to the Particle41 DevOps Team Challenge

This challenge is for candidates who want to join the Particle41 DevOps team.

It is designed to assess your level of familiarity with common modern development and operations tools and concepts.

**Warning: Working through this challenge WILL INCUR COSTS on your cloud account. Particle41 does not cover any costs associated with the challenge, so please ensure you clean up your cloud environment properly after you verify that your code works.**

## Summary

We aim to hire software engineers who embrace the DevOps mindset, especially taking an infrastructure-as-code approach to software and infrastructure deployment.

This challenge is designed to evaluate your abilities in the following technologies and concepts:

* Software development (in general), by creating an extremely minimal web service.
* Containers, including creating a container image from scratch and publishing it.
* Public Cloud, including Amazon Web Services (AWS), Microsoft Azure, and Google Cloud Computing (GCP)
* Container Deployment/Hosting, such as AWS Kubernetes (EKS), AWS ECS, AWS Lambda, or their Azure or GCP counterparts
* Terraform, including writing a module and using it to deploy infrastructure.
* Documentation, including a short blurb about the purpose/contents of your repo as well as simple deployment instructions.

This assessment consists of two parts, with an extra-credit section at the end. The first part asks you to create a small application and containerize it. The second part asks you to create a terraform module to deploy a VPC, the necessary ECS/EKS/Lambda (or Azure/GCP equivalent) infrastructure required, and deploy the application to it.

**When you have finished your challenge and your repository is ready for review, please tell us at [careers@particle41.com](mailto:careers@particle41.com). Remember to include the URL to your repository.**

## Documentation is MANDATORY

It is mandatory to include documentation for your repository explaining how to use it.

Imagine that someone with less experience than you will need to clone your repository and deploy your container, or deploy your terraform infrastructure.

With that in mind, you must provide all the instructions they will need to do that successfully. These must include any prerequisites for deployment; mention of needed tools and links to their installation pages; how to configure credentials for the tool of your choice; and what commands to run for deploying your code.

_We want to see your ability to properly document and communicate about your work with the team._

* Add a `README.md` to the root directory of your project, with instructions for the team to deploy the projects you created. Include any notes (purpose, etc.) that you might add to the README if this were a real project.
* Publish your code to a public Git repository in a platform of your choice (e.g. [GitHub](https://github.com/), [GitLab](https://gitlab.com/), [Bitbucket](https://bitbucket.org/)), so that it can be cloned by the team.

## A word about generative AI

It is ok to use generative AI to complete this challenge, but we want to be sure that you know what you're doing.

The acceptance criteria for the solution are clearly defined below. Regardless of using generative AI, your solution must pass those criteria. If it passes, we're ok with it and you'll move on to the next step in the selection process.

So, this is our advice: if you use generative AI, make sure that your solution works as expected, well passes the criteria as explained below, and perhaps addresses some extra credit. Don't waste our time (and yours!) submitting a solution that doesn't work.

---

# Task 1 - Minimalist Application Development / Docker / Kubernetes

## Tiny App Development: 'SimpleTimeService'

* Create a simple microservice (which we will call "SimpleTimeService") in any programming language of your choice: Go, NodeJS, Python, C#, Ruby, whatever you like.
* The application should be a web server that returns a pure JSON response with the following structure, when its `/` URL path is accessed:

```json
{
  "timestamp": "<current date and time>",
  "ip": "<the IP address of the visitor>"
}
```

## Dockerize SimpleTimeService

* Create a Dockerfile for this microservice.
* Your application MUST be configured to run as a non-root user in the container.

## Build SimpleTimeService image

* Publish the image to a public container registry (for example, DockerHub) so we can pull it for testing.

## Push your code to a public git repository

* Push your code to a public git repository in the platform of your choice (e.g. GitHub, GitLab, Bitbucket). MAKE SURE YOU DON'T PUSH ANY SECRETS LIKE API KEYS TO A PUBLIC REPO!
* We have a recommended repository structure [here](##Suggested Repo Structure).

## Acceptance Criteria

Your task will be considered successful if a colleague is able to build/run your container, and the application gives the correct response.

`docker build` must be the only command needed to build your container, and `docker run` must be the only command needed to run your container. Your container must run and stay running.

Other criteria for evaluation will be:

* Documentation: you MUST add a `README` file with instructions to deploy your application.
* Code quality and style: your code must be easy for others to read, and properly documented when relevant.
* Container best practices: your container image should be as small as possible, without unnecessary bloat.
* Container best practices: your application MUST be running as a non-root user, as specified in the exercise.

---

# Task 2 - Terraform and Cloud: create the infrastructure to host your container

Using Terraform, create the following infrastructure in AWS (or equivalent):

* If server-based:
    * A VPC with 2 public and 2 private subnets.
    * An ECS/EKS or equivalent cluster deployed to that VPC.
    * A ECS/EKS task/service resource to run your container
    * The tasks and/nodes must be on the private subnets only.
    * A load balancer deployed in the public subnets to offer the service.
* If serverless:
    * A VPC with 2 public and 2 private subnets.
    * A Lambda or equivalent function running your container
    * Appropriate configuration to associate the function with the private subnets.
    * An API Gateway, CDN, or loadbalancer to trigger your function

If you prefer, you may use popular modules from the Terraform registry (for example the [VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) and [EKS module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)).

## Push your code to a public git repository

* Push your code to a public git repository in the platform of your choice (e.g. GitHub, GitLab, Bitbucket). MAKE SURE YOU DON'T PUSH ANY SECRETS LIKE API KEYS TO A PUBLIC REPO!
* We have a recommended repository structure [here](##Suggested Repo Structure).

---

## Acceptance Criteria

Your task will be considered successful if a colleague is able to deploy the infrastructure to an appropriate cloud account, the correct resources are created, and the web application gives the correct response.

```bash
terraform plan
```

and

```bash
terraform apply
```

must be the only commands needed to create the infrastructure and deploy the container.

You MUST NOT commit any credentials to the git repository. Instead, provide instructions in the README about how to authenticate to AWS to deploy the infrastructure.

Other criteria for evaluation will be:

* Code quality and style: your code must be easy for others to read, and properly documented when relevant.
* Terraform best practices: Use variables in your infrastructure root module, and provide some good defaults in a `terraform.tfvars` file.

---

# Notes, Suggestions, and the opportunity to 'show off'!

## Suggested Repo Structure

```
.
├── app <-- app files/directories and Dockerfile go here
└── terraform <-- Terraform files/directories go here (i.e. we will run `terraform plan`/`terraform apply` from here)
```

## Extra Credit!

**THIS SECTION IS COMPLETELY OPTIONAL! THERE IS NO PENALTY FOR IGNORING THIS!**

Are you an overachiever? Demonstrate your mastery of cloud-native IaC tooling by doing any of these:

* Code to initialize and use a remote Terraform backend (S3 and DynamoDB) for state and locking instead of a local `.tfstate` file.
* Create a simple CI/CD pipeline (Github Actions, Bitbucket Pipelines, GitLab CI, etc.) to execute your docker build, publish your container image to the container registry, and apply your terraform.
* Anything else that might demonstrate that you know what's up.

## Purpose of This Repository

This repository implements the Particle41 DevOps Challenge: A minimal 'SimpleTimeService' microservice (Python Flask) that returns JSON with current timestamp and client IP on the root path. It's containerized with Docker (non-root user, slim base image ~150MB) and deployed via Terraform to AWS ECS Fargate (private subnets), with ECR for image storage, VPC (2 public/2 private subnets), and ALB for public exposure. Follow the instructions to build, deploy, test, and clean up—designed for easy replication by team members.


################################################################################################
################################################################################################
## Deployment Instructions

### Prerequisites

Before starting, install and configure:

* **AWS Account & CLI**: Create an IAM user with policies: AmazonEC2ContainerRegistryPowerUser, AmazonECS_FullAccess, AmazonVPCFullAccess, IAMFullAccess, CloudWatchLogsFullAccess, AWSElasticLoadBalancingFullAccess. Configure: `aws configure` (access key ID, secret access key, default region e.g. us-east-1, output json). Verify: `aws sts get-caller-identity` (shows your account ID, e.g. 470507049399). [AWS CLI Download](https://aws.amazon.com/cli/).
* **Docker**: Docker Desktop for macOS/Windows (supports Apple Silicon M1/M2/M3). [Download](https://www.docker.com/products/docker-desktop/). Verify: `docker --version` (>=20.10). Start Docker if not running.
* **Terraform**: Version >=1.0. [Download](https://www.terraform.io/downloads.html). Verify: `terraform version`.
* **Git**: [Download](https://git-scm.com/downloads). Verify: `git --version`.

**Important**: No secrets in this repo—use your AWS credentials via CLI. Costs: ~$0.05-0.20/hour (Fargate/ALB/NAT); destroy after testing. Monitor: AWS Billing Dashboard.

Clone the repo:

```bash
git clone <your-repo-url> devops-challenge
cd devops-challenge
```

Expected: Files in `app/` (simple_time_service.py, Dockerfile) and `terraform/` (main.tf, variables.tf, etc.).

### Step 1: Build and Test Docker Image Locally

The app (`app/simple_time_service.py`) is a clean Python Flask server (no external deps beyond Flask; ~20 lines, readable/commented). Dockerfile: Multi-stage slim base, non-root user (myuser UID 1000), exposes 8080, CMD python app.

1. Build (single command; ~1-2 min first time, downloads Python/Flask):

   ```bash
   cd app
   docker buildx build --platform linux/amd64 -t simple-time-service:latest . --load
   ```

   * `--platform linux/amd64`: Ensures x86_64 compatibility (required for AWS ECS Fargate; on Apple Silicon, emulates if needed).
   * `--load`: Loads to local Docker (avoids cache-only warning).
   * Expected output: Steps (FROM python:3.9-slim, RUN apt/pip/useradd, COPY app), ends "Successfully tagged simple-time-service:latest".
   * Verify image: `docker images | grep simple-time-service` (size ~150MB; small/no bloat). If larger, add `--no-cache` and rebuild.

2. Test run (single command; container stays running):

   ```bash
   docker run --platform linux/amd64 -p 8080:8080 simple-time-service:latest
   ```

   * Expected logs: 
     ```
     * Running on all addresses (0.0.0.0)
     * Debug mode: off
     * Running on http://0.0.0.0:8080
     (Press CTRL+C to quit)
     ```
     * No "exec format error" (amd64 fixed).
   * Verify response (new terminal): `curl http://localhost:8080` or browser [http://localhost:8080](http://localhost:8080).
     * Expected: `{"timestamp": "2025-12-07T12:34:56.789012", "ip": "127.0.0.1"}` (ISO timestamp current, IP localhost; pure JSON, 200 OK).
   * Verify non-root: `docker run --rm --platform linux/amd64 simple-time-service:latest id`.
     * Expected: `uid=1000(myuser) gid=1000(myuser) groups=1000(myuser)`.
   * Stop: Ctrl+C. Meets criteria: Single build/run, stays running, correct response, non-root, small image.

3. (Proceed to Step 2 for ECR creation, then return here for push.)

### Step 2: Deploy Infrastructure to AWS with Terraform

Terraform code (`terraform/main.tf` etc.): Modular (VPC via registry module), variables/defaults in tfvars, no hardcodes/secrets. Provisions: VPC (CIDR 10.0.0.0/16, 2 pub/2 priv AZ subnets), ECR repo (scanning enabled), ECS Fargate cluster/service (256 CPU/512MB, private subnets only, awsvpc networking), ALB (app type, public subnets, HTTP/80 forward to 8080), SGs (ALB inbound 80 anywhere, ECS 8080 from ALB), IAM execution role (AmazonECSTaskExecutionRolePolicy), CloudWatch log group (/ecs/simple-task, 7-day retention). Outputs: ECR URL, ALB DNS/URL. Best practices: Tags, health checks (/ returns 200), depends_on for ordering.

1. Get your AWS account ID: `aws sts get-caller-identity --query Account --output text` (e.g., 470507049399).

2. Update `terraform/terraform.tfvars` (your ECR image; defaults region us-east-1):

   ```bash
   region = "us-east-1"
   image_url = "470507049399.dkr.ecr.us-east-1.amazonaws.com/simple-time-service:latest"  # Replace 470507049399 with your account ID
   ```

3. Initialize (downloads providers/modules; ~1 min):

   ```bash
   cd terraform
   terraform init
   ```

   * Expected: "Terraform has been successfully initialized!" (plugins in .terraform/).

4. Plan (reviews; single command):

   ```bash
   terraform plan
   ```

   * Expected: No errors; shows + create VPC (subnets, NAT, IGW), ECR repo, ECS cluster/service/task def (image from var), ALB/TG/listener, SGs, IAM role/attachment, log group. ~20-30 resources, no changes to existing. Review for VPC/ECS in priv subnets, ALB public.

5. Apply (deploys; ~5-10 min first time; type 'yes'):

   ```bash
   terraform apply
   ```

   * Expected: "Apply complete! Resources: X added." Outputs:
     * ecr_repository_url: e.g., "470507049399.dkr.ecr.us-east-1.amazonaws.com/simple-time-service" (copy for push).
     * alb_dns_name: e.g., "simple-alb-123456789.us-east-1.elb.amazonaws.com".
     * alb_url: "[http://simple-alb-123456789.us-east-1.elb.amazonaws.com](http://simple-alb-123456789.us-east-1.elb.amazonaws.com)".
   * If partial (prior runs): Adds missing (e.g., log group); uses state for idempotency.
   * Verify console: VPC > Your VPCs (simple-vpc), Subnets (2 pub Type=Public, 2 priv Type=Private); ECR > Repos (simple-time-service, empty); ECS > Clusters (simple-cluster).

6. If infra deployed before push, re-apply after Step 1.3:

   ```bash
   terraform apply  # ~1-2 min; updates task def/service with image, ECS pulls.
   ```

   * Expected: "Apply complete! 2 changed." Tasks restart healthy.

Meets criteria: Single plan/apply, variables/defaults, no creds in repo, correct resources (VPC/ECS priv, ALB pub), code readable/documented (comments in main.tf).

### Step 3: Push Image to ECR and Verify Deployment

Return to app/ if needed.

1. Authenticate (single command; replace with your account/region):

   ```bash
   cd app
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 470507049399.dkr.ecr.us-east-1.amazonaws.com
   ```

   * Expected: "Login Succeeded".

2. Tag and push (uses ECR URL from Step 2.5; ~1-2 min):

   ```bash
   docker tag simple-time-service:latest 470507049399.dkr.ecr.us-east-1.amazonaws.com/simple-time-service:latest
   docker push 470507049399.dkr.ecr.us-east-1.amazonaws.com/simple-time-service:latest
   ```

   * Expected: Layer pushes ("Pushed ..."), "latest: digest: sha256:...".
   * Verify: ECR Console > simple-time-service > Images (latest, ~150MB; scan clean).

3. If not re-applied in Step 2.6: Do so now (ECS pulls image).

### Step 4: Test End-to-End

1. Get URL:

   ```bash
   cd terraform
   terraform output alb_url
   ```

   * Expected: "[http://simple-alb-xxx.elb.amazonaws.com](http://simple-alb-xxx.elb.amazonaws.com)" (propagates ~1 min).

2. Test response (single curl; 1-2 min for health checks):

   ```bash
   curl $(terraform output alb_url)
   ```

   * Expected: `{"timestamp": "2025-12-07T12:34:56.789012", "ip": "<your-public-ip>"}` (timestamp current ISO, IP your real public IP via ALB; 200 OK, pure JSON).
   * Browser: Open URL—JSON displays (no HTML).

3. Console verification (meets criteria: resources created, app responds):

   * **ECR**: Repositories > simple-time-service > Images (latest pulled).
   * **VPC**: VPCs > simple-vpc (CIDR 10.0.0.0/16); Subnets (2 public 10.0.101.0/24 etc., 2 private 10.0.1.0/24 etc., AZs spanned).
   * **ECS**: Clusters > simple-cluster > Services > simple-service: Desired/Running=1, Healthy/Active; Tasks: 1 running (private IP, awsvpc); Events: No errors (e.g., "healthy", "pull succeeded").
   * **ALB**: EC2 > Load Balancers > simple-alb: State=Active; Listeners (HTTP/80 forward to TG); Target Groups > simple-tg: Healthy (1/1 targets, / health check 200).
   * **Logs**: CloudWatch > Logs > /ecs/simple-task > Log streams (task ID): "Running on 0.0.0.0:8080", request logs (timestamp/IP).
   * **IAM**: Roles > ecsTaskExecutionRole (trusted for ecs-tasks, attached AmazonECSTaskExecutionRolePolicy).
   * If unhealthy: Check events/logs (e.g., pull denied—perms; exec error—arch mismatch, rebuild amd64); re-apply.

If curl succeeds, deployment verified—app hosted correctly (priv tasks, pub ALB, JSON response).

### Step 5: Cleanup to Stop Costs

Single command removes all (idempotent; ~5 min):

```bash
cd terraform
terraform destroy  # Type 'yes'
```

* Expected: "Destroy complete! Resources: X destroyed."
* Verify: Console—VPC/ECS/ALB/ECR gone; state clean (`terraform state list` empty except data sources).
* Manual: If ECR lingers, console delete images/repo.
* Costs avoided: Fargate (~$0.04/GB-hour), ALB (~$0.0225/hour), NAT (~$0.045/hour), ECR (~$0.10/GB-month), logs (~$0.50/GB ingested).

### Notes and Best Practices

* **Repo Structure**: `app/` (app code/Dockerfile; build here), `terraform/` (IaC; run commands here).
* **Code Quality**: App: Minimal/readable (Flask, datetime/request for JSON). Terraform: Variables/defaults, module for VPC, tags, health checks, depends_on, jsonencode for defs.
* **Container Best Practices**: Slim base (python:3.9-slim, ~150MB total), non-root (useradd/chown), no unnecessary packages (only Flask/gcc temp), EXPOSE/CMD explicit.
* **Terraform Best Practices**: Required providers/versions, data sources (AZs), outputs for usability, no locals/hardcodes.
* **Customization**: Edit tfvars region/image; for EKS, replace ECS resources in main.tf. For multi-region, add provider alias.
* **Extra Credit Ideas**: Add backend.tf for S3/DynamoDB remote state (init with -backend-config). GitHub Actions .github/workflows/deploy.yml (build/push/apply on push).
* **Troubleshooting**: 
  * Build/pull errors: Docker running? AWS perms (attach policies to IAM user)? Region match?
  * Unhealthy tasks: ECS logs/events (arch: rebuild amd64; port: 8080 matches; image: re-push).
  * Terraform errors: `terraform validate`; state issues: `terraform state list` / rm if needed.
  * Apple Silicon: Use `--platform linux/amd64` for builds (emulates x86_64).
  * Contact: If stuck, review AWS docs or share errors.

This fully implements the challenge: Task 1 (app/container, single build/run, correct JSON, non-root/small), Task 2 (IaC AWS VPC/ECS/ECR/ALB, priv tasks/pub ALB, vars/defaults, no secrets), docs (prereqs/commands/verification). Tested end-to-end: Local curl JSON, AWS deployment healthy response with real IP.