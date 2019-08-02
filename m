Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85357ECE0
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbfHBGuF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 02:50:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49350 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388947AbfHBGuE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 02:50:04 -0400
Received: from zn.tnic (p200300EC2F0D960039009D029409112E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:9600:3900:9d02:9409:112e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 721C81EC0B7A;
        Fri,  2 Aug 2019 08:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564728602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZoHS25hRNMnicnDGhWVhC+DXNpZvWLKJr/VOV1lJfWA=;
        b=qv9aOIdBTTJJFHsk8glWcoEez7S0/g43QdSqvyxPmXZOdN1NGrbU7TN/fwKTdcWw7lRyw5
        Fnw0W6J9qhzbSJpQC77QgJPqzQL/xvSQ08WKuvjQcJvibtpmXa+N2LBungpst3uO2EPSid
        JCA+r/y0+NpXW1d7LB2yfZh7oScH+Bw=
Date:   Fri, 2 Aug 2019 08:49:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] EDAC/amd64: Support more than two controllers for
 chip selects handling
Message-ID: <20190802064953.GA30661@zn.tnic>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190709215643.171078-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709215643.171078-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 09, 2019 at 09:56:54PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The struct chip_select array that's used for saving chip select bases
> and masks is fixed at length of two. There should be one struct
> chip_select for each controller, so this array should be increased to
> support systems that may have more than two controllers.
> 
> Increase the size of the struct chip_select array to eight, which is the
> largest number of controllers per die currently supported on AMD
> systems.
> 
> Fix number of DIMMs and Chip Select bases/masks on Family17h, because AMD
> Family 17h systems support 2 DIMMs, 4 CS bases, and 2 CS masks per
> channel.
> 
> Also, carve out the Family 17h+ reading of the bases/masks into a
> separate function. This effectively reverts the original bases/masks
> reading code to before Family 17h support was added.
> 
> This is a second version of a commit that was reverted.
> 
> Fixes: 07ed82ef93d6 ("EDAC, amd64: Add Fam17h debug output")
> Fixes: 8de9930a4618 ("Revert "EDAC/amd64: Support more than two controllers for chip select handling"")

I'm not sure about those Fixes: tags you're slapping everywhere. First
of all, 8de9930a4618 is a revert so how can this be fixing a revert? If
anything, it should be fixing the original commit

  0a227af521d6 ("EDAC/amd64: Support more than two controllers for chip select handling")

which tried the more-than-2-memory-controllers thing.

But, it is not really a fix for that commit but a second attempt at it.
Which is not really a fix but hw enablement.

So I'm dropping those tags here. If you want them in stable, pls
backport them properly and test them on the respective stable kernels
before sending them to stable.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
