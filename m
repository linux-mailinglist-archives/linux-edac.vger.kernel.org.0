Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A853747B4
	for <lists+linux-edac@lfdr.de>; Wed,  5 May 2021 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhEESC2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 May 2021 14:02:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43356 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234617AbhEESCF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 May 2021 14:02:05 -0400
Received: from zn.tnic (p200300ec2f0b0700c8e2e6ac6168ddaf.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:700:c8e2:e6ac:6168:ddaf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98FC11EC0575;
        Wed,  5 May 2021 20:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620237665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9MsvSPoqAuSFo18EN/V38hcIgjGFSURUTDAm8qZgTqI=;
        b=H6mQL62CuNZRX/wO6TuzeWJkHsk+XnbJBw940F1/W3iDLzovNPGQipZz3BqlIDQe54ddoF
        rWleCi6eYqENu/xOSNEZrjTxOXiXa0l297vymirFirekakxjg92gXbSEkDQHw65eI58x++
        2Grs8fxwUKrJpsZ63VWKB3KQGe4a2OI=
Date:   Wed, 5 May 2021 20:01:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <wangglei@gmail.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, lewan@microsoft.com,
        hangl@microsoft.com, tyhicks@linux.microsoft.com,
        bwaller@microsoft.com
Subject: Re: [PATCH] EDAC: update edac printk wrappers to use
 printk_ratelimited.
Message-ID: <YJLdZCcsgWG6TrKz@zn.tnic>
References: <20210505173027.78428-1-wangglei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505173027.78428-1-wangglei@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 05, 2021 at 10:30:27AM -0700, Lei Wang wrote:
> Update printk to the ratelimited version, so that in some corner cases when
> vast of CE errors show up, the kernel logging can be suppressed.

Err, why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
