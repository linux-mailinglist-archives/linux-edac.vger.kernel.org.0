Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9142AD3335
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 23:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfJJVI6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 17:08:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:44919 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfJJVI6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 17:08:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 14:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="395535274"
Received: from spandruv-mobl3.jf.intel.com ([10.251.26.188])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2019 14:08:55 -0700
Message-ID: <e41580784d8f5a1806250f4daed528304976cf15.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Benjamin Berg <bberg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Thu, 10 Oct 2019 14:08:55 -0700
In-Reply-To: <20191009175608.GK10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Benjamin,

On Wed, 2019-10-09 at 19:56 +0200, Borislav Petkov wrote:
> On Wed, Oct 09, 2019 at 05:54:24PM +0200, Benjamin Berg wrote:
> > On modern CPUs it is quite normal that the temperature limits are
> > reached and the CPU is throttled. In fact, often the thermal design
> > is
> > not sufficient to cool the CPU at full load and limits can quickly
> > be
> > reached when a burst in load happens. This will even happen with
> > technologies like RAPL limitting the long term power consumption of
> > the package.
> > 
> > So these messages do not usually indicate a hardware issue (e.g.
> > insufficient cooling). Log them as warnings to avoid confusion
> > about
> > their severity.
> > 
I have a patch to address this. Instead of avoiding any critical
warnings or wait for 300 seconds for next one, the warning is based on
how long the system is working on throttled condition. If for example
the fan broke, then the throttling is extended for a long time. Then we
better warn.
I am waiting for internal review, and hope to post by tomorrow.

Thanks
Srinivas

> > Signed-off-by: Benjamin Berg <bberg@redhat.com>
> > Tested-by: Christian Kellner <ckellner@redhat.com>
> > ---
> >  arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> > b/arch/x86/kernel/cpu/mce/therm_throt.c
> > index 6e2becf547c5..bc441d68d060 100644
> > --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> > +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> > @@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event,
> > int event, int level)
> >  	/* if we just entered the thermal event */
> >  	if (new_event) {
> >  		if (event == THERMAL_THROTTLING_EVENT)
> > -			pr_crit("CPU%d: %s temperature above threshold,
> > cpu clock throttled (total events = %lu)\n",
> > +			pr_warn("CPU%d: %s temperature above threshold,
> > cpu clock throttled (total events = %lu)\n",
> >  				this_cpu,
> >  				level == CORE_LEVEL ? "Core" :
> > "Package",
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
> And yes, this issue has come up in the past already so I think I'll
> take
> it. I'll just give Intel folks a couple of days to object should
> there
> be anything to object to.
> 
> Thx.
> 

