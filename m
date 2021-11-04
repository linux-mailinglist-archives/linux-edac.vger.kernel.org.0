Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F15344593E
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 19:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKDSFT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhKDSFS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Nov 2021 14:05:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711AAC061714;
        Thu,  4 Nov 2021 11:02:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2b00d41ed3305b1ea114.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:d41e:d330:5b1e:a114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF41C1EC0521;
        Thu,  4 Nov 2021 19:02:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636048958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3GlHDVXRFAhTXXRXq8rqot+hoEQwnQw4uojRIafFclo=;
        b=TE7I5Cfivl/k3UtF47A+2Z5FBAoyBm5byQpGzXfBHWByRXzgLsxnBrXgDO3YC4Hl/foy1d
        EdmjOLr4E967rfO6eqekYzxWl4WBOjtpTL5ZNUt1ABp1t/AxnLuMefIWgFxN2xNESPLYSY
        2NMCWb3BR/SPbf1P7WXo3tVI9/wu4hY=
Date:   Thu, 4 Nov 2021 19:02:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: correct cpu_missing reporting in mce_timed_out
Message-ID: <YYQgPGVxP0R9hfYx@zn.tnic>
References: <20211104074431.1091525-1-zhangzl2013@126.com>
 <YYOkKm8UmmIxSdXF@zn.tnic>
 <442373b1384e4607ba743de4c09df670@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <442373b1384e4607ba743de4c09df670@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 04, 2021 at 03:47:36PM +0000, Luck, Tony wrote:
> > Frankly, we might just as well kill that cpu_missing thing because we
> > already say that some CPUs are not responding.
> 
> Yes. The more recent commit:
> 
> 7bb39313cd62 ("x86/mce: Make mce_timed_out() identify holdout CPUs")
> 
> tries to provide the more detailed message about *which* CPUs are missing

Exactly.

> I think cpu_missing can be dropped.

Zhaolong, you could send a patch doing that, instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
