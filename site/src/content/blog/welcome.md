---
title: 'Welcome to Simple Site'
description: 'Getting started with your new Astro-based website template.'
pubDate: 2026-02-06
---

Welcome to your new website! This is a sample blog post to demonstrate how content works in the Simple Site template.

## Writing Content

Blog posts are written in Markdown (or MDX) and stored in the `src/content/blog/` directory. Each post needs frontmatter with at least these fields:

```yaml
---
title: 'Your Post Title'
description: 'A brief description for SEO and previews'
pubDate: 2026-02-06
---
```

## Features

This template includes:

- **Astro 5** for blazing-fast static site generation
- **Tailwind CSS** for utility-first styling
- **React support** via Astro islands for interactive components
- **Content Collections** for type-safe content management
- **Automatic sitemap and RSS** (can be added via Astro integrations)

## Customization

To customize this site:

1. Update `src/layouts/BaseLayout.astro` to change the site layout
2. Edit components in `src/components/` to modify the header, footer, etc.
3. Change the Tailwind theme in `tailwind.config.mjs`
4. Update the Plausible analytics domain in `BaseLayout.astro`

## Adding Interactivity

Need a React component? Create it in `src/components/react/` and use Astro's client directives:

```astro
---
import Counter from '../components/react/Counter';
---

<Counter client:load />
```

Happy building!
