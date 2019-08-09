Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D848B88135
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 19:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407204AbfHIRbe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Aug 2019 13:31:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55468 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIRbe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Aug 2019 13:31:34 -0400
Received: from zn.tnic (p200300EC2F0BAF00B1329C581B3162A4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:af00:b132:9c58:1b31:62a4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 849F21EC0BED;
        Fri,  9 Aug 2019 19:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565371892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rq2nb0ENx8Jefs6h4lgzhs05Z7Ax75UhuZs4DDvd6iU=;
        b=AnvQ3+HSdMQe4IlIgThxzxUSj5cWD4+6FGjGSUuxs1G1HC0nPP/gLyEZ+cW6eQ0bXhiSfY
        7eV1IMQHqoLT0yEJiSnnqUKuBZ4OfkmnSrLTs5YV58LlT47FciTf/J20GMsnygZr3rc3TM
        2L3C8aTdOfqq7eZlhupqy9f/RIE/Tjw=
Date:   Fri, 9 Aug 2019 19:32:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, pnd2: Fix ioremap() size in dnv_rd_reg()
Message-ID: <20190809173218.GH2152@zn.tnic>
References: <20190809141737.15580-1-stephend@silicom-usa.com>
 <20190809172533.GA31823@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809172533.GA31823@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 09, 2019 at 10:25:33AM -0700, Luck, Tony wrote:
> [Boris/Mauro: I pushed to edac-for-next branch in ras tree
>  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git]

Yap, this is the workflow. And from now on, we all should refresh
our local copies of edac-for-next before applying stuff. And when we
happen to push at the same time, we should be able to solve such seldom
conflicts on IRC. :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
