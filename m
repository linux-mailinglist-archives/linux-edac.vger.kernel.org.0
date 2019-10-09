Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA66D17B1
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfJISoF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 14:44:05 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:34834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731254AbfJISoF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Oct 2019 14:44:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1D54C100E86C3;
        Wed,  9 Oct 2019 18:44:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3167:3622:3865:3870:4321:5007:6742:10004:10400:11026:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21212:21627:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: mist32_5d7188b702942
X-Filterd-Recvd-Size: 1584
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Oct 2019 18:44:02 +0000 (UTC)
Message-ID: <cf1934f2668eea9d35dea1d16bb26cf911d4f831.camel@perches.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Benjamin Berg <bberg@redhat.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Wed, 09 Oct 2019 11:44:00 -0700
In-Reply-To: <20191009182246.GL10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
         <1dfc2bf57335b7eb9f130cc791db76655fb5b8f4.camel@perches.com>
         <20191009182246.GL10395@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2019-10-09 at 20:22 +0200, Borislav Petkov wrote:
> On Wed, Oct 09, 2019 at 11:05:37AM -0700, Joe Perches wrote:
> > Perhaps this should be
> > 
> > 	pr_warn_ratelimited(...)
> > 
> > as the temperature changes can be relatively quick.
> 
> There's already ratelimiting machinery a bit above in the same function.

right, thanks, nevermind...

