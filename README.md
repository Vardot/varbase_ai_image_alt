[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI Image Alt
[![pipeline status](https://git.drupalcode.org/project/varbase_ai_image_alt/badges/2.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_ai_image_alt/-/pipelines)
[![Varbase AI Image Alt](https://img.shields.io/badge/Varbase%20AI%20Image%20Alt-2.0.0--alpha2-0d6efc?labelColor=001d38&style=flat-square)](https://git.drupalcode.org/project/varbase_ai_image_alt/-/pipelines?ref=2.0.0-alpha2)
[![Automated Functional Testing](https://git.drupalcode.org/project/varbase_project/badges/11.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_project/-/pipelines)

Grants Varbase user roles the permission to generate AI image alt text, provided by the Drupal CMS AI ecosystem.

The AI image alt text functionality (modules and configuration) is provided by the `drupal_cms_ai` default recipe. This recipe extends that by granting the `generate ai alt tags` permission to Varbase's editorial roles: `site_admin`, `seo_admin`, `content_admin`, and `content_editor`.

## Requirements

- The Drupal CMS AI default recipe (`drupal/drupal_cms_ai`) must be applied before this recipe.

## Installation

Add the recipe using composer:
```
composer require drupal/varbase_ai_image_alt:~2
```

Change directory to `/web` or `/docroot`

Run the Drupal recipe bash script:
```
bash core/scripts/drupal recipe ../recipes/varbase_ai_image_alt
```

or

Run the Drush recipe command:
```
drush recipe ../recipes/varbase_ai_image_alt
```

## What this recipe does

Grants the `generate ai alt tags` permission to:

- `site_admin`
- `seo_admin`
- `content_admin`
- `content_editor`
