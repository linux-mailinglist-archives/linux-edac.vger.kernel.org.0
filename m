Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A2141142
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 19:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgAQS5j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jan 2020 13:57:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgAQS5i (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Jan 2020 13:57:38 -0500
Received: from zn.tnic (p200300EC2F08DC00F542D1B17E7E874A.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:dc00:f542:d1b1:7e7e:874a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C3C51EC03F6;
        Fri, 17 Jan 2020 19:57:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579287456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=POACTC6mnXGZzWfF2psU4bC7N5ybL/xYN8K9pQsvVts=;
        b=lrxsDNeSB5hwOaA/GXovvrEqZLuVO5W8q7BY0QoRbSkqI2RGheQfmBDQNi3UOIogUbpyeM
        T7keG914fxIfQL+BXDEuL67l42JbLj2ap3zDL6j9RsG11MjWArU7OV6BrUdzpGRA8LRsuD
        A0xX62R8W6mQ31PFYXaaLyXx+A+0V90=
Date:   Fri, 17 Jan 2020 19:57:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20200117185728.GC31472@zn.tnic>
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
 <20200117001843.GJ27148@zn.tnic>
 <d5989a4c-8173-2f03-7d20-6fdd32d19591@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5989a4c-8173-2f03-7d20-6fdd32d19591@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 17, 2020 at 10:31:18AM -0800, Shiping Ji wrote:
> This is to protect concurrent writes to the mci->error_desc as
> suggested by James when reviewing the patch v3.

Please comment that in the structure definition so that it is clear what
it is for.

> I'm trying to find a good scheme to make them shorter, at the moment
> they are named according to the TRM.

Yeah, keeping it the same as the documentation is also a good idea. I
leave it up to you to decide as you'll be staring at that code when bugs
happen. :)

> I'm not sure how this can be done perfectly with tabs only :)

Who says you should use only tabs? :-)

> All other comments have been addressed in the next patch, many thanks!

Thanks too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
