Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23D9285E6
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfEWS2a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 14:28:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50202 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731107AbfEWS2a (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 14:28:30 -0400
Received: from cz.tnic (unknown [165.204.77.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4C01EC0722;
        Thu, 23 May 2019 20:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558636108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1dFzXcVh5H3mgKQCZ4xmGQdhf/xiGlb61Su3Uj/Yo6c=;
        b=ILlcH0LXJL/gRjkeOXDR8ELTkSF9fB8PBnYh+hCFeEKx8RnEe6vztTq6GATli7szEoyzSU
        UEWIWSxA56XlrlkoI6wO6HwRW5jQq+ssIhqVjKWyk+VFdnq6DHBFhemhmoHbTkuqplFFbn
        sPxFbPUeoS2hjZIA5yehDO7Qqe+Xucw=
Date:   Thu, 23 May 2019 22:28:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/MCE: Statically allocate mce_banks_array
Message-ID: <20190523202754.GA3980@cz.tnic>
References: <20190523150345.42906-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523150345.42906-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 23, 2019 at 03:03:55PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The MCE control data is stored in an array of struct mce_banks. This
> array has historically been shared by all CPUs and it was allocated
> dynamically during the first CPU's init sequence.
> 
> However, starting with
> 
> 	5b0883f5c7be ("x86/MCE: Make mce_banks a per-CPU array")
> 
> the array was changed to become a per-CPU array. Each CPU would
> dynamically allocate the array during its own init sequence.
> 
> This seems benign expect when "Lock Debugging" config options are
> enabled in which case the following message appears.
> 
> 	BUG: sleeping function called from invalid context at mm/slab.h:418
> 
> The message appears during the secondary CPUs' init sequences. This seems
> to be because these CPUs are in system_state=SYSTEM_SCHEDULING compared
> to the primary CPU which is in system_state=SYSTEM_BOOTING.
> 
> Allocate the mce_banks_array statically so that this issue can be
> avoided.
> 
> Also, remove the now unnecessary return values from
> __mcheck_cpu_mce_banks_init() and __mcheck_cpu_cap_init().
> 
> Fixes: 5b0883f5c7be ("x86/MCE: Make mce_banks a per-CPU array")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 39 ++++++++++++----------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)

Can you rediff this patch against tip/master please?

It fixes a patch which is already in -rc1 so it needs to go first, into
urgent, before your patchset.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
