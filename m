Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731A377F71
	for <lists+linux-edac@lfdr.de>; Mon, 10 May 2021 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEJJhM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 May 2021 05:37:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJJhM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 May 2021 05:37:12 -0400
Received: from zn.tnic (p200300ec2f066d00c3c3b9d774715f25.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6d00:c3c3:b9d7:7471:5f25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E35701EC023E;
        Mon, 10 May 2021 11:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620639367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YKK0beKuz0QyAL95hY2ld06yBdTMUEkuXvRFlvrRyrw=;
        b=mVAmVr+0WDmvwgKJ6A8qkKXrxe86Iyrt5//0uTJmznr5FA+nUTz9YsPdmwHr76rl1P9oB+
        kk5Dly336i6tMz2A/oy/hC/UgjxBnMAYaeRwk04OEhOLq/06EvrP9KiYDPYIneIEht8P1X
        uWGxn33I10SUrDAChbuSuv49GLa46zQ=
Date:   Mon, 10 May 2021 11:36:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lv Ying <lvying6@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        tony.luck@intel.com, fanwentao@huawei.com, xujing99@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Fix printk deadlock causing
 mce_timed_out panic
Message-ID: <YJj+hHBEi8sYMp79@zn.tnic>
References: <20210509053229.GA2477949@localhost.localdomain>
 <YJahM9PaZ7Jefkbi@zn.tnic>
 <20210510200424.GA4056660@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210510200424.GA4056660@localhost.localdomain>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 11, 2021 at 09:33:10AM +0800, Lv Ying wrote:
> This panic happend on 4.18 kernel

When you report bugs and send patches to lkml and maintainers, *always*
do that against the latest upstream version.

This is not the first time people from Huawei send bug reports and
"fixes" for old kernels.

Please let your colleagues and whoever else at Huawei is sending patches
and reporting bugs - *always* test and report bugs against the latest
upstream kernel - not some old version!

If you want bugs against

4.18.0-147.5.1.6.h429.eulerosv2r10.x86_64

fixed, go report that to whoever has made that kernel - not upstream.

Now, if you want to improve the upstream kernel and can trigger the same
thing with the upstream kernel, pls give the *exact* full information I
asked you before so that I am able to reproduce that here independently
and then we can take it from there.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
