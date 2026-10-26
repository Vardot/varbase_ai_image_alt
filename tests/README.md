# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-image-alt-media-form.feature` | Each editorial role gets Generate with AI after agreeing to send the image; it writes the alt text; a saved image gets its description from AI |
| `01-02-ai-image-alt-accessibility.feature` | The add image form keeps the label, link name and ARIA rules |

The upload form elements and the consent button are named selectors in `tests/selectors/ai-image-alt-selectors.json`.

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

CI applies Drupal CMS AI before the recipe. It sets up an amazee.ai trial as the default provider, so no key
is needed and the alt text and description come from a real vision model. Drupal CMS AI asks before an image
goes to the AI service; the scenarios answer "Yes (this time)", as an editor would.

The add image form is held to pinned accessibility rules rather than the full serious gate: the admin theme's
help toggles have no names and a details summary is low in contrast, which comes from the theme, not this
recipe.
