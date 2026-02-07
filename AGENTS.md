# Simple Template - AI Agent Instructions

## Overview

This is a **simple static website** built with Astro and deployed via GitOps. Unlike the opensaas-template, this site has:

- No database
- No user authentication
- No backend API
- No Stripe integration

It's a single nginx container serving static HTML, CSS, and JavaScript.

---

## Technology Stack

| Component | Technology |
|-----------|------------|
| Framework | Astro 5 |
| Styling | Tailwind CSS |
| Interactivity | React (via Astro islands) |
| Content | Markdown + Content Collections |
| Build | Static HTML generation |
| Container | nginx:alpine |
| Deployment | ArgoCD + Helm |

---

## Project Structure

```
simple-template/
├── values.yaml           # Deployment configuration
├── agents.yaml           # AI agent settings
├── deploy.sh             # One-click deployment
├── push.sh               # Manual build & push
├── AGENTS.md             # This file
└── site/                 # Astro project
    ├── astro.config.mjs  # Astro configuration
    ├── package.json
    ├── tailwind.config.mjs
    ├── tsconfig.json
    ├── public/           # Static assets (favicon, images)
    ├── docker/
    │   ├── Dockerfile
    │   └── nginx.conf
    └── src/
        ├── layouts/      # Page layouts
        ├── components/   # Reusable components
        │   └── react/    # React islands (interactive)
        ├── pages/        # Route pages (.astro files)
        ├── content/      # Markdown content
        │   └── blog/     # Blog posts
        └── styles/       # Global CSS
```

---

## Making Changes

### Adding a New Page

1. Create a new `.astro` file in `site/src/pages/`
2. Import and use the `BaseLayout` component
3. The page will be available at the filename's path (e.g., `contact.astro` → `/contact`)

Example:
```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="Contact Us">
  <section class="py-20">
    <div class="container">
      <h1>Contact Us</h1>
      <p>Get in touch!</p>
    </div>
  </section>
</BaseLayout>
```

### Adding a Blog Post

1. Create a new `.md` file in `site/src/content/blog/`
2. Include frontmatter with title, description, and pubDate
3. Write content in Markdown

Example:
```markdown
---
title: 'My New Post'
description: 'A description for SEO'
pubDate: 2026-02-06
---

Your content here...
```

### Adding Interactive Components (React Islands)

1. Create a React component in `site/src/components/react/`
2. Import it in an Astro page with a client directive

```astro
---
import Counter from '../components/react/Counter';
---

<Counter client:load />
```

Client directives:
- `client:load` - Load and hydrate immediately
- `client:idle` - Load when browser is idle
- `client:visible` - Load when component is visible
- `client:only="react"` - Only render on client (SSR skip)

### Modifying Styles

- Global styles: `site/src/styles/global.css`
- Tailwind config: `site/tailwind.config.mjs`
- Component styles: Use Tailwind classes directly in components

### Updating Navigation

Edit `site/src/components/Header.astro`:
```astro
const navLinks = [
  { href: '/', label: 'Home' },
  { href: '/about', label: 'About' },
  { href: '/blog', label: 'Blog' },
  { href: '/contact', label: 'Contact' },  // Add new links here
];
```

---

## Deployment

### Automatic (via GitHub)

1. Make changes to files in `site/`
2. Commit and push to `main`
3. GitHub Actions builds and deploys automatically

### Manual

```bash
./push.sh        # Build and push container
git add values.yaml
git commit -m "chore: bump image tag"
git push
```

---

## Configuration

### values.yaml - What to Customize

| Field | Description |
|-------|-------------|
| `namespace` | Kubernetes namespace (usually same as site name) |
| `site.name` | Site identifier |
| `site.description` | Site description |
| `image.repository` | Container image path in registry |
| `ingress.hosts[0].host` | Public hostname for the site |

### Changing the Domain

1. Update `ingress.hosts[0].host` in `values.yaml`
2. Update Plausible `data-domain` in `site/src/layouts/BaseLayout.astro`
3. Commit and push

---

## Local Development

```bash
cd site
npm install
npm run dev
```

Site available at http://localhost:4321

### Build and Preview

```bash
npm run build
npm run preview
```

---

## What This Template Does NOT Include

- User authentication/login
- Database (PostgreSQL)
- Backend API
- Stripe payment integration
- Email sending
- AI agents (developer orchestration)

If you need any of these features, use the **opensaas-template** instead.

---

## Common Tasks

### Add Google Analytics / Other Scripts

Edit `site/src/layouts/BaseLayout.astro` and add scripts in the `<head>` section.

### Change Plausible Analytics Domain

In `site/src/layouts/BaseLayout.astro`:
```html
<script defer data-domain="your-domain.com" src="https://plausible.buildville.cloud/js/script.js"></script>
```

### Add a Sitemap

```bash
cd site
npm install @astrojs/sitemap
```

Then update `astro.config.mjs`:
```js
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://your-domain.com',
  integrations: [tailwind(), react(), sitemap()],
});
```

### Add RSS Feed

```bash
cd site
npm install @astrojs/rss
```

Create `site/src/pages/rss.xml.js` following Astro's RSS documentation.
