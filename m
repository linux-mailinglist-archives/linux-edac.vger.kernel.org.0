Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5132B39B5B7
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jun 2021 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFDJSR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Jun 2021 05:18:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhFDJSR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Jun 2021 05:18:17 -0400
Received: from zn.tnic (p200300ec2f1385002612a2abcd76da61.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:2612:a2ab:cd76:da61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9461D1EC01A2;
        Fri,  4 Jun 2021 11:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622798190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J9nrvw/bzBxbRLieeOU4WIop2dUyueapHVaqQ9wB1Kc=;
        b=XleGvosPJF5TFReptTdiurGiUKtZfqyxrFvL/PkHhRWfjn5MC4NXjTN4h6Yb/uzJ76ea/B
        F2bI/Q7nOj246NdxdqKjejv/8bp1dVuOJUYFsShpnbdACclCAzoVsChS2Jz52lVc2eZc76
        E7aM5IbHcDbRoXQcXEOBw/qwHMDjcUc=
Date:   Fri, 4 Jun 2021 11:16:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "BeSerra, Christopher" <beserra@amazon.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Provide sysfs interface to show CMCI storm
 state
Message-ID: <YLnvZz4OHrAROk+4@zn.tnic>
References: <20210601200505.966849-1-tony.luck@intel.com>
 <YLaaLws+4FEHOqQs@zn.tnic>
 <1cc039a15b4248e1a625dbb6fc275169@intel.com>
 <4B422201-A96F-4EB7-A42F-9A1BF89D4794@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4B422201-A96F-4EB7-A42F-9A1BF89D4794@amazon.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 03, 2021 at 10:48:12PM +0000, BeSerra, Christopher wrote:
> There are corner cases where the CE count is 0 when a storm occurs.
> EDAC completely missed logging CEs.

-ENOPARSE.

I'm sorry but you'll have to try again and be a lot more specific and
detailed when describing your use case and what exactly you're trying to
achieve.

Oh, and btw, please do not top-post.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
