Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5410106882
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2019 10:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfKVJB1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 Nov 2019 04:01:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfKVJB1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 22 Nov 2019 04:01:27 -0500
Received: from zn.tnic (p200300EC2F0E97008857C615A913C712.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:9700:8857:c615:a913:c712])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABB7A1EC0CFF;
        Fri, 22 Nov 2019 10:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574413285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=96l2VacW0WA05kfi367N/mmkr0O4il49grJtlPRX3hw=;
        b=LFrEgimm+MiacKNpdYHuSMJCV8yZBoPY//NVyxSmU6lNaP168DxMEu656txIPPML3RxjH5
        yB/UZLJwxnOKAMofvPwE6vOCVtVy802VxgFgKb3//hGIoVH5jDQmHiptZn9qsumWkV1dv6
        bN1QyXmLLtp3ri+HCfn0uCAyrPiiXa0=
Date:   Fri, 22 Nov 2019 10:01:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     "john.garry@huawei.com" <john.garry@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "huangming23@huawei.com" <huangming23@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "wanghuiqiang@huawei.com" <wanghuiqiang@huawei.com>
Subject: Re: [PATCH] EDAC/ghes: Do not warn when incrementing refcount on 0
Message-ID: <20191122090123.GB6289@zn.tnic>
References: <4ff7631f-fbb7-e45f-87dd-9223beca4da7@huawei.com>
 <20191121213628.21244-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191121213628.21244-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 21, 2019 at 09:36:57PM +0000, Robert Richter wrote:
> Following warning from the refcount framework is seen during ghes
> initialization:
> 
>  EDAC MC0: Giving out device to module ghes_edac.c controller ghes_edac: DEV ghes (INTERRUPT)
>  ------------[ cut here ]------------
>  refcount_t: increment on 0; use-after-free.
>  WARNING: CPU: 36 PID: 1 at lib/refcount.c:156 refcount_inc_checked+0x44/0x50
> [...]
>  Call trace:
>   refcount_inc_checked+0x44/0x50
>   ghes_edac_register+0x258/0x388
>   ghes_probe+0x28c/0x5f0
> 
> It warns if the refcount is incremented from zero. This warning is
> reasonable as a kernel object is typically created with a refcount of
> one and freed once the refcount is zero. Afterwards the object would
> be "used-after-free".
> 
> For ghes the refcount is initialized with zero, and that is why this
> message is seen when initializing the first instance. However,
> whenever the refcount is zero, the device will be allocated and
> registered. Since the ghes_reg_mutex protects the refcount and
> serializes allocation and freeing of ghes devices, a use-after-free
> cannot happen here.
> 
> Instead of using refcount_inc() for the first instance, use
> refcount_set(). This can be used here because the refcount is zero at
> this point and can not change due to its protection by the mutex.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Tested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
