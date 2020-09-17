Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0926D6E5
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 10:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgIQIkx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgIQIkv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Sep 2020 04:40:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C0C06174A;
        Thu, 17 Sep 2020 01:40:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1053007b81a97eebdb4df7.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:7b81:a97e:ebdb:4df7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 78CE61EC0286;
        Thu, 17 Sep 2020 10:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600332045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f45tA0/YC9IUsPdn38WrzVyT4ZLG9lSHJ1gA3ePCJkg=;
        b=TcdhPTEuj1NDjJ2AFLwnVTMhPwn/tSVlSy9KZFNSRZrqnyvoi1u9j8iPYUhb7zMGRjmvwG
        FcFbdbOuZIW783X0fnKeDqmtaqWBTTtpPwd6wvbxZe1AMi+V84iOMGx80LUwujzcZ4Lw9J
        cBgPHOjWCIxE503ZE+764ZpSuDaxvRg=
Date:   Thu, 17 Sep 2020 10:40:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 1/1] RAS: Add CPU Correctable Error Collector to isolate
 an erroneous CPU core
Message-ID: <20200917084038.GE31960@zn.tnic>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic>
 <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
 <20200909120203.GB12237@zn.tnic>
 <50714e083d55491a8ccf5ad847682d1e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50714e083d55491a8ccf5ad847682d1e@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 10, 2020 at 03:29:56PM +0000, Shiju Jose wrote:
> Ok. However the functions such as __find_elem() use
> memory specific PFN() and PAGE_SHIFT.

You can add your version find_elem_cpu() or so. You can do this with a
set of function pointers which belong to the different type of storage
the CEC needs, you can do all kinds of fun.

> I will check this. For CPU, the corrected errors count for a short
> time period to be checked. Thus old errors outside this period would
> not be considered and would be cleared. It is not clear to me whether
> in the current CEC, the count for the old errors outside a time period
> would be excluded for the threshold check or removed?

Currently, the CEC decays the errors each time do_spring_cleaning()
runs, by decrementing DECAY_BITS in the PFN record. Those which get
DECAY_BITS of 0, get overwritten when the data structure is full.

You can do something similar by halving the error count or something
more complex like save the error timestamp and eliminate...

You can't know what exactly you wanna do if you don't have a use case
you're trying to address.

> According to the ARM Processor CPER definition the error types
> reported are Cache Error, TLB Error, Bus Error and micro-architectural
> Error.

Bus error sounds like not even originating in the CPU but the CPU only
reporting it. Imagine if that really were the case, and you go disable
the CPU but the error source is still there. You've just disabled the
reporting of the error only and now you don't even know anymore that
you're getting errors.

> Few thoughts on this,
> 1. Not sure will a CPU core would work/perform as normal after disabling
> a functional unit?

You can disable parts of caches, etc, so that you can have a somewhat
functioning CPU until the replacement maintenance can take place.

> 2. Support in the HW to disable a function unit alone may not available.

Yes.

> 3. If it is require to store and retrieve the error count based on
> functional unit, then CEC will become more complex?

Depends on how it is designed. That's why we're first talking about what
needs to be done exactly before going off and doing something.

> This requirement is the part of the early fault prediction by taking
> action when large number of corrected errors reported on a CPU core
> before it causing serious faults.

And do you know of actual real-life examples where this is really the
case? Do you have any users who report a large error count on ARM CPUs,
originating from the caches and that something like that would really
help?

Because from my x86 CPUs limited experience, the cache arrays are mostly
fine and errors reported there are not something that happens very
frequently so we don't even need to collect and count those.

So is this something which you need to have in order to check a box
somewhere that there is some functionality or is there an actual
real-life use case behind it which a customer has requested?

> We are mainly looking for disable CPU core on large number of L1/L2
> cache corrected errors reported on a CPU core. Can we add atleast
> removing CPU core for the CPU cache corrected errors filtering out
> other error types?

See above.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
