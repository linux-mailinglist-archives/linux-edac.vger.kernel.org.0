Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C24E18C4F8
	for <lists+linux-edac@lfdr.de>; Fri, 20 Mar 2020 02:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTB4X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Mar 2020 21:56:23 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:55934 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgCTB4X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Mar 2020 21:56:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 65A95182CF665;
        Fri, 20 Mar 2020 01:56:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2892:3138:3139:3140:3141:3142:3351:3622:3865:3867:3870:3871:3872:4321:5007:7576:10004:10400:10848:11232:11658:11914:12297:12534:12740:12760:12895:13069:13095:13255:13311:13357:13439:13972:14181:14659:14721:21067:21080:21212:21433:21627:21660:21795:30051:30054:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kick45_376b8a8970b3b
X-Filterd-Recvd-Size: 1850
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 01:56:20 +0000 (UTC)
Message-ID: <e67eefc91d4f54a5fbf64be9e6bee94680461b60.camel@perches.com>
Subject: Re: [v1,1/1] EDAC: (pnd2) Fix the log level for message "Failed to
 register device with error %d"
From:   Joe Perches <joe@perches.com>
To:     Amy.Shih@advantech.com.tw, she90122@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        oakley.ding@advantech.com.tw
Date:   Thu, 19 Mar 2020 18:54:34 -0700
In-Reply-To: <20200317062828.18807-1-Amy.Shih@advantech.com.tw>
References: <20200317062828.18807-1-Amy.Shih@advantech.com.tw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2020-03-17 at 06:28 +0000, Amy.Shih@advantech.com.tw wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> Fix the log level from "KERN_ERR" to "KERN_INFO" for message "Failed to
> register device with error %d", since it is not the error message but
> the information to notice the user.
[]
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
[]
> @@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
>  
>  	rc = pnd2_probe();
>  	if (rc < 0) {
> -		pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
> +		pnd2_printk(KERN_INFO,
> +			    "Failed to register device with error %d.\n", rc);

So there's no need to use the word "error"
in the output message either.

	"Failed to register device - %d\n", rc

would be enough.


