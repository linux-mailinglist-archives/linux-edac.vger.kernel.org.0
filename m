Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D24D68DF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfJNRxb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 13:53:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbfJNRxb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 13:53:31 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6901D1EC0C81;
        Mon, 14 Oct 2019 19:53:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571075609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FRnrE36V97yr2XOoiWhH71sP1a5VryRZPc2CnW5w4ps=;
        b=PwG15lssyWuknhNOgr5mQ89PPSlPUlWHTsdSVJA3ATJGrU3rEkyasLCnAQjx9ivE5Kg1WZ
        xdQ5KGFyM6pmCyYqa0Zq/cm+V4Vw4wadZmJfs4a4RUjgNfl8ly5p3fi7fhKbIzG0AM8Bdg
        lgaDGcsVGendS0gHLwAr+oO8TtEPhns=
Date:   Mon, 14 Oct 2019 19:53:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Message-ID: <20191014175319.GH4715@zn.tnic>
References: <20191014171919.85044-1-james.morse@arm.com>
 <20191014173006.GG4715@zn.tnic>
 <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86ba3fcf-d29c-1d6a-d8c3-2a03cb11263e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 06:40:33PM +0100, James Morse wrote:
> Keeping both avoids the !pvt check in ghes_edac_report_mem_error() going wrong, but I'm
> not entirely sure what that is trying to stop...

It must've been some sanity-check in

  f04c62a7036a ("ghes_edac: add support for reporting errors via EDAC")

> The possibility of races between notifications and unregister only occurred to me after
> testing the first patch, so they ended up as different things in my head: I thought it
> deserved its own commit log as its unrelated to the KASAN splat.

To me they fix two different aspects of the missing counting on unreg.

> I think you need some kind of reference count to know how many more GHES.x there are out
> there that may call unregister, otherwise you race with notifications.

Provided unregister cannot be called concurrently, the

        if (!ghes_pvt)
                return;

in ghes_edac_unregister() should suffice.

But just to be on the safe side, it could get an "instance_mutex" or so
under which ghes_pvt is set and cleared and then that silly counter can
simply go away.

Thoughts?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
