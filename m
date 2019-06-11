Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037A83D40F
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405960AbfFKR2g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 13:28:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405786AbfFKR2g (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 13:28:36 -0400
Received: from zn.tnic (p200300EC2F0A6800C91F6799EDF090E8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:c91f:6799:edf0:90e8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 16E6A1EC0467;
        Tue, 11 Jun 2019 19:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560274115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JHsL/2yRGNcuM0XgJZbs2DYkjnFPBd4EyIzkvA+Etl4=;
        b=et0qxBvOaNc/WQ8z/JDCOwW8xWD3nv96heNnSEsEtSs4xw4YNXdeiF/K8q7pHsfZ65TRDQ
        vjO/hunutbIc6ZDYkepwTVe0PkQ0qfXBdVg8hVuCnwlVO0eqjrDokCthOojfbouF2Dz5z2
        dw0RlbZ7LYeGyJj+2YO+BQEH62W6V9w=
Date:   Tue, 11 Jun 2019 19:28:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/21] EDAC: Fixes to use put_device() after device_add()
 errors
Message-ID: <20190611172830.GI31772@zn.tnic>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-3-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529084344.28562-3-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 29, 2019 at 08:44:05AM +0000, Robert Richter wrote:
> Always use put_device() after device_add() failed.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc_sysfs.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)

I already have a partial fix for that, you can send me the rest ontop:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=for-next&id=f5d59da9663d115b9cf62cce75a33382c880b560

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
