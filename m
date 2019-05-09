Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4371518C97
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 17:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEIPBu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 11:01:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38992 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfEIPBu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 11:01:50 -0400
Received: from zn.tnic (p200300EC2F0F5F00A4EF991375FD2B9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:a4ef:9913:75fd:2b9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E06F1EC0AD6;
        Thu,  9 May 2019 17:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557414108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lcBwb2Z+A8lEvl5TQHsmwSZ2gCU/axb76s/Arz6Z4D4=;
        b=f+T0ZaBI9tX1QOINVSzFPUnyUS/ia4dOu7sR6qAO3Ct0zzrAx/jtbKTtzju7UdvnxSgqZ7
        hjmG5doHYBzxV4aH2MKdN75OegL5Af7PV8YGFmvDHh7iFz3xAAKWQ/0bJ1Lt502CxDNnuf
        MHFx+w2d7kzCYrJItufLtEVgf/Aeo3I=
Date:   Thu, 9 May 2019 17:01:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, sb_edac: remove redundant update of tad_base
Message-ID: <20190509150146.GE17053@zn.tnic>
References: <20190508224201.27120-1-colin.king@canonical.com>
 <20190509141313.GA17053@zn.tnic>
 <55f8efee-a02c-1574-42fa-35e1d3df14f7@canonical.com>
 <20190509144113.GB17053@zn.tnic>
 <ebe15617-fe6a-2668-f14e-146811147f14@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebe15617-fe6a-2668-f14e-146811147f14@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 09, 2019 at 03:55:32PM +0100, Colin Ian King wrote:
> Yep, I agree, but explaining all the Coverity error types in a kernel
> doc is going to take some effort, which I really don't have much time
> for at the moment.

I'm not suggesting you should document them all or write a comprehensive
howto on how to run Coverity - all I'm suggesting is starting a small
doc somewhere in Documentation/ which contains some info on what all
those tools tags we use, mean and how people can find the information
they contain. Basically what you said above (which I've snipped).

But it would be a lot more helpful if it is written down so that people
can look it up. Also, that doc will serve as a documentation of all
those tags we're using in the kernel and what their format, etc would
be.

Otherwise we'll have the current head scratching when a tag like that is
encountered...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
