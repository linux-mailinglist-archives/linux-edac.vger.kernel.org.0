Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892C8A89BB
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2019 21:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfIDPx3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 11:53:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52012 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731465AbfIDPx2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Sep 2019 11:53:28 -0400
Received: from zn.tnic (p200300EC2F0A23007420D76C17796BA0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2300:7420:d76c:1779:6ba0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8378B1EC0528;
        Wed,  4 Sep 2019 17:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567612407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1wN5rIWmEF3eBwLzPPZZZ+UrG/kIZXE/7pS5w/Sbemo=;
        b=TSEn5/o59iL21J1EnNRh8ctW7FwHQz8R4nABE+qcd4Yd60cfnI6jnoMVP4Kj9JpGWhx7EP
        98DH5FqOzDTOizMdJXHqkJ8rGGonvq932AQ5l9cuNqKQgBc0+SXfuUj0z6kdoQ+RMFV9J9
        VqrsNz4JqfnlvnZ4WGwRM1z5+QZ+cV8=
Date:   Wed, 4 Sep 2019 17:53:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] EDAC: Small cleanups and fixes
Message-ID: <20190904155321.GA31961@zn.tnic>
References: <20190902123216.9809-1-rrichter@marvell.com>
 <20190902171716.50c226d6@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190902171716.50c226d6@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 02, 2019 at 05:17:16PM -0300, Mauro Carvalho Chehab wrote:
> > Robert Richter (5):
> >   EDAC: Prefer 'unsigned int' to bare use of 'unsigned'
> >   EDAC, mc_sysfs: Change dev_ch_attribute->channel to unsigned int
> >   EDAC, mc_sysfs: Remove pointless gotos
> >   EDAC, mc_sysfs: Make debug messages consistent
> >   MAINTAINERS: update EDAC's reviewer entry
> 
> For the entire series:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> > 
> >  MAINTAINERS                  |  1 +
> >  drivers/edac/edac_mc.c       | 20 ++++----
> >  drivers/edac/edac_mc.h       |  6 +--
> >  drivers/edac/edac_mc_sysfs.c | 91 ++++++++++++++++--------------------
> >  drivers/edac/ghes_edac.c     |  2 +-
> >  drivers/edac/i5100_edac.c    | 16 ++++---
> >  include/linux/edac.h         | 10 ++--
> >  7 files changed, 69 insertions(+), 77 deletions(-)

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
