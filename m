Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8CD2DB427
	for <lists+linux-edac@lfdr.de>; Tue, 15 Dec 2020 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgLOS7D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Dec 2020 13:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730744AbgLOS6z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Dec 2020 13:58:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690BDC06179C;
        Tue, 15 Dec 2020 10:58:15 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f9e009c14e1abc4cc14de.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:9e00:9c14:e1ab:c4cc:14de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0CE71EC04DF;
        Tue, 15 Dec 2020 19:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608058693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BZwPR5IScj0YRL8ObZ/33FAKWJRNV1DEIVj6adoM+1Y=;
        b=e0mhnX0mZE69wKAOLYDmzK0yX0J1vlqODsFRR7/se6as9cOnrzOsp+wggjsC8GNeieMX+q
        Joj8GPTFScVXb0n2scjgpJt5S+EcSsMaB5OF5cEk+izW04AcJJL5NBcs2XRAtifmL208Eo
        fv6VvkWHAN0g/EJz9I0i9lNkCZonw1Q=
Date:   Tue, 15 Dec 2020 19:58:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] EDAC/amd64: Merge error injection sysfs facilities
Message-ID: <20201215185808.GE9817@zn.tnic>
References: <20201215110517.5215-1-bp@alien8.de>
 <20201215110517.5215-2-bp@alien8.de>
 <20201215161120.GB2122783@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215161120.GB2122783@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 15, 2020 at 10:11:20AM -0600, Yazen Ghannam wrote:
> Can we say "Opterons (Family 10h to Family 15h)"? It may also apply to
> Family 16h, but I don't know if they were branded as Opterons.
> 
> The injection code in this module doesn't apply to Family 17h and later.
> 
> Also, Family 17h and later doesn't allow the OS direct access to the error
> injection registers. They're locked down by security policy, etc.

Yeah, figured as much after I started getting all 0s while poking at
them with setpci...

Ok, I'll fix that ontop - this patch should be only code movement and
trivial cleanups, functionality changes ontop.

> Related to the comment above, can this be changed to the following?
> 
> 	if (pvt->fam < 0x10 || pvt->fam >= 0x17)

Right.

> Everything else looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
