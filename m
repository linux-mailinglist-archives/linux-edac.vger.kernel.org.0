Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F78C1A2F3
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfEJSZN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 14:25:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfEJSZN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 May 2019 14:25:13 -0400
Received: from zn.tnic (p200300EC2F0F4000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 753011EC0AB0;
        Fri, 10 May 2019 20:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557512712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wbJqN8BDou+FYSJ+nPq4MO6fRTRxmjFCtFcdN3ttYwM=;
        b=YsCbwMORzUVovHKrA9SYFUFxy1jzmMWZVQ6LbCmuKBYwyNcMWhKkBo9VdLFTMB95epYwC7
        vgBrSs9JVHyMRZiWEueTAkxxcxl6j7L1XI10fYkqI637Z1DBInIeG+H0zgLTT1QPMbVfGO
        BtQVFrbVBo3RdkOXQZuXozTYqnYBOrE=
Date:   Fri, 10 May 2019 20:25:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
Message-ID: <20190510182512.GG29927@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250>
 <20190508101238.GB19015@zn.tnic>
 <87o94bvfxm.fsf@concordia.ellerman.id.au>
 <20190509145534.GD17053@zn.tnic>
 <20190509180220.GH17053@zn.tnic>
 <87bm0avb03.fsf@concordia.ellerman.id.au>
 <20190510141320.GB29927@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510141320.GB29927@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 10, 2019 at 04:13:20PM +0200, Borislav Petkov wrote:
> On Fri, May 10, 2019 at 08:50:52PM +1000, Michael Ellerman wrote:
> > Yeah that looks better to me. I didn't think about the case where EDAC
> > core is modular.
> > 
> > Do you want me to send a new patch?
> 
> Nah, I'll fix it up.

I've pushed it here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=edac-fix-for-5.2

in case you wanna throw your build tests on it. My dingy cross-compiler
can't do much really.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
