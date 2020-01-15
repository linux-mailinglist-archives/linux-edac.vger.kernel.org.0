Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19213C1A0
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 13:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOMsj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 07:48:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47136 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgAOMsj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 07:48:39 -0500
Received: from zn.tnic (p200300EC2F0C7700ACD7CA379FB916C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:acd7:ca37:9fb9:16c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CE251EC02D2;
        Wed, 15 Jan 2020 13:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579092517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RRzDcbrEYO6vPej3CmJAYWJu/0P03k1Uv077MCVlHV4=;
        b=a/dVzqYYD8DzbPQzyqhPZ1jPExfj8MHtpPTKzMrw2VpflVtiiDPy1AOng2VBEQZoTPpVWE
        LgAZ/HdZ6SW4Jpp5VT8VTsrcmKcRj8i7Awk9SJNVhPEyQUkjmr9b4Cg1U9EPZdWxFEXiVy
        enp6KKhmT0Nyu++LB1vBrn6ARK6sDV8=
Date:   Wed, 15 Jan 2020 13:48:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com, shji@microsoft.com
Subject: Re: [PATCH v8 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20200115124833.GE20975@zn.tnic>
References: <0cc7bcfe-0dee-b78a-a0fe-52cc48c00a44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cc7bcfe-0dee-b78a-a0fe-52cc48c00a44@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 14, 2020 at 03:52:23PM -0800, Shiping Ji wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.
> 
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>

I don't think you've understood the whole SOB chain thing yet. Previous
submissions had

Signed-off-by: Lei Wang <leiwang_git@outlook.com>

and her as author and you've completely removed those and made yourself
an author because when I apply this patch, it would take the From:
header from the mail and make it the author.

But you can't simply remove her authorship... you need to read that doc
again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
