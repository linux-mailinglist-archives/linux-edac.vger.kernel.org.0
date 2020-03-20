Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6318C93D
	for <lists+linux-edac@lfdr.de>; Fri, 20 Mar 2020 09:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgCTIx7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Mar 2020 04:53:59 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:46542 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgCTIx7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Mar 2020 04:53:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4752E18012006;
        Fri, 20 Mar 2020 08:53:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2892:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:4321:5007:7576:7875:7903:10004:10400:10471:10848:11232:11658:11914:12297:12555:12740:12760:12895:12986:13069:13095:13255:13311:13357:13439:13972:14181:14659:14721:21067:21080:21212:21433:21627:21660:21795:21990:30051:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: glue61_3f8a7f1491e21
X-Filterd-Recvd-Size: 2818
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 08:53:56 +0000 (UTC)
Message-ID: <4d40a0b9434042f51c4b21cd48db7ac55522db5a.camel@perches.com>
Subject: Re: [v2,1/1] EDAC: (pnd2) Fix the log level and remove the word
 "error" for message "Failed to register device with error %d"
From:   Joe Perches <joe@perches.com>
To:     "she90122 ." <she90122@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Amy.Shih" <Amy.Shih@advantech.com.tw>,
        "Oakley.Ding" <Oakley.Ding@advantech.com.tw>
Date:   Fri, 20 Mar 2020 01:52:10 -0700
In-Reply-To: <CAMhTFw=OUaVSLGz1tyHJYiq6UXBNni5=fBp16M7vPXjA0HHEEA@mail.gmail.com>
References: <CAMhTFw=OUaVSLGz1tyHJYiq6UXBNni5=fBp16M7vPXjA0HHEEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 2020-03-20 at 16:26 +0800, she90122 . wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> Fix the log level from "KERN_ERR" to "KERN_INFO" and remove the word
> "error" for message "Failed to register device with error %d", since
> it is not the error message but the information to notice the user.
> 
> Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
> ---
> Changes in v2:
> - Remove the word "error" from output message.
> ---
>  drivers/edac/pnd2_edac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
> 933f772..399da3e 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
> 
>   rc = pnd2_probe();
>   if (rc < 0) {
> - pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
> + pnd2_printk(KERN_INFO,
> +     "Failed to register device - %d.\n", rc);
>   return rc;
>   }

This will not apply as it's whitespace damaged.

Another possibility would be to use the new %pe extension.
---
 drivers/edac/pnd2_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f77..370f219 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
 
 	rc = pnd2_probe();
 	if (rc < 0) {
-		pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+		pnd2_printk(KERN_INFO, "Failed to register device - %pe\n",
+			    ERR_PTR(rc));
 		return rc;
 	}
 

