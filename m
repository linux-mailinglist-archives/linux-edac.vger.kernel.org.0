Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D73848A
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 08:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfFGGnJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 02:43:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49856 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFGGnJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 02:43:09 -0400
Received: from zn.tnic (p200300EC2F066300E4B954D67B383BA9.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6300:e4b9:54d6:7b38:3ba9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10C431EC0997;
        Fri,  7 Jun 2019 08:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559889788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FIRsXlvkn4IbYLUoughk3PTq9Sf/ybYYaQGniFuSkhg=;
        b=BDiMYDHUa1WuQ+ZlX/VirkDu50nNmmSm5oWa9kzkeBU7yzlC0ReYRpi47fbdpROKtRrhWj
        OSY+rtkp4Lj+uRbA0zXNxeG2sAiGh9VARRiw9WO9dzn3dweSgrkx6qxWER4qhq4MTQq1Aj
        jEGoJkXUbh0InhEIkz5cOH9vTBrkJsc=
Date:   Fri, 7 Jun 2019 08:43:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>, Yash Shah <yash.shah@sifive.com>
Cc:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Subject: Re: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
Message-ID: <20190607064300.GB20269@zn.tnic>
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com>
 <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
 <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com>
 <20190521182132.GB7793@cz.tnic>
 <1c7eb8ab-6f48-c41a-1d3a-a9b0f5ce8a7f@arm.com>
 <ABA6726C-CC1D-4092-887E-7D5A5B90509B@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ABA6726C-CC1D-4092-887E-7D5A5B90509B@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 22, 2019 at 04:34:38AM -0500, Boris Petkov wrote:
> >Still fine by me:
> >Reviewed-by: James Morse <james.morse@arm.com>
> >
> >(...this patch already has my reviewed-by on it...)
> >
> >I commented that it couldn't be merged in pieces here:
> >https://lore.kernel.org/lkml/4072c812-d3bf-9ad5-2b30-6b2a5060bb55@arm.com/T/#u
> >
> >which is what Yash is replying to.
> 
> Ok, I'll take it when I get back. Thanks for clarifying.

Now queued.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
