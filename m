Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6AD175D
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 20:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfJISMK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 14:12:10 -0400
Received: from smtprelay0071.hostedemail.com ([216.40.44.71]:56867 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728804AbfJISMK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Oct 2019 14:12:10 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Oct 2019 14:12:09 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id B8C771801C507;
        Wed,  9 Oct 2019 18:05:42 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CCA2B18225B16;
        Wed,  9 Oct 2019 18:05:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3167:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:10004:10400:11026:11232:11473:11657:11658:11914:12043:12050:12296:12297:12438:12555:12740:12760:12895:13439:14181:14659:14721:14877:21080:21212:21365:21433:21451:21611:21627:30045:30054:30055:30056:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:274,LUA_SUMMARY:none
X-HE-Tag: month49_316db865c1a40
X-Filterd-Recvd-Size: 3205
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Oct 2019 18:05:39 +0000 (UTC)
Message-ID: <1dfc2bf57335b7eb9f130cc791db76655fb5b8f4.camel@perches.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>, Benjamin Berg <bberg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Wed, 09 Oct 2019 11:05:37 -0700
In-Reply-To: <20191009175608.GK10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2019-10-09 at 19:56 +0200, Borislav Petkov wrote:
> On Wed, Oct 09, 2019 at 05:54:24PM +0200, Benjamin Berg wrote:
> > On modern CPUs it is quite normal that the temperature limits are
> > reached and the CPU is throttled. In fact, often the thermal design is
> > not sufficient to cool the CPU at full load and limits can quickly be
> > reached when a burst in load happens. This will even happen with
> > technologies like RAPL limitting the long term power consumption of
> > the package.
> > 
> > So these messages do not usually indicate a hardware issue (e.g.
> > insufficient cooling). Log them as warnings to avoid confusion about
> > their severity.
[]
> > diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
[]
> > @@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event, int event, int level)
> >  	/* if we just entered the thermal event */
> >  	if (new_event) {
> >  		if (event == THERMAL_THROTTLING_EVENT)
> > -			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> > +			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> >  				this_cpu,
> >  				level == CORE_LEVEL ? "Core" : "Package",
> >  				state->count);
> > -- 
> 
> This has carried over since its very first addition in
> 
> commit 3867eb75b9279c7b0f6840d2ad9f27694ba6c4e4
> Author: Dave Jones <davej@suse.de>
> Date:   Tue Apr 2 20:02:27 2002 -0800
> 
>     [PATCH] x86 bluesmoke update.
>     
>     o  Make MCE compile time optional       (Paul Gortmaker)
>     o  P4 thermal trip monitoring.          (Zwane Mwaikambo)
>     o  Non-fatal MCE logging.               (Me)
> 
> 
> It used to be KERN_EMERG back then, though.
> 
> And yes, this issue has come up in the past already so I think I'll take
> it. I'll just give Intel folks a couple of days to object should there
> be anything to object to.

Perhaps this should be

	pr_warn_ratelimited(...)

as the temperature changes can be relatively quick.


