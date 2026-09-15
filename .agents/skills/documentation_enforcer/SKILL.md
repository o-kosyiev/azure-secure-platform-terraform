---
name: documentation-enforcer
description: Ensures that all changes are always documented. Automatically updates or creates documentation in the 'documentation' folder for any codebase changes.
---

# Documentation Enforcer

## 🎯 Objective
To guarantee that all code, infrastructure, and configuration changes are accompanied by relevant documentation updates, keeping project knowledge current and centralized.

## 📋 Core Rules
1. **Always Document Changes:** Before completing any task that involves modifying code, scripts, or infrastructure definitions, you MUST update or create relevant documentation. You must always offer to update the corresponding documentation and, when possible, update it independently.
2. **Centralized Location:** All documentation must be stored in the `documentation` folder at the root of the relevant repository or project.
3. **Traceability:** Documentation should clearly explain *what* was changed, *why* it was changed, and *how* to use or maintain the new/modified component.
4. **Multiple Formats Sync:** If a document exists in multiple formats (e.g., both `.md` and `.docx`), ALL versions of the document must be updated to keep them in sync.
5. **Mermaid Diagrams in DOCX:** When updating `.docx` files, any Mermaid diagrams must be converted and embedded as images, as the Mermaid format is natively unsupported in `.docx` documents.

## 🛠️ Workflow
When a task involves making changes:
1. **Identify Impact:** Determine what components, workflows, or architectures are affected by your changes.
2. **Locate Existing Docs:** Check the `documentation` folder for existing files related to the impacted areas.
3. **Update or Create:**
   - If a relevant document exists, update it to reflect the new state.
   - If no relevant document exists, create a new Markdown file within the `documentation` folder.
4. **Review:** Ensure the documentation is accurate, clear, and follows any existing formatting conventions in the project.

## ⚠️ Important Reminders
- Never consider a task "done" until the associated documentation has been written or updated.
- Documentation should be concise but comprehensive enough for another engineer to understand the changes and rationale without diving into the code.
