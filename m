Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD219BF0
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfEJKuz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:50:55 -0400
Received: from ozlabs.org ([203.11.71.1]:35787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfEJKuz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 May 2019 06:50:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450n7J1Wj0z9s4V;
        Fri, 10 May 2019 20:50:51 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
In-Reply-To: <20190509180220.GH17053@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au> <20190506065045.GA3901@x250> <20190508101238.GB19015@zn.tnic> <87o94bvfxm.fsf@concordia.ellerman.id.au> <20190509145534.GD17053@zn.tnic> <20190509180220.GH17053@zn.tnic>
Date:   Fri, 10 May 2019 20:50:52 +1000
Message-ID: <87bm0avb03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Thu, May 09, 2019 at 04:55:34PM +0200, Borislav Petkov wrote:
>> On Fri, May 10, 2019 at 12:52:05AM +1000, Michael Ellerman wrote:
>> > Thanks. It would be nice if you could send it as a fix for 5.2, it's the
>> > last thing blocking one of my allmodconfig builds. But if you don't
>> > think it qualifies as a fix that's fine too, it can wait.
>> 
>> Sure, no problem. Will do a pull request later.
>
> Hmm, so looking at this more, I was able to produce this config with my
> ancient cross-compiler:
>
> CONFIG_EDAC_SUPPORT=y
> CONFIG_EDAC=m
> CONFIG_EDAC_LEGACY_SYSFS=y
> CONFIG_EDAC_MPC85XX=y

Oh yeah good point.

> Now, mpc85xx_edac is built-in and edac_core.ko is a module
> (CONFIG_EDAC=m) and that should not work - i.e., builtin code calling
> module functions. But my cross-compiler is happily building this without
> complaint. Or maybe I'm missing something.

That's weird.

> In any case, I *think* the proper fix should be to do:
>
> config EDAC_MPC85XX
>         bool "Freescale MPC83xx / MPC85xx"
>         depends on FSL_SOC && EDAC=y
>
> so that you can't even produce the above invalid .config snippet.
>
> Hmmm?

Yeah that looks better to me. I didn't think about the case where EDAC
core is modular.

Do you want me to send a new patch?

cheers
