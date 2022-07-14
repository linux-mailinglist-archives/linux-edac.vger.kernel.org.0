Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A0E574F36
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jul 2022 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiGNNb7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jul 2022 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiGNNb7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Jul 2022 09:31:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D726E5F98B;
        Thu, 14 Jul 2022 06:31:56 -0700 (PDT)
Received: from nazgul.tnic (unknown [193.86.92.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E9271EC064D;
        Thu, 14 Jul 2022 15:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657805511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lHLKg6dy+E2Uxp8MZ4B8ENOJdS38/GHHYZSNyRg96is=;
        b=mJVTnZKPet5KiOpUBcjQLVkdHplYc0gxIc9kyjP66sOUMqfRCHw/pUaDhPjZnBvTxHcmi2
        ld8O+xBMKi45O2YeXVYceE4jlrAh3JOYPzZvPzoA2v0cKuhyY4FJq2NiRjVPhb7/LsQq+B
        a3taxcfo0N+fpL3IH2Gc2VIQN5XHsX8=
Date:   Thu, 14 Jul 2022 15:31:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [GIT PULL 1/7] soc/tegra: Changes for v5.20-rc1
Message-ID: <YtAajDYfcVHRGl1U@nazgul.tnic>
References: <20220708185608.676474-1-thierry.reding@gmail.com>
 <20220708185608.676474-2-thierry.reding@gmail.com>
 <CAK8P3a1bKUr77t9xkNAX=-RqzRme6Hymr3V=36MSHT_sOFEW5A@mail.gmail.com>
 <Ys6lXD6BSxjH02mW@orome>
 <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0cSq47B=acZ854TVu=RckJNfyfKdqQUMzCX7SsV7Wt0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jul 13, 2022 at 02:14:27PM +0200, Arnd Bergmann wrote:
> I think this is just a reflection of what other hardware can do:
> most machines only detect memory errors, but the EDAC subsystem
> can work with any type in principle. There are also a lot of
> conditions elsewhere that can be detected but not corrected.

Just a couple of thoughts from looking at this:

So the EDAC thing reports *hardware* errors by using the RAS
capabilities built into an IP block. So it started with memory
controllers but it is getting extended to other blocks. AMD are looking
at how to integrate GPU hw errors reporting into it, for example.

Looking at that CBB thing, it looks like it is supposed to report not
so much hardware errors but operational errors. Some of the hw errors
reported by RAS hw are also operation-related but not the majority.

Then, EDAC has this counters exposed in:

$ grep -r . /sys/devices/system/edac/
/sys/devices/system/edac/power/runtime_active_time:0
/sys/devices/system/edac/power/runtime_status:unsupported
/sys/devices/system/edac/power/runtime_suspended_time:0
/sys/devices/system/edac/power/control:auto
/sys/devices/system/edac/pci/edac_pci_log_pe:1
/sys/devices/system/edac/pci/pci0/pe_count:0
/sys/devices/system/edac/pci/pci0/npe_count:0
/sys/devices/system/edac/pci/pci_parity_count:0
/sys/devices/system/edac/pci/pci_nonparity_count:0
/sys/devices/system/edac/pci/edac_pci_log_npe:1
/sys/devices/system/edac/pci/edac_pci_panic_on_pe:0
/sys/devices/system/edac/pci/check_pci_errors:0
/sys/devices/system/edac/mc/power/runtime_active_time:0
/sys/devices/system/edac/mc/power/runtime_status:unsupported
...

with the respective hierarchy: memory controllers, PCI errors, etc.

So the main question is, does it make sense for you to fit this into the
EDAC hierarchy and what would even be the advantage of making it part of
EDAC?

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
