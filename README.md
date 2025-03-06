# terraform-training-jamfpro

This repository serves as a **terraform training repository** for workplace engineers new to using terraform for management of Jamf Pro instances. The content within this repo aims to provide a learning path taking someone with little to no experience on a journey whereby at the end, the engineer feels empowered to use DevOps tools and practises within their team at a profient level.

This training does not seek to reinvent the wheel, so where it's senisble links will be provided to other publically available training materials. However, using DevOps practises with workplace teams is a relatively new concept and there are distinctions between IaC (infrastructure as code) and CaC (configuration-as-code) using IaC principles. To that end, rather than direct people to training that IaC targetted, this repo will house material, exercises and hackathons relevant to the workplace domain and it's nuances.

## 00: DevOps Training path for workplace engineers

### learning path diagram

https://roadmap.sh/devops

--devops culture

--problem statements

--devops principles


## 01: Visual Studio Code for workplace engineers

--what and why ?

### Visual Studio Code Extension Market Place

- [Visual Studio Code Extension Market Place](https://marketplace.visualstudio.com/)

### General Extensions

- [Binary Plist](https://marketplace.visualstudio.com/items?itemName=dnicolson.binary-plist)
- [GitHub Codespaces](https://marketplace.visualstudio.com/items?itemName=GitHub.codespaces)
- [GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github)
- [gitignore](https://marketplace.visualstudio.com/items?itemName=codezombiech.gitignore)
- [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
- [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
- [pre-commit](https://marketplace.visualstudio.com/items?itemName=elagil.pre-commit-helper)
- [TODO Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
- [VSNotes](https://marketplace.visualstudio.com/items?itemName=patricklee.vsnotes)
- [indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)

### Language Extentions

- [AppleScript](https://marketplace.visualstudio.com/items?itemName=idleberg.applescript)
- [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
- [docs-yaml](https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-yaml)
- [Edit CSV](https://marketplace.visualstudio.com/items?itemName=janisdd.vscode-edit-csv)
- [Go](https://marketplace.visualstudio.com/items?itemName=golang.Go) - Go(Lang) Language Support
- [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
- [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [Shebang Language Associator](https://marketplace.visualstudio.com/items?itemName=davidhewitt.shebang-language-associator)
- [ShellCheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck)
- [XML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) - XML Language Support
- [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) - YAML Language Support

### Linting Extensions

### Themes

themes for VS code are an entirely personal perference, here are some optional suggestions.

- [Nord](https://marketplace.visualstudio.com/items?itemName=arcticicestudio.nord-visual-studio-code)
- [One Dark Pro](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme)
- [GitHub Theme](https://marketplace.visualstudio.com/items?itemName=GitHub.github-vscode-theme)
- [Slack Theme](https://marketplace.visualstudio.com/items?itemName=felipe-mendes.slack-theme)
- [Dracula Theme](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)

--workspaces

--settings sync

--github

--shortcuts and keybindings https://code.visualstudio.com/docs/getstarted/keybindings

Challenges:

--build dev environment


https://github.com/smithjw/vs-code-mac-admins?tab=readme-ov-file


## 02: Terminal for Workplace Engineers

--picking a terminal

--customization


https://scrimba.com/articles/web-developer-terminal/


## 03: VCS for Workplace Engineers


https://www.freecodecamp.org/news/learn-git-through-gamification/


--push

--merge

--conflicts

Challenges:


## 04: GitHub Actions for Workplace Engineers

--runners

--events

--jobs

--yaml

--act - Run your GitHub Actions locally 🚀

--reuseable workflows - https://docs.github.com/en/actions

--repo templates

--dependancy management 

Challenges:

https://learn.microsoft.com/en-us/training/paths/github-actions/

https://youtu.be/Tz7FsunBbfQ?si=6ULhdjUdK9obKsFb

--Questions:


https://github.com/nektos/act


## 05: GitOps for Workplace Engineers

--Branching strategies

--gitlab flow (terraform)

--pr approvals

Challenges:

--Questions:


## 06: Versioning and release strategy for workplace

Engineers 

--semvar

--conventional commits

--release please


## 07: Containers for workplace Engineers 

https://roadmap.sh/docker

--docker base images

Challenges:

--Questions:


## 08: Secrets Management for Workplace Engineers

--machine identity 

--hashivault

--breakglass accounts

https://developer.hashicorp.com/vault/tutorials/get-started 

Challenges:

--Questions:


## 09: Terraform for Workplace Engineers

--Learning path 

https://roadmap.sh/terraform

--usecases

https://github.com/collabnix/terraform/blob/master/getting-started/use-cases.md

--declarative vs. imperitive 

--local install

https://github.com/collabnix/terraform/tree/master/beginners/os

--commands

--providers

--resources

https://github.com/collabnix/terraform/blob/master/beginners/resources/Terraform_Resources.md

--workspaces 

--data sources

--modules

--provisioners

--state and state locking

--taint and untaint

--secrets management

--hcl syntax and language features 

https://github.com/zealvora/terraform-beginner-to-advanced-resource/tree/master/Section%202%20-%20Read%2C%20Generate%2C%20Modify%20Congiruations

https://github.com/sidpalas/devops-directive-terraform-course/tree/main/05-language-features

--naming conventions

https://www.terraform-best-practices.com/naming

--using locals

--using variables

--code quality and repo structure 

https://developer.hashicorp.com/terraform/language/style

http://www.marktinderholt.com/terraform/2024/12/04/six-terraform-formatting-tips.html 

--best practice 

https://www.terraform-best-practices.com/

--further reading 

https://github.com/shuaibiyy/awesome-tf

--Challenges:


--Questions

https://www.datacamp.com/blog/terraform-interview-questions


## 10: SaaS Platform Monitoring for workplace Engineers 

--open telemetry 

--inbuilt incident reporting

--log management 