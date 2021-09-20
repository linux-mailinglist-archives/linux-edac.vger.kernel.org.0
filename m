Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CDC4119E9
	for <lists+linux-edac@lfdr.de>; Mon, 20 Sep 2021 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhITQiw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Sep 2021 12:38:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhITQiv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 20 Sep 2021 12:38:51 -0400
Received: from zn.tnic (p200300ec2f0a2a00274102d8249bfe43.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:2741:2d8:249b:fe43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 844FB1EC0354;
        Mon, 20 Sep 2021 18:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632155839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OZLOStkn+5FkSTPMmV67a0eHWTpfl/RGMxI9yKzZj+E=;
        b=LnpcfM8yS9mNHTXgEX7weD8k5b5jYRigsOoGxUu4iH2XfhXnjzDMY/hSqLxjZhnZZH8+mQ
        KNkKn7vvbCjnUNjbQoFWRnIDXIq+hHFuaHADtPbAPnRg7j6V1SmsXgzNL+ODy+rflfgBsc
        3x5NDm+v/56Fk909N6DaYI0TmtBiSsI=
Date:   Mon, 20 Sep 2021 18:37:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "Song, Youquan" <youquan.song@intel.com>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] x86/mce: Drop copyin special case for #MC
Message-ID: <YUi4v6BHqN5WqJUd@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-4-tony.luck@intel.com>
 <YUhQsOKLeY/QV6ag@zn.tnic>
 <9d4690a2f3f143f882f63bd88c355004@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d4690a2f3f143f882f63bd88c355004@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 20, 2021 at 04:18:58PM +0000, Luck, Tony wrote:
> > Can we name some of those fixes here pls?
> 
> Some/all of this bunch from Al Viro:

Is this how you generated that list, per chance?

$ git log --oneline v5.14 -- lib/iov_iter.c

?

Output looks at least similar to what you've pasted...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
