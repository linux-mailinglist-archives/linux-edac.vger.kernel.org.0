Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B99124792
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 14:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfLRNFT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 08:05:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41408 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfLRNFT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 08:05:19 -0500
Received: from zn.tnic (p200300EC2F0B8B004C237F05E7CC242C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8b00:4c23:7f05:e7cc:242c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 294541EC0591;
        Wed, 18 Dec 2019 14:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576674318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=epS/Q4CPQrHIq8og5sJ81MAlwOHLeJ852bCwbKG3HlE=;
        b=hj8S/NLnZgwgxQAGDp/qAmGctiufUh18t5TnnCY6L4gAsr1LBBIlVd0tGYHE7kW+3qUYsv
        0t8Y64bxA6pVY1QqbyejtVI21mw8HyIP6JUfyAzl95KSKemN7hvqOgw+cHm3+3zi+EdPmO
        qLcZwlLs4e9bhyrOiqnpSXlwNHOTsfE=
Date:   Wed, 18 Dec 2019 14:05:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     John Garry <john.garry@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/mc: Fix use-after-free and memleaks during device
 removal
Message-ID: <20191218130510.GF24886@zn.tnic>
References: <20191218062129.7400-1-rrichter@marvell.com>
 <0c7da2d7-1cab-f518-2309-f740d7ef36fa@huawei.com>
 <20191218125456.kkqfuq7crshwwc7q@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218125456.kkqfuq7crshwwc7q@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 18, 2019 at 12:55:04PM +0000, Robert Richter wrote:
> I leave that to the maintainer as he is editing the SOB chain anyway.
> The patch would be sent to the stable list already which may cause
> confusion.

I haven't looked at it yet but I'd prefer if this patch went the normal
way and landed in stable only eventually so that it gets some testing by
people in linux-next first.

It is not a trivial patch and we did break EDAC with recent rework so
I'd prefer if we take it slowly here and do more extensive testing
before we expose it to the world.

Also, how does this patch play with your cleanup? I'm guessing this
patch goes first and then the cleanup...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
