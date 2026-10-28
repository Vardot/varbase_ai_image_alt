---
name: varbase-ai-media
description: "Apply, repair and verify Varbase AI Media on a Varbase 11 site: AI images: generated images and SVGs in the Media Library (Varbase AI Media Base) and alt text, descriptions and tags (Varbase AI Image Alt). Install and apply commands, inputs, config, post-apply steps, browser checks, traps and versions, read from the recipe code. Use when adding, fixing or checking Varbase AI Media."
---

# Varbase AI Media

Read from `recipe.yml`, `composer.json`, README, CHANGELOG and `git log` at the latest tag, 28 October 2026. Re-check versions on drupal.org before relying on them. For the full Varbase AI apply order, see the Varbase AI recipes docs page.

## Recipes

| Recipe | Latest | Stability | Require |
|---|---|---|---|
| `varbase_ai_media_base` | 1.0.0-alpha3 | alpha | `drupal/varbase_ai_media_base:~1` |
| `varbase_ai_image_alt` | 2.0.2 | stable | `drupal/varbase_ai_image_alt:~2` |

Docs (the code wins where they differ):
- https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-media-base
- https://docs.varbase.vardot.com/developers/understanding-varbase/varbase-ai-recipes/varbase-ai-image-alt

## What it does

- `varbase_ai_media_base` installs `ai`, `svg_image`, `ai_media` (1.0.0-alpha3): a "Generate image with AI" tab after Image and a "Generate SVG with AI" tab after SVG Image, saving into those media types (no media types of its own since alpha2, #3633062); allows SVG Image in Insert Media on `full_html`; grants `content_editor`, `content_admin`, `site_admin`. Composer: `ai ^1.5`, `ai_media ^1.0.0-alpha3`, `svg_image ^3.2.5`. Needs default `text_to_image` (images) and `chat` (SVG) providers.
- `varbase_ai_image_alt` installs `ai`, `ai_automators`, `ai_image_alt_text`, `ai_image_bulk_alt_text`, `field_group`, `image`, `media`, `options`, `tagify`, `taxonomy`, `token`. On `media.image`: fields `field_image_description` and `field_image_tags` (vocabulary `image_classification`) filled on save by two automators, image style `scale_for_ai_vision`, the form display, and `generate ai alt tags` for the editorial roles. Composer: `drupal_cms_ai ~2`, `field_group ~4.0`, `tagify ~2.0`. Applied by Varbase AI Base.

## Apply

All commands in DDEV, from the project root; recipes are applied from the docroot path `../recipes/<name>`. Take a snapshot first: `ddev snapshot --name before-varbase-ai-media`. Add each recipe to `extra.drupal-recipe-unpack.ignore` in `composer.json` before requiring it (read the list first: `composer config --json` replaces it).

```bash
ddev composer require drupal/varbase_ai_media_base:~1
ddev drush cr
ddev drush recipe ../recipes/varbase_ai_media_base -y
ddev drush cr
```

## After the apply

- Set the default `text_to_image` model. `gpt-image-1` may be unavailable for a key; use `gpt-image-2`.
- Existing images: bulk alt text from the `ai_image_bulk_alt_text` page (one AI call per image).

## Verify

- In the Media Library, the two Generate tabs show; generate one image and one SVG, insert them into a node.
- Upload an image: the alt text button fills alt; saving fills description and tags.

Test as a real editor or visitor, not user 1: a superuser bypasses permissions.

## Traps

- **Upgrading from alpha1 with the old media types still on the site.** AI Media 1.0.0-alpha3 and Media Base alpha2 or later drop the "Generated image with AI" (`image_ai_gen`) and "Generated SVG with AI" (`svg_ai_gen`) media types; generated images save as Image and SVGs as SVG Image, through two AI tabs in the Media Library. The old types' media source plugin is gone, so Drupal can no longer load or delete them as entities, and `drush cr` breaks. Canvas component prop expressions also reference them. Remove them BEFORE updating the code: see "Upgrade from alpha1" below (https://www.drupal.org/project/varbase_ai_media_base/issues/3633782).
- No Blog dependency: recipe.yml and config at 1.0.0-alpha3 name no `node.blog`. Its CI installs Varbase with Blog on, which is not a requirement of the recipe.
- Image alt writes description and tags on every save: one AI call per image.

## Upgrade from alpha1: remove the old AI media types

Do this before `composer update` brings AI Media 1.0.0-alpha3. Snapshot first: `ddev snapshot --name before-ai-media-upgrade`.

1. Confirm no media item uses the old bundles. Move any that do to Image or SVG Image first.

```bash
ddev drush sql:query "SELECT bundle, COUNT(*) FROM media GROUP BY bundle"
```

2. Clear every mention of `image_ai_gen` and `svg_ai_gen` from other config (Canvas component prop expressions such as `[␜entity:media:image_ai_gen␝…]`, dependencies, permissions, list entries), then delete the types' own config objects directly: `media.type.<t>`, `core.entity_view_display.media.<t>.*`, `core.entity_form_display.media.<t>.*`, `field.field.media.<t>.*`, `language.content_settings.media.<t>`. Work on config, not entities: the entities cannot load. A sketch for `ddev drush php:script upgrade-ai-media.php`:

```php
<?php
$types = ['image_ai_gen', 'svg_ai_gen'];
$factory = \Drupal::configFactory();
if (!array_filter($types, fn($t) => !$factory->get("media.type.$t")->isNew())) {
  echo "Already gone.\n";
  return;
}
$used = (int) \Drupal::database()
  ->query("SELECT COUNT(*) FROM {media} WHERE bundle IN (:t[])", [':t[]' => $types])
  ->fetchField();
if ($used) {
  throw new \RuntimeException("$used media items still use the old types.");
}
$own = '/^(media\.type|core\.entity_(view|form)_display\.media|field\.field\.media|language\.content_settings\.media)\.(image_ai_gen|svg_ai_gen)(\.|$)/';
$clean = function ($v) use (&$clean, $types) {
  if (is_string($v)) {
    return preg_replace('/\[␜entity:media:(image_ai_gen|svg_ai_gen)␝[^\]]*\]/u', '', $v);
  }
  if (!is_array($v)) {
    return $v;
  }
  $list = array_is_list($v);
  $out = [];
  foreach ($v as $k => $x) {
    if (!$list && in_array((string) $k, $types, TRUE)) continue;
    if (is_string($x) && preg_match('/(^|[.\s])(image_ai_gen|svg_ai_gen)(\.|\s|$)/', $x)) continue;
    $out[$k] = $clean($x);
  }
  return $list ? array_values($out) : $out;
};
foreach ($factory->listAll() as $name) {
  if (preg_match($own, $name)) continue;
  $raw = $factory->get($name)->getRawData();
  if (!preg_match('/image_ai_gen|svg_ai_gen/', json_encode($raw, JSON_UNESCAPED_UNICODE))) continue;
  $factory->getEditable($name)->setData($clean($raw))->save(TRUE);
  echo "Cleared $name\n";
}
foreach ($factory->listAll() as $name) {
  if (preg_match($own, $name)) {
    $factory->getEditable($name)->delete();
    echo "Deleted $name\n";
  }
}
```

It is idempotent. Read what it prints before going on.

3. Update the code, then:

```bash
ddev drush cr
ddev drush updatedb -y
ddev drush recipe ../recipes/varbase_ai_media_base -y
ddev drush cr
```

4. Check: `drush cr` runs clean; the Media Library shows the two Generate tabs; no config still names the old types (`ddev drush config:export --destination=/tmp/cfg -y` then `ddev exec grep -rl 'image_ai_gen\|svg_ai_gen' /tmp/cfg` finds nothing).

## History

Media Base: started 22 Oct 2026, alpha1 24 Oct, alpha2 25 Oct (own media types dropped), alpha3 27 Oct. Image Alt: 2.0.0 and 2.0.1 on drupal.org; the repository history restarts at 2.0.2 (27 Oct).
