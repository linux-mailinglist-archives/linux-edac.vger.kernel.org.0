Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07C6146364
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 09:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAWIX1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Jan 2020 03:23:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45466 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWIX0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Jan 2020 03:23:26 -0500
Received: from zn.tnic (p200300EC2F095B0060FE665DEF90E16F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:60fe:665d:ef90:e16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D8831EC047D;
        Thu, 23 Jan 2020 09:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579767805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WIJL5XHyKt5KPKlO9I4JS71YWtGovioHHFMiIIQUA4M=;
        b=kL3OvILS/zc0IEoZqMt3xfaJMrGvbZ3Bsz+Z35zr15SqFdwyAaZZXkpnGmaT1ZJUZsBH28
        r3RnAaE+xZT/6FCp3SdHdZeV7RrhAfodbplmpbM9vPNjJximr9OYLjvpaEreAKrE5Gi6CT
        NEZrzDbQh+F9o9/Jp5EWDNwvUWAlwJc=
Date:   Thu, 23 Jan 2020 09:23:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <20200123082322.GB10328@zn.tnic>
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 22, 2020 at 04:31:07PM -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> From: Lei Wang <leiwang_git@outlook.com>
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v10:
>          - Convert to the YAML format for binding description

So you've changed this patch considerably. If you do so, you cannot keep
Reviewed-by tags.

Also, AFAICT, you've written a completely *new* patch which would mean
that this time you're the author. Correct?

If so, you don't need to keep Lei's From.

In any case, please take some time to read this:

https://www.kernel.org/doc/html/latest/process/index.html

It is a lot so do concentrate on the whole process, i.e., this:

https://www.kernel.org/doc/html/latest/process/development-process.html

so that you have a basic idea.

If you have questions, I'm sure Sasha would be willing to answer them
even if he's away now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
