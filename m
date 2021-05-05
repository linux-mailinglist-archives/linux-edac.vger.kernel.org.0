Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C013748D2
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhEETqB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 15:46:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58682 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhEETqA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 May 2021 15:46:00 -0400
Received: from zn.tnic (p200300ec2f0b070095a0cdc8ba9d3b20.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:700:95a0:cdc8:ba9d:3b20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3C561EC046E;
        Wed,  5 May 2021 21:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620243903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iBtzxeku0BzbG6kK0L1hpR6azGfgLKROm2hQUdhdjKw=;
        b=DfvbjnYs6c+I61Fv5U17vDGrboPu/lFr5kZ41eVEHDcNNrJMPGjK7qD2L4ZzErQJqyY7Cs
        Y1Vq4HL+4dcqTxlJcFH789yCGpnU1zihb3H3lnTmjR3jxls5S5IClwrvXPvflCoCVr6vkP
        KnmL3xwU9JFRMB8yPb6ryK50qtLNS7o=
Date:   Wed, 5 May 2021 21:45:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>
Cc:     wangglei <wangglei@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hang Li <hangl@microsoft.com>,
        "tyhicks@linux.microsoft.com" <tyhicks@linux.microsoft.com>,
        Brandon Waller <bwaller@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <YJL1vU6HNBWPKy8g@zn.tnic>
References: <20210505173027.78428-1-wangglei@gmail.com>
 <YJLdZCcsgWG6TrKz@zn.tnic>
 <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ0PR21MB199984A8B47FBEECEC5D11CE90599@SJ0PR21MB1999.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Lei,

On Wed, May 05, 2021 at 07:02:14PM +0000, Lei Wang (DPLAT) wrote:
> Hi Boris,

first of all, please do not top-post.

> We found a corner case in production environment that there are ~500
> CE errors per second. The SoC otherwise functions just fine. Making
> printk ratelimited reduced CE error logging to < 20 per second.

If you want to avoid CE logs flooding dmesg, there's a couple of things
you can do:

1. Use drivers/ras/cec.c

2. Do not load EDAC drivers at all since you don't care about the error
reports, apparently.

3. Fix the CE source: replace the DIMMs, etc.

> Though this is just one case so far, we think moving to
> printk_ratelimited could benefit broader use as well, by helping
> control the amount of kernel logging.

No, this will make EDAC driver loading output incomplete when some of
the messages are omitted due to the ratelimiting. And no, this is not
going to happen.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
