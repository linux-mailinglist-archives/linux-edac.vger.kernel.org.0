Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435301182F4
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLJJAW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Dec 2019 04:00:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53914 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbfLJJAW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Dec 2019 04:00:22 -0500
Received: from zn.tnic (p200300EC2F07FE00E11D102681F6043D.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:fe00:e11d:1026:81f6:43d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BBA81EC0CD6;
        Tue, 10 Dec 2019 10:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1575968420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q8W1C4hoH3jVijRxBfnvDQINP6tFJNcnFZZxrT3G3zw=;
        b=sREOE+3ARq+Py/mtg2KXtEP5iYwTca542BPBj/T8HQ+6YQew2PfZ8X9c8NtjSJYqR/6a9E
        iUaKsvqgK5FS79BDPQSpgVaW/WKHPCd6bFxA/Epx41q8Ru/0alj9GTrPHaZZELgD8ZxclE
        PJcMciOn14m63KmPeoKyU/OMPe6pKZ8=
Date:   Tue, 10 Dec 2019 10:00:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     'Aristeu Rozanski' <aris@redhat.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20191210090013.GA9395@zn.tnic>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 12:02:45AM +0000, Luck, Tony wrote:
> > This looks like we call skx_init() once per core. Do we keep calling it because
> > the calls are failing?  Or do we do that even when calls succeed?
> >
> > I was only really expecting that skx_init() would be called once.
> 
> So (by experimentation) it seems that if the module load fails it
> will be retried num_online_cpus times (though not bound to each
> CPU in turn ... it will maybe try the init call on the same CPU multiple
> times, but miss running on some CPUs).
> 
> If the load succeeds, then whoever is repeating the load decides
> to stop.

That's the result of our conversion to MODULE_DEVICE_TABLE to match CPU
models. So it tries once on each CPU:

https://lkml.kernel.org/r/20191107103857.GC19501@zn.tnic

I have no clean solution for this except maybe remembering the return
value of the first instance probing in the edac core module and then
asking it... it ain't pretty though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
