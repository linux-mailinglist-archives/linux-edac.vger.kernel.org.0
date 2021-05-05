Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC484374AF1
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEEWDp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 18:03:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50946 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhEEWDp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 May 2021 18:03:45 -0400
Received: from zn.tnic (p200300ec2f0b070001dc1f090e11b831.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:700:1dc:1f09:e11:b831])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D86D41EC02E6;
        Thu,  6 May 2021 00:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620252167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NXYsMl5AQdmgOJ9oEQHkvot9C4WwsPfhkFMXbbCFP3M=;
        b=IU+gXTlGpeBBuEFTHTr6H0Oj4+fgPd7aNw43OVWjWsrMUO6D/2cgYVqZ+V3CamobNo22dK
        W92tA5trBYc8+XpjzoaqHQZj8WkwpmOyRGLpgMVY5iv0jDYdxZcQtHjV0nfW/D5vz/ERme
        RLEKp723NO9HDcb66Ya9qUfYluCaBVA=
Date:   Thu, 6 May 2021 00:02:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     wangglei <wangglei@gmail.com>,
        "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <YJMWBBBlQ6TwFad9@zn.tnic>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
 <YJL1vU6HNBWPKy8g@zn.tnic>
 <20210505202357.GC4967@sequoia>
 <YJMIbB31oEDaXm0C@zn.tnic>
 <20210505214846.GE4967@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505214846.GE4967@sequoia>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 05, 2021 at 04:48:46PM -0500, Tyler Hicks wrote:
> The thought was that the full stream of log messages isn't necessary to
> notice that there's a problem when they are being emitted at such a high
> rate (500 per second). They're just filling up disk space and/or wasting
> networking bandwidth at that point.

I already asked about this but lemme point it out again: have you guys
looked at drivers/ras/cec.c ?

With that there won't be *any* error reports in dmesg and it will even
poison and offline pages which generate excessive errors so that ...

> Of course, the best course of action here is to service the machine
> but there's still a period of time between the CE errors popping up
> and the machine being serviced.

... you'll have ample time to service the machine.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
