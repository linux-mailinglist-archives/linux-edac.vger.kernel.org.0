Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E279CD03
	for <lists+linux-edac@lfdr.de>; Mon, 26 Aug 2019 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfHZKEW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Aug 2019 06:04:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfHZKEW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Aug 2019 06:04:22 -0400
Received: from zn.tnic (p200300EC2F0657001DC81C8A8210CD6A.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5700:1dc8:1c8a:8210:cd6a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B8FF1EC06E5;
        Mon, 26 Aug 2019 12:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566813860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PhiC8W2Bp0/CZk1KvtGBJlF7S2eVkxQY28iWckK8/Qs=;
        b=cbEzOJC2eLGvaleGPI2raXMtCwMPMsI+BM2a6DMBCnu25xI4r33+y+P1mb5pbIa1dROuid
        v9+YEhJAktBWXmjc3elvS40KWjnI0W9p9O1qdUvofGVKdJ1HPGh+yCqJdEr+VmkHvSafWg
        QFLlalbaMXjdL1uYGvSOVt+4pRa8Zjs=
Date:   Mon, 26 Aug 2019 12:04:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>
Subject: Re: [PATCH] x86/mce: show the status of cmci_disabled to user
Message-ID: <20190826100416.GC27636@zn.tnic>
References: <1566800164-6428-1-git-send-email-lixiaochun.2888@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1566800164-6428-1-git-send-email-lixiaochun.2888@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 26, 2019 at 02:16:04PM +0800, Xiaochun Lee wrote:
> From: Xiaochun Lee <lixc17@lenovo.com>
> 
> When enabled Firmware First mode in UEFI, we need to
> set the cmci_disabled and ignore_ce in mca cfg
> that users can check correct status from
> "/sys/devices/system/machinecheck/machinecheckXXX/cmci_disabled"
> 
> Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 743370e..932c701 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1909,6 +1909,8 @@ static void __mce_disable_bank(void *arg)
>  	int bank = *((int *)arg);
>  	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
>  	cmci_disable_bank(bank);
> +	mca_cfg.cmci_disabled = true;
> +	mca_cfg.ignore_ce = true;

That's the global switch which gets written here for every bank. But
you want to disable it per bank, not globally because the list of banks
arch_apei_enable_cmcff() receives might not be all banks in the system
which are in FF mode.

Then, writing
/sys/devices/system/machinecheck/machinecheckXXX/cmci_disabled from a
different CPU and for a different bank reenables cmci again so you need
to think of a better way how to address the per-bank thing and then to
make it non-modifiable in FF mode so that it cannot be reenabled from
sysfs again.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
