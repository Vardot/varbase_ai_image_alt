[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI Image Alt
[![pipeline status](https://git.drupalcode.org/project/varbase_ai_image_alt/badges/2.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_ai_image_alt/-/pipelines)
[![Varbase AI Image Alt](https://img.shields.io/badge/Varbase%20AI%20Image%20Alt-2.0.2-0d6efc?labelColor=001d38&style=flat-square)](https://git.drupalcode.org/project/varbase_ai_image_alt/-/pipelines?ref=2.0.2)
[![Automated Functional Testing](https://git.drupalcode.org/project/varbase_project/badges/11.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_project/-/pipelines)

AI alt text for images, plus an AI image description and image tags on save, built on the Drupal CMS AI ecosystem.

## Documentation

Read the [Varbase AI Image Alt documentation](https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-image-alt) on the Varbase docs site.

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

## Automated testing

GitLab CI on [git.drupalcode.org](https://git.drupalcode.org/project/varbase_ai_image_alt) (`.gitlab-ci.yml`) builds
a Varbase 11 site, applies this recipe twice and runs the Varbase functional testing suite in `tests/` on it. See
[tests/README.md](tests/README.md) to run it against a site of your own.
