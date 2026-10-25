# AGENTS.md

Guidance for AI coding agents working on the Varbase AI Image Alt recipe.

## Before you start

Read the project history and context first:

- **Documentation** lives on the Varbase docs site: [docs.varbase.vardot.com](https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-image-alt). Keep `README.md` short and link there; add no `docs/` folder.
- **`CHANGELOG.md`** — what changed in each release, newest first. Read it before
  proposing changes so you follow the established direction and versioning.
- **Merge request comments and history** on
  [git.drupalcode.org/project/varbase_ai_image_alt](https://git.drupalcode.org/project/varbase_ai_image_alt/-/merge_requests)
  — the reasoning behind recent changes lives in the MR discussions.
- **Issue comments** on
  [drupal.org/project/issues/varbase_ai_image_alt](https://www.drupal.org/project/issues/varbase_ai_image_alt)
  — the Problem/Motivation and Proposed resolution for each change.

## When you make a change

- Add an entry under `## [Unreleased]` in `CHANGELOG.md`.
- Keep commit messages in the Drupal commit-type format:
  `{type}: #{issueID} Summary` (see https://www.drupal.org/node/3586390).
- Never bump the version or tag a release without explicit maintainer approval.
- This is a `drupal-recipe`; keep configuration in the recipe, not in
  `config/install` or `config/optional`.
