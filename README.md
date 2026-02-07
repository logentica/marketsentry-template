# Simple Template

A lightweight website template for the Buildville platform. Perfect for static sites, blogs, portfolios, landing pages, and web games that don't need user authentication or databases.

## Quick Start

1. **Clone this template** to create a new repository
2. **Update `values.yaml`** with your site name and domain
3. **Customize the site** in the `site/` directory
4. **Push to GitHub** - deployment is automatic

## What's Included

- **Astro 5** - Fast static site generation
- **Tailwind CSS** - Utility-first styling
- **React** - Interactive components via Astro islands
- **Blog Support** - Markdown content collections
- **Responsive Design** - Mobile-first layout
- **SEO Ready** - Meta tags and Plausible analytics
- **One-Click Deploy** - GitHub Actions + ArgoCD

## What's NOT Included

- User authentication
- Database
- Backend API
- Payment processing

Need these? Use [opensaas-template](../opensaas-template) instead.

## Project Structure

```
simple-template/
├── values.yaml           # Deployment config (update this!)
├── agents.yaml           # AI agent config (optional)
├── deploy.sh             # One-click deploy script
├── push.sh               # Manual build script
├── AGENTS.md             # Developer instructions
└── site/                 # Astro project
    ├── src/
    │   ├── pages/        # Your pages go here
    │   ├── components/   # Reusable components
    │   ├── layouts/      # Page layouts
    │   └── content/blog/ # Blog posts (Markdown)
    └── public/           # Static assets
```

## Development

```bash
cd site
npm install
npm run dev
```

Visit http://localhost:4321

## Deployment

Just push to `main`:

```bash
git add .
git commit -m "My changes"
git push
```

GitHub Actions will:
1. Build the Astro site
2. Create a Docker image
3. Push to the registry
4. ArgoCD deploys automatically

## Configuration

Edit `values.yaml`:

```yaml
namespace: my-site
site:
  name: "my-site"
  description: "My awesome website"
image:
  repository: "registry.buildville.cloud/buildville/my-site"
ingress:
  hosts:
    - host: "my-site.buildville.cloud"
```

## Adding Content

### New Page

Create `site/src/pages/contact.astro`:

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="Contact">
  <h1>Contact Us</h1>
</BaseLayout>
```

### Blog Post

Create `site/src/content/blog/my-post.md`:

```markdown
---
title: 'My First Post'
description: 'Hello world'
pubDate: 2026-02-06
---

Your content here...
```

## License

MIT
