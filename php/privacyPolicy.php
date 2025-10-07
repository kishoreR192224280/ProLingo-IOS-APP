<?php
// ======================
// Privacy Policy Config
// ======================
$appName         = "ProLinGO";
$companyName     = "ProLinGO EdTech Pvt. Ltd.";     // Your legal entity
$companyAddress  = "123, Business Park, Bengaluru, KA 560001, India";
$contactEmail    = "privacy@prolingo.app";          // Where users send privacy requests
$contactPhone    = "+91 98765 43210";               // Optional
$siteUrl         = "https://www.prolingo.app";      // Your primary domain
$controllerName  = $companyName;                    // Data Controller name (GDPR)
$dpOfficerEmail  = "dpo@prolingo.app";              // Optional: Data Protection Officer email

// Region-specific toggles (flip to false if not applicable)
$handlesEU       = true;    // If you serve EU/EEA/UK users (GDPR)
$handlesCalifornia = true;  // If you serve California users (CCPA/CPRA)
$handlesIndia    = true;    // If you serve India users (DPDP Act 2023)

$lastUpdated = date("F j, Y"); // Auto-sets today's date in server timezone
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Privacy Policy | <?php echo htmlspecialchars($appName); ?></title>
  <meta name="robots" content="noindex,follow" />
  <style>
    :root { --fg:#0f172a; --muted:#475569; --bg:#ffffff; --card:#f8fafc; --accent:#0ea5e9; }
    * { box-sizing: border-box; }
    body { margin:0; font-family: system-ui, -apple-system, Segoe UI, Roboto, Inter, Arial, sans-serif; color:var(--fg); background:var(--bg); }
    .wrap { max-width: 900px; margin: 0 auto; padding: 40px 20px 64px; }
    header { margin-bottom: 24px; }
    h1 { font-size: 2rem; margin: 0 0 8px; }
    .meta { color: var(--muted); font-size: .95rem; }
    section { background: var(--card); border: 1px solid #e5e7eb; border-radius: 16px; padding: 20px; margin: 16px 0; }
    h2 { font-size: 1.25rem; margin: 0 0 12px; }
    h3 { font-size: 1.05rem; margin: 14px 0 8px; }
    p, li { line-height: 1.6; color: var(--fg); }
    ul { margin: 0 0 0 20px; }
    .callout { border-left: 4px solid var(--accent); padding-left: 12px; }
    a { color: var(--accent); text-decoration: none; }
    a:hover { text-decoration: underline; }
    footer { margin-top: 40px; font-size: .95rem; color: var(--muted); }
    code { background: #eef2ff; padding: 2px 6px; border-radius: 6px; font-family: ui-monospace, SFMono-Regular, Menlo, monospace; }
  </style>
</head>
<body>
  <div class="wrap">
    <header>
      <h1>Privacy Policy</h1>
      <div class="meta">
        For <?php echo htmlspecialchars($appName); ?> (<?php echo htmlspecialchars($siteUrl); ?>)<br/>
        Last updated: <?php echo htmlspecialchars($lastUpdated); ?>
      </div>
    </header>

    <section class="callout">
      <p>
        This Privacy Policy explains how <?php echo htmlspecialchars($controllerName); ?> (“<?php echo htmlspecialchars($appName); ?>”,
        “we”, “us”, or “our”) collects, uses, discloses, and safeguards your information when you use our
        language learning services focused on corporate and business English (the “Services”).
      </p>
      <p>
        By using the Services, you agree to this Policy. If you do not agree, please do not use the Services.
      </p>
    </section>

    <section>
      <h2>1) Information We Collect</h2>
      <h3>A. You provide to us</h3>
      <ul>
        <li><strong>Account data:</strong> name, email, password (hashed), profile photo (optional), role (e.g., learner, manager).</li>
        <li><strong>Corporate details:</strong> company/department, job title, work email (for enterprise accounts).</li>
        <li><strong>Learning profile:</strong> goals, level, selected courses, interests, preferred language.</li>
        <li><strong>Content:</strong> messages, voice recordings, homework, assessments, notes, forum posts.</li>
        <li><strong>Support:</strong> inquiries, feedback, survey responses.</li>
        <li><strong>Payment:</strong> handled by third-party processors; we receive limited billing metadata (e.g., success/failure, last 4 digits, expiry month/year) but not full card numbers.</li>
      </ul>

      <h3>B. Collected automatically</h3>
      <ul>
        <li><strong>Usage & diagnostics:</strong> app interactions, features used, pages viewed, crash logs.</li>
        <li><strong>Device & network:</strong> device model, OS, app version, browser type, IP address, coarse location (from IP), time zone.</li>
        <li><strong>Cookies & similar tech:</strong> for sign-in, preferences, analytics, fraud prevention.</li>
        <li><strong>Audio processing:</strong> if you use speaking/listening features, we process audio to score pronunciation and provide feedback.</li>
      </ul>

      <h3>C. From third parties</h3>
      <ul>
        <li><strong>SSO/Identity:</strong> if you sign in with Google, Apple, Microsoft, or enterprise SSO, we receive basic profile info per your consent.</li>
        <li><strong>Enterprise administrators:</strong> when your organization provisions or manages your account.</li>
        <li><strong>Analytics & attribution partners:</strong> aggregate insights on installs, campaigns, and app performance.</li>
      </ul>
    </section>

    <section>
      <h2>2) How We Use Information</h2>
      <ul>
        <li>Provide, operate, and secure the Services (including authentication and fraud prevention).</li>
        <li>Personalize learning paths, difficulty, and recommendations using your progress and preferences.</li>
        <li>Sync progress across devices and enable teacher/mentor feedback for enterprise cohorts.</li>
        <li>Process payments and manage subscriptions.</li>
        <li>Respond to support requests and improve our content, curricula, and speech models.</li>
        <li>Send service communications (e.g., changes to terms, security alerts) and optional marketing (with controls).</li>
        <li>Comply with legal obligations and enforce our terms.</li>
      </ul>
      <?php if ($handlesEU): ?>
      <h3>Legal Bases (GDPR/UK GDPR)</h3>
      <ul>
        <li>Performance of a contract (to deliver the Services you request).</li>
        <li>Legitimate interests (to secure and improve the Services, prevent abuse, and personalize content proportionately).</li>
        <li>Consent (for optional analytics/marketing and certain cookies; you can withdraw at any time).</li>
        <li>Legal obligation (e.g., tax, accounting, compliance).</li>
      </ul>
      <?php endif; ?>
    </section>

    <section>
      <h2>3) When We Share Information</h2>
      <ul>
        <li><strong>Service providers:</strong> hosting, analytics, crash reporting, payment processing, email/SMS vendors bound by contracts.</li>
        <li><strong>Enterprise accounts:</strong> where your organization sponsors your access, certain learning metrics and attendance may be visible to authorized administrators or instructors.</li>
        <li><strong>Legal & safety:</strong> to comply with law, enforce terms, or protect rights, property, and safety.</li>
        <li><strong>Business transfers:</strong> in connection with a merger, acquisition, or asset sale, with appropriate safeguards.</li>
        <li><strong>With your direction or consent:</strong> e.g., linking accounts or sharing certificates.</li>
      </ul>
    </section>

    <section>
      <h2>4) International Data Transfers</h2>
      <p>
        We may process data in countries other than yours. Where required, we use lawful transfer mechanisms
        such as Standard Contractual Clauses and implement technical and organizational safeguards.
      </p>
    </section>

    <section>
      <h2>5) Data Retention</h2>
      <p>
        We retain personal data for as long as your account is active or as needed to provide the Services,
        comply with legal obligations, resolve disputes, and enforce agreements. We anonymize or securely
        delete data when no longer required.
      </p>
    </section>

    <section>
      <h2>6) Your Rights & Choices</h2>
      <ul>
        <li>Access, correct, update, or delete your personal data.</li>
        <li>Export/port a copy of your data where applicable.</li>
        <li>Object to or restrict certain processing; withdraw consent where processing is based on consent.</li>
        <li>Manage cookies (via browser settings and in-app controls, where available).</li>
        <li>Opt out of marketing communications using unsubscribe links or by contacting us.</li>
      </ul>
      <p>
        To exercise your rights, email us at <a href="mailto:<?php echo htmlspecialchars($contactEmail); ?>"><?php echo htmlspecialchars($contactEmail); ?></a>.
        We may verify your request before acting on it.
      </p>
      <?php if ($handlesEU): ?>
      <p>
        If you are in the EU/EEA/UK, you may also lodge a complaint with your local data protection authority.
      </p>
      <?php endif; ?>
    </section>

    <section>
      <h2>7) Cookies & Tracking</h2>
      <p>We use cookies and similar technologies to:</p>
      <ul>
        <li>Keep you signed in and remember preferences.</li>
        <li>Measure usage and improve performance (analytics).</li>
        <li>Detect fraud and enhance security.</li>
      </ul>
      <p>
        You can control cookies via your browser settings. Some features may not function correctly without essential cookies.
      </p>
    </section>

    <section>
      <h2>8) Children’s Privacy</h2>
      <p>
        The Services are not directed to children under 13 (or the age required by your country, e.g., 16 in parts of the EU).
        We do not knowingly collect personal data from children without appropriate consent.
        If you believe a child has provided personal data, please contact us and we will take appropriate action.
      </p>
    </section>

    <?php if ($handlesCalifornia): ?>
    <section>
      <h2>9) California Privacy Notice (CCPA/CPRA)</h2>
      <p>
        California residents have the right to know, access, correct, delete, and opt out of certain data sharing.
        We do not “sell” personal information as defined by the CCPA/CPRA, nor do we process sensitive personal
        information for the purpose of inferring characteristics. To exercise your rights, contact
        <a href="mailto:<?php echo htmlspecialchars($contactEmail); ?>"><?php echo htmlspecialchars($contactEmail); ?></a>.
      </p>
    </section>
    <?php endif; ?>

    <?php if ($handlesIndia): ?>
    <section>
      <h2>10) India Notice (DPDP Act, 2023)</h2>
      <p>
        Where the Digital Personal Data Protection Act, 2023 applies, you may request access, correction,
        deletion, grievance redressal, and withdrawal of consent. For DPDP inquiries, contact our Grievance
        Officer at <a href="mailto:<?php echo htmlspecialchars($dpOfficerEmail); ?>"><?php echo htmlspecialchars($dpOfficerEmail); ?></a>.
      </p>
    </section>
    <?php endif; ?>

    <section>
      <h2>11) Data Security</h2>
      <p>
        We implement administrative, technical, and physical safeguards designed to protect personal data,
        including encryption in transit, access controls, and regular security reviews. No method of
        transmission or storage is 100% secure, and we cannot guarantee absolute security.
      </p>
    </section>

    <section>
      <h2>12) Third-Party Links & Integrations</h2>
      <p>
        The Services may contain links to third-party sites or integrate with third-party tools (e.g., SSO,
        video conferencing, or payment processors). Their privacy practices are governed by their own policies.
      </p>
    </section>

    <section>
      <h2>13) Changes to This Policy</h2>
      <p>
        We may update this Policy from time to time. The “Last updated” date above reflects the latest changes.
        Material changes will be communicated via the app, email, or prominent notice.
      </p>
    </section>

    <section>
      <h2>14) Contact Us</h2>
      <p>
        Controller: <?php echo htmlspecialchars($controllerName); ?><br/>
        Address: <?php echo htmlspecialchars($companyAddress); ?><br/>
        Email: <a href="mailto:<?php echo htmlspecialchars($contactEmail); ?>"><?php echo htmlspecialchars($contactEmail); ?></a>
        <?php if (!empty($contactPhone)) : ?>
          | Phone: <a href="tel:<?php echo htmlspecialchars($contactPhone); ?>"><?php echo htmlspecialchars($contactPhone); ?></a>
        <?php endif; ?>
      </p>
    </section>

    <footer>
      <p>
        This template is provided for general informational purposes and does not constitute legal advice.
        Consider consulting counsel to tailor it for your specific data flows and jurisdictions.
      </p>
    </footer>
  </div>
</body>
</html>
