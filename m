Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4426C1A1FEC
	for <lists+linux-edac@lfdr.de>; Wed,  8 Apr 2020 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDHLhE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Apr 2020 07:37:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53940 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgDHLhE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Apr 2020 07:37:04 -0400
Received: from zn.tnic (p200300EC2F0A93002915F3875052DE5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9300:2915:f387:5052:de5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B71A91EC0CB7;
        Wed,  8 Apr 2020 13:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586345822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8B7Lpwopv7bhEKiyrHmM7cD+4oDeQcPSNFxaTkXQd5A=;
        b=nC8WtXmWVyEESODVC+1xfUG/xs8ksXTvIIWaZoGYXs9b0VjiLatLp2gWi9LSvBgUE/g2Tg
        4tvQgaynkaCmxpzf3D4C3poOKjSeH3hl51ZaMuw1buuaQxXdeIPa9Vv7eLcoErM1mGWU9j
        70KtLQL7GZ6mU5yn7IICLQ5C5ZgJXto=
Date:   Wed, 8 Apr 2020 13:36:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     rrichter <rrichter@marvell.com>,
        "thor.thayer" <thor.thayer@linux.intel.com>,
        mchehab <mchehab@kernel.org>, "tony.luck" <tony.luck@intel.com>,
        "james.morse" <james.morse@arm.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] EDAC/altera:Use platform_get_irq_optional()
Message-ID: <20200408113658.GE24663@zn.tnic>
References: <20200402112740.15580-1-tangbin@cmss.chinamobile.com>
 <20200402123001.obgzqmlure4cfvh7@rric.localdomain>
 <202004022106312118022@cmss.chinamobile.com>
 <20200408071022.ft6aamptrxlaz23f@rric.localdomain>
 <2020040819334451781313@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2020040819334451781313@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 08, 2020 at 07:33:44PM +0800, Tang Bin wrote:
>   I know what you mean, Thanks.

I don't think you do because you still top-post.

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
