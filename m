Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32509448051
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 14:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhKHNhN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 08:37:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42682 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235700AbhKHNhM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Nov 2021 08:37:12 -0500
Received: from zn.tnic (p200300ec2f33110093973d8dfcf40fd9.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:9397:3d8d:fcf4:fd9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A5A81EC0295;
        Mon,  8 Nov 2021 14:34:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636378467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HBnFYHXgIpN0783puQdmV5sl9beAJsY+GC35ZNWPXY=;
        b=dJL8vhiYLN68ncpoxkrQpS0yxfjmpGIw8qAiZe6JPUg0vz9wAV6Y9iKGjEnJD0/Caf1fJl
        b49lZM4iOt6Qk47E139tW7sWxEVrKPBTLlis3IM/Sy6N8xQnn2+v2koOFBzvkg7X7MM/wx
        xzq+8L+o8M8gCDFEUxr4BNH68LTK8Lc=
Date:   Mon, 8 Nov 2021 14:34:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YYknXBpOUQtV1aZ8@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com>
 <YYF9ei59G/OUyZqR@zn.tnic>
 <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 04, 2021 at 06:48:29PM +0530, Chatradhi, Naveen Krishna wrote:
> I know, this is confusion. we will try to give a meaning for definition
> here.

Well, not that - you will need to keep adding PCI device IDs for the
future GPUs supporting this stuff.

> How about, defining a new struct
> 
> +struct system_topology {
> +       const struct pci_device_id *misc_ids;
> +       const struct pci_device_id *link_ids;
> +       const struct pci_device_id *root_ids;
> +       u16 roots_per_misc;
> +       u16 misc_count;
> +       u16 root_count;
> +};

Well, how does having a single struct help make things easier?

IOW, if you use accessors to get the information you need, it doesn't
really matter what the underlying organization of the data is. And if
it helps to keep 'em separate because stuff is simple altogether, then,
they should be separate.

So, before you ask "How about", think of answering the question "Why
should it be done this way? What are the advantages?"

> This way, creating appropriate number MCs under EDAC and existing exported
> APIs can remain the same.

Why does that matter?

Also, have you verified in what order the init_amd_nbs() fs initcall and
amd64_edac_init() get executed?

I'm going to venture a pretty sure guess that the initcall runs first
and that amd_cache_northbridges() call in amd64_edac_init() is probably
not even needed anymore...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
