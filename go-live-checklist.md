# Go-live checklist

### Code
- [ ] Telephone numbers are clickable with "tel:"
- [ ] All javascript files are error free
- [ ] All console.logs are removed
- [ ] Implemented WAI-ARIA according to [https://www.w3.org/TR/wai-aria/](https://www.w3.org/TR/wai-aria/)
- [ ] Implementet WCAG according to [https://www.w3.org/TR/WCAG21/](https://www.w3.org/TR/WCAG21/)
- [ ] Responsive < 640px provided
- [ ] Responsive larger smartphone 640px - 768px provided
- [ ] Responsive tablet 768px - 1024px provided
- [ ] Responsive laptop 1024px - 1280px provided
- [ ] Responsive large desktop >1280px provided
- [ ] External links are being opened in a new window 
- [ ] Alt texts for images are set
- [ ] All page titles are unique and correctly set in H1
- [ ] All links have hover and focus states
- [ ] All mobile links / buttons are at least have 48px (of 32px space between)
- [ ] All srcsets being set where possible
- [ ] All Lorem ipsum / placeholder content is being repliced by dynamic Twig tags
- [ ] Meta info is set
- [ ] Add Tailwindcss classes to purgeCSS whitelist
- [ ] All criticalCSS templates are added
- [ ] Buddy.yml is set correctly
- [ ] data-tag-[category|action|labelvalue] tags added to downloads/forms for GA
- [ ] Does the app use localStorage
- [ ] AMP templates are added

### Code - CMS
- [ ] All forms are propertly validated and user-friendly validated
- [ ] All forms are tested and data is properly stored
- [ ] All form don't use HTML5 validation but F/E & Server validation
- [ ] Form data is beind send to the correct receiver
- [ ] All images are being optimized for web
- [ ] SEOmatic is fully set and all tags are added

### General
- [ ] Sitemap.xml is being generated
- [ ] Robots.txt is present and correct
- [ ] Favicon is added
- [ ] Error pages are designed and added
- [ ] Cookie notification is added and linked to the Privacy Policy page
- [ ] Old browser notification is added
- [ ] Shareble links (Facebook, Linkedin, Twitter, ...) are tested
- [ ] The F/E is being checked by the designer
- [ ] Retour plugin is set to redirect old urls
- [ ] The website is added to Google Search Console
- [ ] .env is set for production
- [ ] Enable GraphQL / template caching in .env

### Server
- [ ] Nginx error templates are added
- [ ] Nginx configs are updated (with nginx-partials)
- [ ] Nginx location blocks are tested
- [ ] SSL is set correctly, everything is being parsed trough https
- [ ] File permissions are set correctly
- [ ] GZIP compression is correctly setted
- [ ] Mailgun DNS records added
- [ ] The maxupload on server is updated (PHP)
- [ ] The memory limit on server is updated (PHP)
- [ ] The mysql settings are set correctly (innodb_buffer_pool_size)
- [ ] The pm.max_children is set correctly
- [ ] The queue daemon is added
- [ ] The cronjob is added for generating the sitemap (SEOmatic)
- [ ] The image processor is turned on (Lambda or other)

### Testing
- [ ] Google Pagespeed test 85+
- [ ] Google Lighthouse test 95+
- [ ] Google Lighthouse test a score of 100 for best practices
- [ ] PWA is working
- [ ] Google Analytics is being set and tested
- [ ] Sitemap is registered with Google Search Console
- [ ] Google Tag Manager is setup and configured and pushing events
- [ ] Broken links checked https://validator.w3.org/checklink 
- [ ] All dummy text is removed from the CMS
- [ ] Site is reachable trough search engines: noindex, nofollow are being removed
- [ ] Client account is added and added to the correct usergroups
- [ ] Real device test iPhone 7+
- [ ] Real device test iPad / iPad Mini / iPad Pro
- [ ] Real device test Samsung Galaxy S8 +
- [ ] All pages are tested functional and visual on the latest Microsoft Edge
- [ ] All pages are tested functional and visual on the latest Firefox latest (Windows)
- [ ] All pages are tested functional and visual on the latest Firefox latest (Mac)
- [ ] All pages are tested functional and visual on the latest Chrome latest (Windows)
- [ ] All pages are tested functional and visual on the latest Chrome latest (Mac)
- [ ] All pages are tested functional and visual on the latest Chrome latest (iOS - iPad)
- [ ] All pages are tested functional and visual on the latest Chrome latest (iOS - Mobile)
- [ ] All pages are tested functional and visual on the latest Chrome latest (Android - Tablet)
- [ ] All pages are tested functional and visual on the latest Chrome latest (Android - Mobile)
- [ ] All pages are tested functional and visual on the latest Safari (Mac)
- [ ] All pages are tested functional and visual on the latest Safari (iOS - iPad)
- [ ] All pages are tested functional and visual on the latest Safari (iOS - Mobile)
- [ ] Tailwind parsed all the whilelisted classes
- [ ] Styling is according to the brand guideline
- [ ] Testing the json ld is set correctly [https://search.google.com/structured-data/testing-tool/u/0/?hl=en](https://search.google.com/structured-data/testing-tool/u/0/?hl=en)
- [ ] Doing a global SEO audit
- [ ] AMP is working

Brought to you by [Percipio.London](https://percipio.london/)
