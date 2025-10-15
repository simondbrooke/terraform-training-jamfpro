# 🧠 Hackday: Jamf Pro → Terraform Migration

**Objectives and Tasks**

---

## 🎯 Objective

The goal of this Hackday is to **migrate an existing Jamf Pro environment into Terraform** using the **Jamf Pro Terraform Provider**.

Participants will demonstrate their understanding of:

- Terraform as **infrastructure as code (IaC)** and **documentation**.
- Importing existing Jamf resources into Terraform configuration using both **`import` blocks** and **the CLI**.
- Structuring scalable, readable, and reusable Terraform configurations.

At the end, your Terraform project should represent a **faithful and well-structured mirror** of the target Jamf Pro environment — and when you run `terraform plan`, **no differences should appear.**

---

## 🧩 Requirements

Each team or individual will receive only:

- A **sandbox Jamf Pro instance**
- A **Terraform workspace**
- Basic **Provider Configuration**

No other documentation, templates, or starter code will be provided.
Your Terraform configurations, structure, and approach are entirely up to you.

**You will need to:**

1. Create a local user account in your sandbox.
2. Generate API credentials (API Role and API Client) for your Terraform provider configuration.
3. Use the Jamf Pro Terraform Provider to:
   - Import existing resources.
   - Build Terraform files that accurately describe your environment.

---

## 🧰 Tasks

| #   | Task                         | Description                                                                                                            |
| --- | ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| 1   | **Provider Setup**           | Configure the Jamf Pro provider with your API credentials. Ensure authentication works correctly.                      |
| 2   | **API Roles & Clients**      | Import and manage at least one API Role and API Client via Terraform.                                                  |
| 3   | **Resource Migration**       | Import and define the following resource types:                                                                        |
|     | • **Categories (50)**        | Ensure high count is handled efficiently and with readable naming.                                                     |
|     | • **Scripts (50)**           | Import and organize scripts logically.                                                                                 |
|     | • **Smart & Static Groups**  | Import and define both types; demonstrate dynamic logic where possible.                                                |
|     | • **Policies (10)**          | Policies should use scripts, groups, and categories; relationships must be preserved.                                  |
|     | • **Configuration Profiles** | Import and manage configuration profiles cleanly.                                                                      |
|     | • **Mac Apps**               | Import and represent Mac Apps appropriately.                                                                           |
| 4   | **Data Sources / Outputs**   | Add Terraform data sources and outputs for “reporting” or summarizing environment details.                             |
| 5   | **Naming & Structure**       | Establish a clear, consistent naming convention. You may reorganize names, packages, or folder structures for clarity. |
