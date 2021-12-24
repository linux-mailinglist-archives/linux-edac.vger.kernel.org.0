Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D6947EE30
	for <lists+linux-edac@lfdr.de>; Fri, 24 Dec 2021 11:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbhLXKQC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 24 Dec 2021 05:16:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54600 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343878AbhLXKQC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 24 Dec 2021 05:16:02 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0FD51EC050F;
        Fri, 24 Dec 2021 11:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640340957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cQySeusf+rJBnK/bdhdyE8GlziROJmD+hhacXui0Y/A=;
        b=VdW3NnHUhkvEsoKp3AurgLFWjYIeQ1M5EUJdu/FNxwAltxVKf4Rozzc03z4pBjbnHsh+DE
        hyWeHcqpQqqVx6C4UX7dNlNuPkl7m9eJETyERe/MIKVQ4zyDf6s7i0mN0BAKPyNkpH3Ly8
        G0aGb19hQALWhc4SkgYWlvRF9uOJodU=
Date:   Fri, 24 Dec 2021 11:15:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Marc Bevand <m@zorinaq.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/amd64: Add PCI device IDs for family 19h model
 50h
Message-ID: <YcWd3hIJp7QY5igi@zn.tnic>
References: <YcIk4XJaBZs/aihF@yaz-ubuntu>
 <20211221233112.556927-1-m@zorinaq.com>
 <YcTWNfPSadyeHn7V@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcTWNfPSadyeHn7V@yaz-ubuntu>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 23, 2021 at 08:04:05PM +0000, Yazen Ghannam wrote:
> On Tue, Dec 21, 2021 at 03:31:12PM -0800, Marc Bevand wrote:
> > Add the new family 19h model 50h PCI IDs (device 18h functions 0 and 6)
> > to support Ryzen 5000 APUs ("Cezanne").
> > 
> > Signed-off-by: Marc Bevand <m@zorinaq.com>
> > ---
> > V1 -> V2: rebase on latest ras.git, apply to models 0x50-0x5f
> > 
> > Hi Yazen, I addressed your comments in v2 of this patch, included below.
> > Cheers, 
> > Marc.
> >
> 
> Thanks Marc. It looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
