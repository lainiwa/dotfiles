/* Enable start page
user_pref("browser.startup.page", 1);                            // 0102
user_pref("browser.startup.homepage", "https://duckduckgo.com"); // 0103
// */

// Enable back automatic search in url bar
user_pref("keyword.enabled", true);                 // 0801
user_pref("browser.search.suggest.enabled", true);  // 0807
user_pref("browser.urlbar.suggest.searches", true); // 0807
// */

// Enable Cloudflare DoH
user_pref("network.trr.mode", 3);
user_pref("network.trr.uri", "https://cloudflare-dns.com/dns-query");
user_pref("network.trr.bootstrapAddress", "1.1.1.1");
user_pref("security.tls.enable_0rtt_data", true);  // 1206
user_pref("network.security.esni.enabled", true);
// */

// Fix SEC_ERROR_OCSP_SERVER_ERROR
user_pref("security.OCSP.require", false); // 1212

// Disable cleanup upon shutdown
user_pref("privacy.sanitize.sanitizeOnShutdown", false); // 2802
// 2803
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.downloads", true); // see note above
user_pref("privacy.clearOnShutdown.formdata", true); // Form & Search History
user_pref("privacy.clearOnShutdown.history", true); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", true); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", true); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", false); // Site Preferences

// Do not resize inner window as a FPR technique
user_pref("privacy.resistFingerprinting.letterboxing", false); // 4504

// Could you not break my extensions please
user_pref("extensions.enabledScopes", 0); // [HIDDEN PREF]
user_pref("extensions.autoDisableScopes", 15); // [DEFAULT: 15]

// Enable ActivityWatch extension
user_pref("dom.serviceWorkers.enabled", true);  // 2302

// Disable HTTPS-Only mode
user_pref("dom.security.https_only_mode", false); // [FF76+]
user_pref("dom.security.https_only_mode_pbm", false); // [FF80+]

// Old Ctrl+Tab behaviour
user_pref("browser.engagement.ctrlTab.has-used", true);
