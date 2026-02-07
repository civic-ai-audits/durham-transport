# Backend API GitHub Actions Workflows

Two workflows for running the Flask backend as a long-running GitHub Action.

## 🚀 Quick Start

### Option 1: Basic Backend API (Local)

Run backend for up to 6 hours on GitHub Actions:

```bash
gh workflow run backend-api.yml --repo civic-ai-audits/durham-transport
```

Or via web: https://github.com/civic-ai-audits/durham-transport/actions/workflows/backend-api.yml
Click "Run workflow"

**Limitations:**
- Only accessible within the GitHub Action (for testing)
- Runs for up to 6 hours
- Auto-restarts every 5 hours via cron

### Option 2: Backend with Public URL (ngrok)

Run backend with a public URL for up to 12 hours:

1. **Get ngrok token:** https://dashboard.ngrok.com/get-started/your-authtoken

2. **Add to GitHub secrets:**
   - Go to: https://github.com/civic-ai-audits/durham-transport/settings/secrets/actions
   - Click "New repository secret"
   - Name: `NGROK_AUTHTOKEN`
   - Value: [your ngrok token]

3. **Run workflow:**
   ```bash
   gh workflow run backend-tunnel.yml \
     --repo civic-ai-audits/durham-transport \
     -f duration=6
   ```

   Or via web: https://github.com/civic-ai-audits/durham-transport/actions/workflows/backend-tunnel.yml

4. **Get public URL:**
   - Go to Actions tab
   - Click on the running workflow
   - Look for "Start ngrok tunnel" step output
   - Copy the public URL (e.g., `https://xxxx-xxx-xxx-xxx.ngrok-free.app`)

**Your API will be publicly accessible at:**
```
https://xxxx-xxx-xxx-xxx.ngrok-free.app/api/health
https://xxxx-xxx-xxx-xxx.ngrok-free.app/api/test1/report
```

---

## 📋 Workflow Details

### backend-api.yml

**Purpose:** Run Flask backend on GitHub Actions for internal testing

**Triggers:**
- Manual: `workflow_dispatch`
- Scheduled: Every 5 hours (keeps alive)

**Features:**
- ✓ Runs for up to 6 hours
- ✓ Auto-generates data if missing
- ✓ Health checks every 5 minutes
- ✓ Graceful shutdown

**Limitations:**
- Not publicly accessible (localhost only)
- Good for testing workflow
- Limited to GitHub Actions runtime

---

### backend-tunnel.yml

**Purpose:** Run Flask backend with public URL via ngrok

**Triggers:**
- Manual: `workflow_dispatch` with duration input (1, 2, 6, or 12 hours)

**Features:**
- ✓ Public URL via ngrok
- ✓ Configurable duration (1-12 hours)
- ✓ CORS enabled for browser access
- ✓ Health monitoring
- ✓ Graceful shutdown after duration

**Requirements:**
- ngrok authtoken (free tier: https://ngrok.com/pricing)
- Add `NGROK_AUTHTOKEN` to repository secrets

**Free tier limits:**
- 1 agent online
- 40 connections/minute
- HTTPS only

---

## 🎯 Use Cases

### For Development/Testing

Use **backend-api.yml**:
```bash
gh workflow run backend-api.yml --repo civic-ai-audits/durham-transport
```

Good for:
- Testing backend changes
- Verifying API endpoints
- CI/CD integration tests

### For Demos/Presentations

Use **backend-tunnel.yml**:
```bash
gh workflow run backend-tunnel.yml \
  --repo civic-ai-audits/durham-transport \
  -f duration=6
```

Good for:
- Hackathon demos with live backend
- Presentations requiring real API
- Temporary public API access
- Testing with external clients

### For Production

Use **gh-pages** (current default):
- Static files pre-generated
- No backend needed
- Fastest performance
- No runtime costs
- Always available

---

## 🔧 Managing Running Workflows

### View running workflows

```bash
gh run list --repo civic-ai-audits/durham-transport --workflow=backend-tunnel.yml --status in_progress
```

### Cancel running workflow

```bash
# Get run ID
gh run list --repo civic-ai-audits/durham-transport --workflow=backend-tunnel.yml

# Cancel specific run
gh run cancel <RUN_ID> --repo civic-ai-audits/durham-transport
```

### View workflow logs

```bash
gh run view <RUN_ID> --repo civic-ai-audits/durham-transport --log
```

---

## 📊 Monitoring

### Check if backend is running

```bash
# Via GitHub Actions
gh run list --repo civic-ai-audits/durham-transport --workflow=backend-tunnel.yml --limit 1
```

### Test public URL

```bash
# Replace with your ngrok URL from workflow output
curl https://xxxx-xxx-xxx-xxx.ngrok-free.app/api/health
```

---

## ⚠️  Important Notes

### GitHub Actions Limits

- Free tier: 2,000 minutes/month
- Backend workflow: ~6-12 hours = 360-720 minutes per run
- Plan accordingly for demo days

### ngrok Free Tier

- 1 online agent (1 concurrent tunnel)
- 40 connections/minute
- HTTPS only
- URL changes on each restart
- Good for demos, not production

### Best Practice

**Default: Use gh-pages (static)**
- Always available
- No runtime costs
- Fast performance

**Temporary: Use backend workflows**
- Only for demos/testing
- Start before presentation
- Stop after done
- Monitor usage

---

## 🚀 Quick Reference

```bash
# Start backend with public URL for 6 hours
gh workflow run backend-tunnel.yml \
  --repo civic-ai-audits/durham-transport \
  -f duration=6

# Check status
gh run list --repo civic-ai-audits/durham-transport --limit 3

# View logs (get RUN_ID from list command)
gh run view <RUN_ID> --repo civic-ai-audits/durham-transport --log

# Stop running workflow
gh run cancel <RUN_ID> --repo civic-ai-audits/durham-transport
```

---

## 🎓 Example: Hackathon Demo Flow

1. **Morning of demo:** Start backend
   ```bash
   gh workflow run backend-tunnel.yml \
     --repo civic-ai-audits/durham-transport \
     -f duration=6
   ```

2. **Get public URL:** Check Actions tab

3. **Update frontend (optional):** Point to public URL instead of static files

4. **Present:** Use live backend for dynamic demo

5. **After demo:** Workflow auto-stops after 6 hours

---

## 📚 More Info

- GitHub Actions docs: https://docs.github.com/en/actions
- ngrok docs: https://ngrok.com/docs
- Workflow files:
  - `.github/workflows/backend-api.yml`
  - `.github/workflows/backend-tunnel.yml`
