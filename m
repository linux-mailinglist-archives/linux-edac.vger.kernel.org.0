Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02621ED3
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfEQUCe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 16:02:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbfEQUCd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 16:02:33 -0400
Received: from zn.tnic (p200300EC2F0C500031BA4AEE98C6BAA9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5000:31ba:4aee:98c6:baa9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E2711EC01D4;
        Fri, 17 May 2019 22:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558123351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9VydyjHzDmof8wnmo6GNe/zh/nlLASDl1sKA6ia7xU0=;
        b=olPH8CQgu3OFNC55UYroNnBzifiMkR8xA3FA0NO9KU9pV4Ti599N91Rm36lL9XnkU8s//l
        nTD1nhHb7gqAos6TQ49q/6ttRX0Ot45ZmYx/0ReKe2LTXgQE2QRolIDdn0PuNE6YEMs8pW
        akjql6reFAWRRIf3aaBbY/TM7/eIC/4=
Date:   Fri, 17 May 2019 22:02:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Message-ID: <20190517200225.GK13482@zn.tnic>
References: <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 17, 2019 at 07:49:10PM +0000, Ghannam, Yazen wrote:
> > @@ -1569,7 +1575,13 @@ static void __mcheck_cpu_init_clear_banks(void)
> > 
> >                 if (!b->init)
> >                         continue;
> > +
> > +               /* Check if any bits are implemented in h/w */
> >                 wrmsrl(msr_ops.ctl(i), b->ctl);
> > +               rdmsrl(msr_ops.ctl(i), msrval);
> > +
> > +               b->init = !!msrval;
> > +
> Just a minor nit, but can we group the comment, RDMSR, and check
> together? The WRMSR is part of normal operation and isn't tied to the
> check.

Of course it is - that's the "throw all 1s at it" part :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
