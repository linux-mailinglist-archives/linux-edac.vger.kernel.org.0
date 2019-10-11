Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DFAD3A0D
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfJKHbz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 03:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfJKHbz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Oct 2019 03:31:55 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89A4D883C2
        for <linux-edac@vger.kernel.org>; Fri, 11 Oct 2019 07:31:54 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id j125so3711700wmj.6
        for <linux-edac@vger.kernel.org>; Fri, 11 Oct 2019 00:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kqphp6Y+B6IGsSB+hPHakdS6SePS+FCp5/MTcgoXJa8=;
        b=HCUIUF7qSOev5ROzRtTE9Zwqo8zDABB7ox6shgAj7zDV+UNulc8rivLf/o9k0AuCvr
         R6TwQIn5WHmSlV6Wh7vqSy4+Ul+gzu1uvpid2HpsEqjnhG7BEp7l8cRt2l9PAsCgPAmC
         YPkIQnWuAqoqd7OqkTZdQvOWJWEC+7F5grqpTa3tkMbSQYK6MhUeA6fdkore6N6e8xMl
         wPoxvvS1A42T/mFEDpWCV/VQLC7TPRu5p9Vnj0F0ZZ7YspcNFI0rjLxl3r+bf/S3gnPg
         xnN8z7deysJVt58V0Zc96TCFjL0w3ZwPhfdP5nr6xxMHiN2FRWNucl5BLgIJUc9vwfX1
         jJiA==
X-Gm-Message-State: APjAAAXKfd9yEESzUoNvK4u0HupZvwkdY94YKFxdCgab9cGC3m29ptgR
        2tUWU7bxP+WcyE5+MHWqBSrP49GjnU15hE+9WItIjjoR/ukq73dp4f5OPEpE0WReqAqQy+PJ9U5
        klbQEP47s6Zh0/zAGzCv7JQ==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr1976320wmh.40.1570779113258;
        Fri, 11 Oct 2019 00:31:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtOWtt1RMKsyIvoidxq5Lwnw6UCeUhgRRWOSU1S5pB5jFMYB6RC6c++btYt5wW/ZGfPrJjHg==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr1976296wmh.40.1570779112965;
        Fri, 11 Oct 2019 00:31:52 -0700 (PDT)
Received: from ben-x1.lan (200116b826baedf00000000000000381.dip.versatel-1u1.de. [2001:16b8:26ba:edf0::381])
        by smtp.gmail.com with ESMTPSA id h17sm11569112wme.6.2019.10.11.00.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:31:52 -0700 (PDT)
Message-ID: <d4960717d6aa7c91ba34c00b5724dd2699412f86.camel@redhat.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Benjamin Berg <bberg@redhat.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Fri, 11 Oct 2019 09:31:05 +0200
In-Reply-To: <e41580784d8f5a1806250f4daed528304976cf15.camel@linux.intel.com>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
         <e41580784d8f5a1806250f4daed528304976cf15.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Srinivas,

On Thu, 2019-10-10 at 14:08 -0700, Srinivas Pandruvada wrote:
> I have a patch to address this. Instead of avoiding any critical
> warnings or wait for 300 seconds for next one, the warning is based on
> how long the system is working on throttled condition. If for example
> the fan broke, then the throttling is extended for a long time. Then we
> better warn.
> I am waiting for internal review, and hope to post by tomorrow.

Nice! I agree that a heuristic seems better than the very simple
approach taken in this patch.

Thanks,
Benjamin

> Thanks
> Srinivas
> 
> > > Signed-off-by: Benjamin Berg <bberg@redhat.com>
> > > Tested-by: Christian Kellner <ckellner@redhat.com>
> > > ---
> > >  arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> > > b/arch/x86/kernel/cpu/mce/therm_throt.c
> > > index 6e2becf547c5..bc441d68d060 100644
> > > --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> > > +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> > > @@ -188,7 +188,7 @@ static void therm_throt_process(bool
> > > new_event,
> > > int event, int level)
> > >  	/* if we just entered the thermal event */
> > >  	if (new_event) {
> > >  		if (event == THERMAL_THROTTLING_EVENT)
> > > -			pr_crit("CPU%d: %s temperature above threshold,
> > > cpu clock throttled (total events = %lu)\n",
> > > +			pr_warn("CPU%d: %s temperature above threshold,
> > > cpu clock throttled (total events = %lu)\n",
> > >  				this_cpu,
> > >  				level == CORE_LEVEL ? "Core" :
> > > "Package",
> > >  				state->count);
> > > -- 
> > 
> > This has carried over since its very first addition in
> > 
> > commit 3867eb75b9279c7b0f6840d2ad9f27694ba6c4e4
> > Author: Dave Jones <davej@suse.de>
> > Date:   Tue Apr 2 20:02:27 2002 -0800
> > 
> >     [PATCH] x86 bluesmoke update.
> >     
> >     o  Make MCE compile time optional       (Paul Gortmaker)
> >     o  P4 thermal trip monitoring.          (Zwane Mwaikambo)
> >     o  Non-fatal MCE logging.               (Me)
> > 
> > 
> > It used to be KERN_EMERG back then, though.
> > 
> > And yes, this issue has come up in the past already so I think I'll
> > take
> > it. I'll just give Intel folks a couple of days to object should
> > there
> > be anything to object to.
> > 
> > Thx.
> > 

