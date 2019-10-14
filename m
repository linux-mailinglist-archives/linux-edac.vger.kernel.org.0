Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C60D6879
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2019 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfJNRaP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 13:30:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbfJNRaP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 13:30:15 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCF651EC0C81;
        Mon, 14 Oct 2019 19:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571074213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YXsfaSEH0CXXYfsg24af+D+9Nkrz5SI2FklFgqBg6nI=;
        b=CpG5dgqJ7UNwi+a+TGHRqbHAlaN/ZBESm7Fudu+wwuXk5u/VZ/9mAQQTsnf07+Rx56ITcN
        oycd8aOVa3jDo6T0WMZVnO7g9C61UiRoH6HBwKeVFuZxGXfVqVoPGA9aremi7gvHH9zE7w
        HQPYuGazFYZV2JyGuL4e/89EXg9Gr/s=
Date:   Mon, 14 Oct 2019 19:30:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] EDAC, ghes: Fix use after free and add reference
Message-ID: <20191014173006.GG4715@zn.tnic>
References: <20191014171919.85044-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191014171919.85044-1-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 06:19:17PM +0100, James Morse wrote:
> ghes_edac can only be registered once, later attempts will silently
> do nothing as the driver is already setup. The unregister path also
> only expects to be called once, but doesn't check.
> 
> This leads to KASAN splats if multiple GHES entries are unregistered,
> as the free()d memory is dereferenced, and if we're lucky, free()d
> a second time.
> 
> Link: lore.kernel.org/r/304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com
> 
> Patch 1 is the minimum needed to prevent the dereference and double
> free, but this does expose the lack of symmetry. If we unregister
> one GHES entry, subsequent notifications will be lost.
> Unregistering is unsafe if another CPU is using the free()d memory in
> ghes_edac_report_mem_error().
> 
> To fix this, Patch 2 uses ghes_init as a reference count.
> 
> We can now unbind all the GHES entries, causing ghes_edac to be
> unregistered, and start rebinding them again.
> 
> 
> Thanks,
> 
> James Morse (2):
>   EDAC, ghes: Fix Use after free in ghes_edac remove path
>   EDAC, ghes: Reference count GHES users of ghes_edac

Thanks for debugging and fixing this but why two patches?

One is perfectly fine IMO. Or?

Btw, I admit that the ghes_init thing is ugly as hell. ;-\

I wonder if it could be ripped out completely and we use only ghes_pvt
for controlling the single driver instance loading and unloading...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
