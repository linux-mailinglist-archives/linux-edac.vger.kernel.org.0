Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3799281305
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgJBMoD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:44:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMoD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:44:03 -0400
Received: from zn.tnic (p200300ec2f0d63009d6e503e82117789.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:9d6e:503e:8211:7789])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A9B11EC04F0;
        Fri,  2 Oct 2020 14:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601642642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6ePxXu+m7xjdZ0x/dAl/b7hIP0Q5tfRXgfKM5KroND4=;
        b=ZEH2/+CyIVjBWYEvFyyFb/zSxiibBHpwMAke0JCHzvypMEUV2Km3E0xNBxzQcmMA7OISlW
        /eI37VnU7XhCXNuxuKEZnRa3WBCtIQKfDQXLUgSdgohAaF00oplMuBaGVQwrq7BJP3ebSr
        5/1QBMOvQ+I/eOmMLU99QE4JEDsLn7s=
Date:   Fri, 2 Oct 2020 14:43:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        rjw@rjwysocki.net, james.morse@arm.com, lenb@kernel.org,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
Message-ID: <20201002124352.GC17436@zn.tnic>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002122235.1280-1-shiju.jose@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 02, 2020 at 01:22:28PM +0100, Shiju Jose wrote:
> Open Questions based on the feedback from Boris,
> 1. ARM processor error types are cache/TLB/bus errors.
>    [Reference N2.4.4.1 ARM Processor Error Information UEFI Spec v2.8]
> Any of the above error types should not be consider for the
> error collection and CPU core isolation?
> 
> 2.If disabling entire CPU core is not acceptable,
> please suggest method to disable L1 and L2 cache on ARM64 core?

More open questions:

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

Open question from James with my reply to it:

On Thu, Oct 01, 2020 at 06:16:03PM +0100, James Morse wrote:
> If the corrected-count is available somewhere, can't this policy be
> made in user-space?

You mean rasdaemon goes and offlines CPUs when certain thresholds are
reached? Sure. It would be much more flexible too.

First we answer questions and discuss, then we code.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
