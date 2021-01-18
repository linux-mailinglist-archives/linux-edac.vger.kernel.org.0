Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9D2FA8FC
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jan 2021 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbhARShf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jan 2021 13:37:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbhARSha (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 18 Jan 2021 13:37:30 -0500
Received: from zn.tnic (p200300ec2f069f001e13c6b7481d9a7b.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9f00:1e13:c6b7:481d:9a7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DFC91EC0258;
        Mon, 18 Jan 2021 19:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610995007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HzegoAfVAaZDbMTTGri4bkt9an6vYxRS8pFX5icPkSI=;
        b=LG+oqy9qBBRsJNBF02g3yaLSWmeU5nKLH4rV8OwnUJMlbGI7aILOqGDNGRd4Wqw+vXfeNL
        Vt4i06eSjr1IjIgLE492qqYnrQjqy2PhUilGbnGPEUTtI3ISyofSJraNVInPHVLR/rpnXY
        RvU1PrqluqrVphvE2q+gATDoQR5UnUc=
Date:   Mon, 18 Jan 2021 19:36:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [RFC PATCH 1/2] EDAC/ghes: Add EDAC device for the CPU caches
Message-ID: <20210118183637.GD30090@zn.tnic>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
 <20201208172959.1249-2-shiju.jose@huawei.com>
 <20201231164409.GC4504@zn.tnic>
 <a5745b56831c461bbb2cde4afc7ee295@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5745b56831c461bbb2cde4afc7ee295@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 15, 2021 at 11:06:30AM +0000, Shiju Jose wrote:
> L2 cache corrected errors are detected occasionally on few of
> our ARM64 hardware boards. Though it is rare, the probability of
> the CPU cache errors frequently occurring can't be avoided.
> The earlier failure detection by monitoring the cache corrected
> errors for the frequent occurrences and taking preventive
> action could prevent more serious hardware faults.
> 
> On Intel architectures, cache corrected errors are reported and
> the affected cores are offline in the architecture specific method.
> http://www.mcelog.org/cache.html
> 
> However for the firmware-first error reporting, specifically on
> ARM64 architectures, there is no provision present for reporting
> the cache corrected error count to the user-space and taking
> preventive action such as offline the affected cores.

How hard was it to write that in your first submission? What do you
think would be the best way to persuade a patch reviewer/maintainer to
take a look at your submission?

> >Why a separate Kconfig item?
> CONFIG_EDAC_GHES_CPU_CACHE_ERROR is added to make this
> feature optional only for the platforms which need this and supported.
> 
> >
> >> +	depends on EDAC_GHES

depends on EDAC_GHES hardly expresses which platforms need it/support
it.

If anything, depends on ARM64.

> >Init stuff belongs into ghes_scan_system().
> >
> Did you mean calling  ghes_edac_create_cpu_device() in the ghes_scan_system()?

I mean, all hardware discovery needs to happen in ghes_scan_system
- you don't need to call those from outside the driver, in
ghes_edac_register().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
