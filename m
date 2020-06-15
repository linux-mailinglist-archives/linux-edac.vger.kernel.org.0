Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92A1F955E
	for <lists+linux-edac@lfdr.de>; Mon, 15 Jun 2020 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFOLgS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Jun 2020 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgFOLgP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 Jun 2020 07:36:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F42C061A0E;
        Mon, 15 Jun 2020 04:36:15 -0700 (PDT)
Received: from zn.tnic (p200300ec2f063c0085fbd8d4455f52fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:85fb:d8d4:455f:52fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DC771EC0299;
        Mon, 15 Jun 2020 13:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592220972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wNejEnqWvVsdy0QqOUqQ7JttaY2RtRVTLTJv9gTWu8A=;
        b=q7HtulOgDR13aAJSrl1mR4BXZDgGB9hQtU1txknBiLDGPF5ckln+WmX7XZOZhzhbMxH6Cu
        WF7w+/UN3ACVfJUnZ0kP8CWLcQ9l9KLD8OB6tJzfwrUMGM3GVL+dv0RU+Fo6vMBsClcSBp
        KIpsRWU9ynWWqz/h1bqz2bH5dgRtw+4=
Date:   Mon, 15 Jun 2020 13:36:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] x86/mce: fix a wrong assignment of i_mce.status
Message-ID: <20200615113604.GF14668@zn.tnic>
References: <20200611023238.3830-1-zhenzhong.duan@gmail.com>
 <20200611165500.GA3503@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611165500.GA3503@agluck-desk2.amr.corp.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 11, 2020 at 09:55:00AM -0700, Luck, Tony wrote:
> +Yazen
> 
> On Thu, Jun 11, 2020 at 10:32:38AM +0800, Zhenzhong Duan wrote:
> > The original code is a nop as i_mce.status is or'ed with part of itself,
> > fix it.
> > 
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > ---
> >  arch/x86/kernel/cpu/mce/inject.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> > index 3413b41..dc28a61 100644
> > --- a/arch/x86/kernel/cpu/mce/inject.c
> > +++ b/arch/x86/kernel/cpu/mce/inject.c
> > @@ -511,7 +511,7 @@ static void do_inject(void)
> >  	 */
> >  	if (inj_type == DFR_INT_INJ) {
> >  		i_mce.status |= MCI_STATUS_DEFERRED;
> > -		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
> > +		i_mce.status &= ~MCI_STATUS_UC;
> 
> Boris: "git blame" says you wrote this code.

Not me but I should've caught it:

a1300e505297 ("x86/ras/mce_amd_inj: Trigger deferred and thresholding errors interrupts")

:-\

I believe Aravind wanted to do the &= thing, i.e.,

	i_mce.status = (i_mce.status & ~MCI_STATUS_UC);

or the short version above.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
