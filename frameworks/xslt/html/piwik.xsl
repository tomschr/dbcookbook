<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
 
 <xsl:template name="generate.piwik">
   <xsl:comment> Piwik </xsl:comment>
   <script type="text/javascript">
var pkBaseURL = (("https:" == document.location.protocol) ? "https://sourceforge.net/apps/piwik/doccookbook/" : "http://sourceforge.net/apps/piwik/doccookbook/");
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
</script><script type="text/javascript">
try {
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</script><noscript><p><img src="http://sourceforge.net/apps/piwik/doccookbook/piwik.php?idsite=1" style="border:0" alt=""/></p></noscript>
<xsl:comment> End Piwik Tag </xsl:comment>
 </xsl:template>
 
</xsl:stylesheet>