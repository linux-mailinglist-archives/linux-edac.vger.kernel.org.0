Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7718FD2
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2019 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEISCa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 May 2019 14:02:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfEISCa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 May 2019 14:02:30 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 008451EC0AD6;
        Thu,  9 May 2019 20:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557424948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LE6rba9B9rU5DbzSHGx/pRi6Lf56AIjnr35aFsMIzx0=;
        b=a8RjWUcVSKawUH6Wjde6La9FXxCtzDNi3YnI+OMK2XcixlBnhA6XEtKqKRhEM0al/llKME
        bU1tU9ahok52xcoqbLYM5JT5mMOMtQEGXfj8qxXlWRAQHBd+V4bCdzy6S6SHtnJ7Y3YFC3
        CGtCAvs1EMUnHirHSl1tVM9zkj/XSgY=
Date:   Thu, 9 May 2019 20:02:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org, mchehab@kernel.org,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] EDAC, mpc85xx: Prevent building as a module
Message-ID: <20190509180220.GH17053@zn.tnic>
References: <20190502141941.12927-1-mpe@ellerman.id.au>
 <20190506065045.GA3901@x250>
 <20190508101238.GB19015@zn.tnic>
 <87o94bvfxm.fsf@concordia.ellerman.id.au>
 <20190509145534.GD17053@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509145534.GD17053@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 09, 2019 at 04:55:34PM +0200, Borislav Petkov wrote:
> On Fri, May 10, 2019 at 12:52:05AM +1000, Michael Ellerman wrote:
> > Thanks. It would be nice if you could send it as a fix for 5.2, it's the
> > last thing blocking one of my allmodconfig builds. But if you don't
> > think it qualifies as a fix that's fine too, it can wait.
> 
> Sure, no problem. Will do a pull request later.

Hmm, so looking at this more, I was able to produce this config with my
ancient cross-compiler:

CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_MPC85XX=y

Now, mpc85xx_edac is built-in and edac_core.ko is a module
(CONFIG_EDAC=m) and that should not work - i.e., builtin code calling
module functions. But my cross-compiler is happily building this without
complaint. Or maybe I'm missing something.

In any case, I *think* the proper fix should be to do:

config EDAC_MPC85XX
        bool "Freescale MPC83xx / MPC85xx"
        depends on FSL_SOC && EDAC=y

so that you can't even produce the above invalid .config snippet.

Hmmm?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
