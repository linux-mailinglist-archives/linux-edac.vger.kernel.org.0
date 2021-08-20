Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC53F2C0D
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 14:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhHTM2u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 08:28:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234564AbhHTM2u (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 08:28:50 -0400
Received: from zn.tnic (p200300ec2f107b00008ff220e59d9b99.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:8f:f220:e59d:9b99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5B151EC0246;
        Fri, 20 Aug 2021 14:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629462487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=laUj2sSr+v6xXMrCF2u5SlBS0ZZzRYETUmrem4xszY4=;
        b=GBO8pTvAHd53n0rwNr5KdbXcnRERqRc+6sIA7jTTruA3OGUMcEjZEXlnpxv9ol27Sfbz4t
        m/qfrlS2zR1k1NmM+YMdj52FAzYEAVI6D4863/3GPRFGcZfQ641yPRAMXmKk6rMsLktphq
        LNx++OI5s2uPY3gxnhUJg0WfaBBIRYY=
Date:   Fri, 20 Aug 2021 14:28:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: Re: [PATCH] x86/mce/dev-mcelog: Call mce_register_decode_chain()
 much earlier
Message-ID: <YR+f/fdGIxWcLTP2@zn.tnic>
References: <20210819224452.1619400-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210819224452.1619400-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 19, 2021 at 03:44:52PM -0700, Tony Luck wrote:
> which made sure that the logs were not lost completely by printing
> to the console. But parsing console logs is error prone. Users
> of /dev/mcelog should expect to find any early errors logged to
> standard places.

Yes, and for that matter, *all* consumers which register on the decoding
chain should get a chance to look at those records...

> Split the initialization code in dev-mcelog.c into:
> 1) an "early" part that registers for mce notifications. Call this
> directly from mcheck_init() because early_initcall() is still too late.
> This allocation is too early for kzalloc() so use memblock_alloc().
> 2) "late" part that registers the /dev/mcelog character device.

... but this looks like a hack to me: why aren't we adding those early
records to the gen_pool and kick the work to consume them *only* *after*
all consumers have been registered properly and everything is up and
running?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
