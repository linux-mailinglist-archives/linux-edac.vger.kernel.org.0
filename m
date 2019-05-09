Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5B18C23
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEIOlW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 10:41:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfEIOlW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 10:41:22 -0400
Received: from zn.tnic (p200300EC2F0F5F00A4EF991375FD2B9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:a4ef:9913:75fd:2b9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E64801EC0AD6;
        Thu,  9 May 2019 16:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557412880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qeOScAfRAmQ56riL9fdpfe5rB018UBHT2CZaW0ZlCS8=;
        b=gEPalcgEW1yNQsU+wbPMOplWdstb11ij19P8HoCM1Ncv9hqhGu8Nnv1f3xgtuDaR8+sMdK
        V3rP4+JSENRGFBc4AV5wT13FXelL9kRWLY6J+qAEgflpaLiRsb257fZlF6ttVnuq+DwuFi
        qVfzMUvOeOKPDDR3YiddLjEr8bWcUhs=
Date:   Thu, 9 May 2019 16:41:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Message-ID: <20190509144113.GB17053@zn.tnic>
References: <20190508224201.27120-1-colin.king@canonical.com>
 <20190509141313.GA17053@zn.tnic>
 <55f8efee-a02c-1574-42fa-35e1d3df14f7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55f8efee-a02c-1574-42fa-35e1d3df14f7@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 09, 2019 at 03:29:42PM +0100, Colin Ian King wrote:
> These are the Coverity static analysis warning/error message
> classifications.  Tagging them should be useful for several reasons:
> 
> 1. We can classify the types of issues being fixed
> 2. We can see how many issues are being found/fixed with the use of
> static analysis tools like Coverity

Who's "We"?

> 3. It provides some context on how these bugs were being found.

I figured as much but I have more questions:

* you say "tools like Coverity" but the name Coverity is in the tag.
So another tool would want to add its own tag. Which begs the second
question:

* has it ever been discussed and/or agreed upon all those "tools" tags?

Because we remove internal tags which have no bearing on the upstream
kernel. When I see that tag, how can I find out what it means? Can I run
coverity myself?

Lemme dig another one:

Addresses-Coverity-ID: 744899 ("Missing break in switch")

Where do I look up that ID?

And so on...

Bottom line of what I'm trying to say is, those tags better be useful to
the general kernel audience - that means, they should be documented so
that people can look them up - or better not be in commit messages at
all.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
