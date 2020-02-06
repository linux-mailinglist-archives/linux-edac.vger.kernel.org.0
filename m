Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26C1542AE
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2020 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBFLKI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Feb 2020 06:10:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58788 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbgBFLKI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 6 Feb 2020 06:10:08 -0500
Received: from zn.tnic (p200300EC2F0B4B00DD2F869FBA3C2645.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4b00:dd2f:869f:ba3c:2645])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 817641EC0304;
        Thu,  6 Feb 2020 12:10:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580987406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pXe8SYdnVSzszvpvgVbWGzJVV3VL4bu8127SNhL5Ys0=;
        b=oVc/RybZz7qAJk/F3mhpReMzBViCnUdlN1po9m7V3XyJJratrE3Bd6gHGMEownoy6y8bp2
        ODdJ+Jh9MgNU6Kx6+dhmD9x4jE9Gt+/VqrP+P0WXCqYKQqd/q1MFGJBGOrRUq/j7y92p2F
        mxnfjHeRvzxWhYZElVm3JQk7iXZr5TQ=
Date:   Thu, 6 Feb 2020 12:10:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
Message-ID: <20200206110811.GC9741@zn.tnic>
References: <20200205125831.20430-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205125831.20430-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Feb 05, 2020 at 07:58:31AM -0500, Prarit Bhargava wrote:

> Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142

That subject is unreadable for humans.

> Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
> "spurious corrected errors may be logged in the IA32_MC0_STATUS register
> with the valid field (bit 63) set, the uncorrected error field (bit 61)
> not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
> an MCA Error Code (bits [15:0]) of 0x0005."
> 
> Block these spurious errors from the console and logs.

Are they being hit in the wild or why do we need this?

> Links to Intel Specification updates:
> HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-desktop-specification-update.html
> HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-mobile-specification-update.html
> HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v3-spec-update.html
> BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/core/5th-gen-core-family-spec-update.html

Those links tend to get stale with time. If you really want to refer to
the PDFs, add a new bugzilla entry on https://bugzilla.kernel.org/, add
them there as an attachment and add the link to the entry to the commit
message.

> Signed-off-by: Alexander Krupp <centos@akr.yagii.de>

What's that Signed-off-by: tag supposed to mean?

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-edac@vger.kernel.org
> ---
>  arch/x86/kernel/cpu/mce/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

If at all, this should be done by adding an intel_filter_mce() function
and called from filter_mce() so that such errors don't get logged.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
