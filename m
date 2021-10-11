Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF30E429685
	for <lists+linux-edac@lfdr.de>; Mon, 11 Oct 2021 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhJKSLA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Oct 2021 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhJKSLA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Oct 2021 14:11:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C1C061570;
        Mon, 11 Oct 2021 11:08:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08bb00e407f16cd758a723.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:e407:f16c:d758:a723])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E53851EC04D6;
        Mon, 11 Oct 2021 20:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633975738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r0kZGPlvqD8Ym4KA5IHYNF5ItwydbZ8+Y5IjOGkLXcM=;
        b=byMlsNWbB3Boi279ZBQfNz/XSHgRFaNtsJw51Rx11TcsXfMUGqH0RrWXJLmu6/it0QGd61
        x5NBgJo3mMGScUN4Jsfoq8Ss8i2oIiskfs3dUgXRNG4j8OsilYOIyBr72MzQ/AjGLTdzbk
        1RuT+2KkWf+otqB0QYeCKUojx08iR74=
Date:   Mon, 11 Oct 2021 20:08:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Yazen.Ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YWR9tte90QR15BRH@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-2-nchatrad@amd.com>
 <YSYeo6S2OSZbBpb4@zn.tnic>
 <dcc7c537-0370-d190-9ca7-ce60fa29d68c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcc7c537-0370-d190-9ca7-ce60fa29d68c@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 11, 2021 at 07:56:34PM +0530, Chatradhi, Naveen Krishna wrote:
> Aldebaran is an AMD GPU name, code submitted [PATCH 000/159] Aldebaran
> support (lists.freedesktop.org)
> <https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html>
> is a part of the DRM framework

A short explanation in your patchset would be very helpful so that a
reader can know what it is and search the net further, if more info is
needed.

> Aldebaran GPU might be a later variant of gfx9 and are connected to the CPU
> sockets via custom xGMI links.
> 
> I could not find any family number associated with the GPUs. The DRM driver
> code uses it as follows and
> 
> does not expose the value to other frameworks in Linux.
> 
> +#define CHIP_ALDEBARAN 25
> 
> in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm

Aha, so Aldebaran is the chip name. And how are those PCI IDs named in
the documentation? Aldebaran data fabric PCI functions or so?

> The roots_per_misc count is different for the CPU nodes and GPU nodes. We
> tried to address
> 
> your comment without introducing pci_dev_id arrays for GPU roots, misc and
> links. But, introducing
> 
> GPU ID arrays looks cleaner, let me submit the revised code and we can
> revisit this point.

Ok, but as I said above, what those devices are, means nothing to the
amd_nb code because that simply enumerates PCI IDs when those things
were simply northbridges.

If the GPU PCI IDs do not fit easily into the scheme then maybe the
scheme has become inadeqate... we'll see...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
