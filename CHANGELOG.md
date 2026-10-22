# Changelog

All notable changes to the Varbase AI Image Alt recipe are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- AI image description and tags on save, in the Image Classification vocabulary, with term permissions for Varbase editorial roles.

### Changed
- The Image description and Image tags fields sit in an open "AI description and tags" field group on the Image media form, and the tags use the Tagify widget. The Add Media upload form from content types leaves them out; no field is added to any content type (#3628829).

## [2.0.0] - 2026-09-06
### Changed
- Set the recipe version to `2.0.0` for the first stable release on the 2.0.x line.
- Update the version badge to `2.0.0` in `README.md`.

## [2.0.0-rc1] - 2026-08-15
### Changed
- Update the version badge to `2.0.0-rc1` in `README.md`.

## [2.0.0-beta1] - 2026-07-10
### Changed
- Update Drupal Core from ~11.3.0 to ~11.4.0 in the Varbase AI Image Alt recipe.
- Update the version badge to `2.0.0-beta1` in `README.md`.
- Run CI on tag pushes and add the README pipeline and release badges.

## [2.0.0-alpha2] - 2026-06-21
### Changed
- Maintenance and dependency updates for the Varbase AI Image Alt recipe.

## [2.0.0-alpha1]
### Added
- Initial 2.0.x release of the Varbase AI Image Alt recipe.

[Unreleased]: https://git.drupalcode.org/project/varbase_ai_image_alt/-/compare/2.0.0...2.0.x
[2.0.0]: https://git.drupalcode.org/project/varbase_ai_image_alt/-/compare/2.0.0-rc1...2.0.0
[2.0.0-rc1]: https://git.drupalcode.org/project/varbase_ai_image_alt/-/compare/2.0.0-beta1...2.0.0-rc1
[2.0.0-beta1]: https://git.drupalcode.org/project/varbase_ai_image_alt/-/compare/2.0.0-alpha2...2.0.0-beta1
[2.0.0-alpha2]: https://git.drupalcode.org/project/varbase_ai_image_alt/-/compare/2.0.0-alpha1...2.0.0-alpha2
[2.0.0-alpha1]: https://git.drupalcode.org/project/varbase_ai_image_alt/-/tags/2.0.0-alpha1
