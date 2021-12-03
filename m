Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC80467FC3
	for <lists+linux-edac@lfdr.de>; Fri,  3 Dec 2021 23:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383353AbhLCWVM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Dec 2021 17:21:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240628AbhLCWVL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Dec 2021 17:21:11 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 042311EC0423;
        Fri,  3 Dec 2021 23:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1638569862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kL9eqgUNrzI/sJU1B6x23WPjaQ2GSbsiis3eiY9isNs=;
        b=cqgkIxnweoXx+8bEKER/LyPENhJkKR4PFOgzHezUMhg+N3NsDRCHyPRw8p3Nq+COOt0XHF
        DucbO/MV4Lnhn9V8ssaJ9HmDFxfSu9YtJ7dj2Jkh/w1xNz4zyJVCjfMTo9Cdr2xj7g6oRx
        Lo8Yk4U74ALEujjnDH/cb5b98y07y6Y=
Date:   Fri, 3 Dec 2021 23:17:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mukul.joshi@amd.com,
        alexander.deucher@amd.com, william.roche@oracle.com
Subject: Re: [PATCH 1/3] x86/MCE/AMD: Provide an "Unknown" MCA bank type
Message-ID: <YaqXiVjNLINxwz8G@zn.tnic>
References: <20211203020017.728440-1-yazen.ghannam@amd.com>
 <20211203020017.728440-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211203020017.728440-2-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 03, 2021 at 02:00:15AM +0000, Yazen Ghannam wrote:
> The AMD MCA Thresholding sysfs interface populates directories for each
> bank and thresholding block. The name used for each directory is looked
> up in a table of known bank types. However, new bank types won't match
> in this list and will return NULL for the name. This will cause the
> machinecheck sysfs interface to fail to be populated.
> 
> Set new and unknown MCA bank types to the "unknown" type. Also,
> ensure that the bank's thresholding block directories have unique names.
> This will ensure that the machinecheck sysfs interface can be
> initialized.

What is the advantage of having a sysfs directory structure headed with
an "unknown" entry vs not having that structure at all when the kernel
runs on a machine for which it has not been enabled yet?

IOW, if those new banks would need additional enablement, what's the
point of having "unknown" on older kernels which do not have any
functionality?

IOW, how does this:

/sys/devices/system/machinecheck/machinecheck0/unknown/unknown/
├── error_count
├── interrupt_enable
└── threshold_limit

help a user?

Btw, looking at the current layout:

...
├── insn_fetch
│   └── insn_fetch
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit
├── l2_cache
│   └── l2_cache
│       ├── error_count
│       ├── interrupt_enable
│       └── threshold_limit
...

we have those names repeated which looks wonky and useless too. I'd
expect them to be:

...
├── insn_fetch
│   ├── error_count
│   ├── interrupt_enable
│   └── threshold_limit
├── l2_cache
│   ├── error_count
│   ├── interrupt_enable
│   └── threshold_limit
...

Can we fix that too pls?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
