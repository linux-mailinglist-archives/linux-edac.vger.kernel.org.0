Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CB26E652
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 22:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQULl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIQULk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Sep 2020 16:11:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883BDC06174A;
        Thu, 17 Sep 2020 13:10:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f105300976879d3dfc1e489.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:9768:79d3:dfc1:e489])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 716611EC032C;
        Thu, 17 Sep 2020 22:10:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600373434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=P95wvz8GjlQzrWPN6pifkKg5AF9utITXdObIIxhYzsI=;
        b=Dt67bGyJjlr6RfszmCnyljEZg0OGNDqUff0/pv1RTRAV1uHSFteBjZwl2HCH0pnYEBTjAu
        25I79ayECpEfvDaM2+0T8yxAbfCWVAqM0fEg8pqgJvTllxD4r7fJODLZ4UrjwszFYfFctK
        mWj5GFONTtzeWZVLSANVDaQ65NgMIFg=
Date:   Thu, 17 Sep 2020 22:10:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200917201027.GS31960@zn.tnic>
References: <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
 <20200914192039.GA39519@yaz-nikka.amd.com>
 <20200915083259.GC14436@zn.tnic>
 <20200916195152.GA3042858@yaz-nikka.amd.com>
 <20200917103720.GG31960@zn.tnic>
 <20200917162053.GA234735@yaz-nikka.amd.com>
 <20200917164048.GM31960@zn.tnic>
 <20200917194425.GB504453@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917194425.GB504453@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 17, 2020 at 02:44:25PM -0500, Yazen Ghannam wrote:
> Yes, I think so. "Die" is not defined in CPUID(0xb), only SMT and Core,
> so the cpu_die_id value is not valid.

Right.

> In which case, we can overwrite it. CPUID(0xb) doesn't have anything
> equivalent to AMD NodeId. So on systems with CPUID < 0x1F, we should
> be okay with using cpu_die_id equal to AMD NodeId.

Right.

> I have an idea on what to do, so I'll send another rev if that's okay.
> Do you have any comments on the other patches in the set?

Lemme go through them these days.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
