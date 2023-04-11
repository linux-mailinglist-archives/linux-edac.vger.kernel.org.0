Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACB6DDAE7
	for <lists+linux-edac@lfdr.de>; Tue, 11 Apr 2023 14:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjDKMcj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Apr 2023 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKMci (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Apr 2023 08:32:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84D3C0D;
        Tue, 11 Apr 2023 05:32:36 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2864F1EC0102;
        Tue, 11 Apr 2023 14:32:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681216355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J2HCKRIBrXsU7kelLcEdA1HpSPdlc1PDVdwjnmLRAHI=;
        b=fXRtZnP0YqMKMv/C5tf9xXpS5Tm5Eg7tc9mSll/Wp16Zq5glKMdeNoXYxdpnG5xHPN+UWc
        6KCbxd6LSxyOWXpATK4Zn78JqM+XtWFKpC+odxSZ/pru6PBIFFubLnsPPmidlshQ8cwDTu
        89/cZGd8sZ7QukLK3ACd9MtFkPatUS0=
Date:   Tue, 11 Apr 2023 14:32:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 2/5] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20230411123234.GGZDVTYppLWRN5t0jX@fat_crate.local>
References: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
 <20230403210716.347773-1-tony.luck@intel.com>
 <20230403210716.347773-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403210716.347773-3-tony.luck@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 03, 2023 at 02:07:13PM -0700, Tony Luck wrote:
> Add a hook into machine_check_poll() to keep track of per-CPU, per-bank
> corrected error logs.
> 
> Maintain a bitmap history for each bank showing whether the bank
> logged an corrected error or not each time it is polled.
> 
> In normal operation the interval between polls of this banks
> determines how far to shift the history. The 64 bit width corresponds
> to about one second.
> 
> When a storm is observed the Rate of interrupts is reduced by setting
> a large threshold value for this bank in IA32_MCi_CTL2. This bank is
> added to the bitmap of banks for this CPU to poll. The polling rate
> is increased to once per second.
> During a storm each bit in the history indicates the status of the
> bank each time it is polled. Thus the history covers just over a minute.
> 
> Declare a storm for that bank if the number of corrected interrupts
> seen in that history is above some threshold (5 in this RFC code for
> ease of testing, likely move to 15 for compatibility with previous
> storm detection).
> 
> A storm on a bank ends if enough consecutive polls of the bank show
> no corrected errors (currently 30, may also change). That resets the
> threshold in IA32_MCi_CTL2 back to 1, removes the bank from the bitmap
> for polling, and changes the polling rate back to the default.
> 
> If a CPU with banks in storm mode is taken offline, the new CPU
> that inherits ownership of those banks takes over management of
> storm(s) in the inherited bank(s).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/internal.h |   4 +-
>  arch/x86/kernel/cpu/mce/core.c     |  26 ++++--
>  arch/x86/kernel/cpu/mce/intel.c    | 139 ++++++++++++++++++++++++++++-
>  3 files changed, 158 insertions(+), 11 deletions(-)

ld: vmlinux.o: in function `machine_check_poll':
/home/boris/kernel/2nd/linux/arch/x86/kernel/cpu/mce/core.c:683: undefined reference to `track_cmci_storm'
make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
make: *** [Makefile:1249: vmlinux] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
