Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845A8262E60
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIIMPi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Sep 2020 08:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgIIMNi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Sep 2020 08:13:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471EC06179E;
        Wed,  9 Sep 2020 05:02:10 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ae7002c1f5e624f33a6aa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e700:2c1f:5e62:4f33:a6aa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C37D71EC0423;
        Wed,  9 Sep 2020 14:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599652928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kgJlGGMVRB9lfRXv2ieQ2H9t4e0tJoEqcTQEnRU5y84=;
        b=sdE9CNICvAPqLe7kTQTgGYGJkizFSaRt2dUBWSb6pnR2OzMoqJf56x/jNz2O/vsE3teYJM
        ThiWdxnHS8E1qmuroDI7eBWqkhdjVK8ezQljpp6rrrcQgDgMI3Fbe2gPasY7jp+p7hnUzx
        jz9miS5VNff04z9hQ20V9IP+0z6IHq8=
Date:   Wed, 9 Sep 2020 14:02:03 +0200
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
Message-ID: <20200909120203.GB12237@zn.tnic>
References: <20200901140140.1772-1-shiju.jose@huawei.com>
 <20200901143539.GC8392@zn.tnic>
 <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <512b7b8e6cb846aabaf5a2191cd9b5d4@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 01, 2020 at 04:20:54PM +0000, Shiju Jose wrote:
> CPU CEC derived the infrastructure of the CEC only and the logic
> used in the CEC for CE count storage, CE count calculation and page
> isolation is very unique for the memory pages, which seems cannot be
> reusable for the CPU CEs.

Oh, because it saves the reported error's PFN and you want to save

[CPU num | error count]

?

Well, you can easily change that by extending the existing CEC to have a
different storage format for CPU errors, i.e., use a different ce_array
which gets passed to the functions anyway.

> Also the values set for the parameters such as threshold, time period
> for the memory errors and CPU errors would be different.

And your implementation with sliding windows is so totally different
that it warrants the duplication of the code? I don't think so.

You can use the current CEC to do exactly what you wanna do, with the
decaying and so on.

Because all you wanna do is count the errors a CPU triggered.

However, a CPU can trigger a *lot* of different types of errors.
You're putting them all in the same basket by doing:

                else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM))
			/* add to CEC */

and only for correctable.

What type of errors get reported in CPER_SEC_PROC_ARM?

If they're all lumped together and if some functional unit generates a
lot of errors, instead of disabling that unit only, you'll go and remove
the whole CPU?

Doesn't make a whole lot of sense to me.

How about you define what exactly you're trying to solve, maybe give an
example of a real issue someone is encountering and you're trying to
address? Because there was never a necessity so far to disable CPUs on
x86 due to correctable errors. Why is that needed on ARM?

> Thus extending cec.c to support CPU CEs would include adding CPU CEC
> specific code for storing error count, isolation etc which I thought
> would result the code less tidy and less readable unless find more
> reusable logic.

Depends on how you design it.

But with what I'm seeing so far, I'm still sceptical this is needed at
all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
