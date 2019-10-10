Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B8D2B96
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388165AbfJJNlj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 09:41:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733228AbfJJNlj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 10 Oct 2019 09:41:39 -0400
Received: from zn.tnic (p200300EC2F0A630049CEEE8F373FE59E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:49ce:ee8f:373f:e59e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32D7B1EC0391;
        Thu, 10 Oct 2019 15:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570714898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iG8IuNXynO8vItVbElLmRDDO00r9i+9u7IdxbTcOn/Q=;
        b=c/ckwYqEhTq2pSRZQgDcehyZdFKIJDsMTyOFYzUvJgqxXL3OpROPbaQt+IKU87mSespYpT
        upVaI34R1qU2Nxj0XlbMxjHPejHdn/pKv2vD7wtHO9IsFwJGjKG3+WKJ5cqTU/pUY/6B1q
        3bJ+LbIArneVVzCdc/wtfZz1J6zB/j8=
Date:   Thu, 10 Oct 2019 15:41:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jean-Frederic <jfgaudreault@gmail.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Message-ID: <20191010134128.GF7658@zn.tnic>
References: <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
 <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
 <CAEVokG4SSkgWS2N8eqr+h7AJg9CF26OW7vtXwOurCGU-4dsLbw@mail.gmail.com>
 <20191009103041.GC10395@zn.tnic>
 <724d6f97-61f2-94bd-3f4b-793a55b6ac15@amd.com>
 <CAEVokG4T5q8PBmf4=vLjPWQjzL_Xwu6yF81=mLjkpoJSoCggkw@mail.gmail.com>
 <20191010095650.GC7658@zn.tnic>
 <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f3ce002-7380-0e93-7bd5-20bb944d0b77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 10, 2019 at 08:48:20AM -0400, Jean-Frederic wrote:
> I did recheck all menus in advanced mode several times. I used my bios
> fairly often when I got this new system, I would also have seen it
> before I would think.

I have the faint suspicion that our perfectly capable BIOS writers
forgot to add a disable functionality. Let's see what Yazen finds out
first, though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
