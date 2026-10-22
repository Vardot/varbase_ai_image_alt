[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI Image Alt
[![pipeline status](https://git.drupalcode.org/project/varbase_ai_image_alt/badges/2.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_ai_image_alt/-/pipelines)
[![Varbase AI Image Alt](https://img.shields.io/badge/Varbase%20AI%20Image%20Alt-2.0.0-0d6efc?labelColor=001d38&style=flat-square)](https://git.drupalcode.org/project/varbase_ai_image_alt/-/pipelines?ref=2.0.0)
[![Automated Functional Testing](https://git.drupalcode.org/project/varbase_project/badges/11.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_project/-/pipelines)

AI for images in Varbase, built on the Drupal CMS AI ecosystem:

- **Alt text, on demand.** The `ai_image_alt_text` button and bulk action from the `drupal_cms_ai` default recipe, with the `generate ai alt tags` permission for Varbase's editorial roles.
- **Description and tags, on save.** When an image is saved with them empty, AI writes an **Image description** from the image, then picks or creates up to 5 **Image tags** in the **Image Classification** vocabulary from that description. Editors can type their own; a filled field is left alone. Both fields sit in an open **AI description and tags** group on the Image media form, and the tags use the Tagify widget. Varbase content types take images through their media fields and **Add Media**, which opens the media library to pick an image or upload one; its upload form leaves the two fields out to stay short, and AI fills them on save. The recipe adds fields to the Image media type only, never to a content type.

The field, vocabulary and image style machine names match the [AI Image Classification recipe](https://www.drupal.org/project/ai_recipe_image_classification), so the two can be applied on one site without duplicating fields.

## Requirements

- The Drupal CMS AI default recipe (`drupal/drupal_cms_ai`) must be applied before this recipe.
- An AI provider with default models for **Chat with Image Vision** (description) and **Chat with Complex JSON** (tags) at `/admin/config/ai/settings`.

Each image saved with an empty description or empty tags makes AI calls, including images added by bulk upload. Image content is sent to the configured provider.

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

- Adds `field_image_description` and `field_image_tags` to the Image media type, the `image_classification` vocabulary and the `scale_for_ai_vision` image style, and shows both fields on the `default` form display in an open `details` field group (`group_ai_image_details`, Field Group), with the Tagify widget on the tags. The `media_library` form display does not show them.
- Adds two AI Automators that run on save: `media.image.field_image_description.default` (vision) and `media.image.field_image_tags.default` (taxonomy, from the description).
- Grants `site_admin`, `seo_admin`, `content_admin` and `content_editor`:
  - `generate ai alt tags`
  - `create`, `edit`, `select` and `view terms in image_classification`
