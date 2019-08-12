Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0727897E4
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfHLHbj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 03:31:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfHLHbi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 03:31:38 -0400
Received: from zn.tnic (p200300EC2F062700705A3C93C863E474.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:2700:705a:3c93:c863:e474])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 946DA1EC074B;
        Mon, 12 Aug 2019 09:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565595097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HIcq0KY0GaLpoIyyj2S96sngcdEQFgKkq4QBqsm3C6Y=;
        b=AjY+bT2plZ/db4kUCxJOU2w4SzOFhhcVe2D7jcPtKobGvsA6fmc30OW5KpyA8N1Nj4xNtQ
        Uo0bbyakhNb2EIt04wUfeIvKJLrF1rMvD1LQvjQZZ+1cDAuqDtG1ViWIQQ2820gEYhCof2
        t3J2hcehvs5RGEfpXXNpSlNKPRngogs=
Date:   Mon, 12 Aug 2019 09:32:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Message-ID: <20190812073221.GA23772@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-3-rrichter@marvell.com>
 <20190809131559.GF2152@zn.tnic>
 <20190812064147.5czmkj7e6hxgvje3@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812064147.5czmkj7e6hxgvje3@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 12, 2019 at 06:42:00AM +0000, Robert Richter wrote:
> I have seen you had actively promoted this style guideline, I even was
> not aware of it, thanks for the pointer.

It is about time we started writing proper commit messages. How long are
we trying, 20 years...?

> With the grain_bits calculation the mask is rounded up to the next
> power of 2 value.

mask	  = 0xffffffffff00ff00
~mask	  = 0x0000000000ff00ff
~mask + 1 = 0x0000000000ff0100

Your "trick" of adding a 1 to get to the most significant bit simply
doesn't work here. Thus:

"I guess we can leave it like that for now until some "inventive"
firmware actually does it."

> The reason this is here is because this check will be moved to
> edac_raw_mc_handle_error() to unify edac_mc and ghes code (see patch
> #4).

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
