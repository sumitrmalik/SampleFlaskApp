# Connecting Local SonarQube to GitHub Actions via Tunneling

## The Challenge

GitHub Actions workflows execute on remote virtual machines (runners). These runners cannot directly access services like SonarQube that are running on `localhost` on your personal development machine. This means a direct connection using `http://localhost:9000` from a GitHub Action will fail.

## The Solution: Local Tunneling Software

To bridge this gap for development and testing purposes, you can use tunneling software such as `ngrok` or `localtunnel`. These tools create a secure, publicly accessible URL that forwards internet traffic directly to a specific port on your local machine, effectively making your local service accessible to the GitHub Actions runner.

## How the Tunneling Process Works

Follow these general steps to establish the connection:

### Step 1: Ensure Your Local Service is Running

Before starting the tunnel, verify that your SonarQube instance is actively running on your local machine, typically accessible at `http://localhost:9000`.

### Step 2: Initiate the Tunneling Software

Open your terminal or command prompt and run the appropriate command for your chosen tool:

* **Using `ngrok`:**
    1.  Download and install the `ngrok` client from [ngrok.com](https://ngrok.com/).
    2.  Authenticate your client with your unique `Authtoken` from the ngrok dashboard using:
        ```bash
        ./ngrok config add-authtoken <YOUR_AUTHTOKEN>
        ```
    3.  Start the HTTP tunnel to your SonarQube port (e.g., 9000):
        ```bash
        ./ngrok http 9000
        ```
* **Using `localtunnel`:**
    1.  Ensure you have Node.js and npm installed. https://nodejs.org/en/download/
    2.  Install `localtunnel` globally via npm:
        ```bash
        npm install -g localtunnel
        ```
    3.  Start the tunnel to your SonarQube port (e.g., 9000):
        ```bash
        lt --port 9000
        ```

### Step 3: Obtain the Public URL

Both `ngrok` and `localtunnel` will display a temporary, publicly accessible `https://` URL in your terminal. This URL serves as the public endpoint for your local SonarQube instance (e.g., `https://abcdef12345.ngrok.io` or `https://random-word.loca.lt`). **Copy this URL.**

### Step 4: Update GitHub Repository Secret

Navigate to your GitHub repository's settings:
1.  Go to `Settings` -> `Secrets and variables` -> `Actions`.
2.  Locate your `SONAR_HOST_URL` secret.
3.  **Replace its current value** (which might be `http://localhost:9000`) with the `https://` public URL you obtained from your tunneling software.

### Step 5: Maintain the Tunnel Connection

**It is crucial to keep the terminal window where you started `ngrok` or `localtunnel` open and running.** If this window is closed, the public tunnel will be terminated, and your GitHub Actions workflow will lose connection to your SonarQube instance.

### Step 6: Re-run Your GitHub Actions Workflow

Trigger your GitHub Actions workflow again. The SonarQube scan step will now use the updated `SONAR_HOST_URL` to connect through the active tunnel to your local SonarQube instance.

## Important Considerations

* **Temporary URLs:** The free tiers of these tunneling services typically provide temporary URLs that change each time the tunnel is restarted. For a persistent URL, a paid plan might be required.
* **Security:** Exposing any local service to the internet carries inherent security risks. Use these tools cautiously and only for development or testing purposes. Do not expose sensitive or production-critical services.
* **Stability:** This setup is less robust than a dedicated, publicly hosted SonarQube instance. For production-grade Continuous Integration (CI/CD), deploying SonarQube on a dedicated server or a cloud platform is the recommended, more stable, and secure approach.