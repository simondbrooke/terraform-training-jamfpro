# 🧠 Hackday: Jamf Pro → Terraform Migration

**Success Criteria & Scoring Guide**

---

## 🧮 Scoring Criteria

| Category                    | Weight | Description                                                                                 |
| --------------------------- | ------ | ------------------------------------------------------------------------------------------- |
| Implementation Quality      | 25%    | Well-structured, readable, and logically organized Terraform code.                          |
| Completeness                | 20%    | How much of the target Jamf Pro environment is represented.                                 |
| Scalability                 | 15%    | Use of loops (for_each, count), modules, and DRY principles for reusability.                |
| Readability & Documentation | 15%    | Terraform is documentation. Code should be self-explaining, consistent, and well-commented. |
| Dynamic Design              | 10%    | Demonstrate automation and flexibility — parameterization, variable usage, etc.             |
| Plan Accuracy               | 15%    | Running terraform plan results in no diff once the migration is complete.                   |

> [!NOTE]
> ⚖️ A “clean and complete” implementation will always score higher than one that is fast but messy.

---

## ✅ Success Criteria

A successful submission will:

1. **Initialize and authenticate** correctly against the Jamf Pro instance.
2. Contain Terraform configurations that represent all imported resources.
3. Use **imports or import blocks** to bring existing resources under management.
4. Pass a `terraform plan` with **no drift or diffs** against the live Jamf Pro environment.
5. Demonstrate **good Terraform hygiene**, including:
   - Consistent naming
   - Logical folder/module structure
   - Readable and maintainable code
   - Inline comments or README explaining structure
6. Include **data sources and outputs** that provide insight into the managed environment.
7. Show evidence of **reusability** and **extensibility** (looping, modular patterns, etc.).

---

## 🏆 Bonus Points

- Use of **locals** and **variables** to reduce duplication.
- Well-written **README** explaining architecture and design choices.
- Example of a **second environment or instance** using the same Terraform code (multi-instance support).
- Evidence of thought in **naming conventions** or **organizational standards**.
