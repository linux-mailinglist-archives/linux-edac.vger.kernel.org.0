Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47E8D818
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2019 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHNQbB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Aug 2019 12:31:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHNQbB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 14 Aug 2019 12:31:01 -0400
Received: from zn.tnic (p200300EC2F0BD0003850D0C8BF1AA1C5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d000:3850:d0c8:bf1a:a1c5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 600C51EC04CD;
        Wed, 14 Aug 2019 18:31:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565800260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eB1BWExwcjZBat8Wci9JoVASBBkAEbKz+GapUWhzDWw=;
        b=jVIxMAQp71DBbR5Pfi1GuNqgLnaAb9UNAD2xOeAVmCEuroB7iUuKN8sGebECvyvIzAH5BX
        c/8FLuyXddixH4Zvl0mjdLC2lALGW+qWPCVYRaYkF9dVI++Oy3SZfcMOU/lvOvGXAXZLbx
        HsHpD9FmXKg5NNOk6AWFVdOcoCZKfMM=
Date:   Wed, 14 Aug 2019 18:31:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/24] EDAC, mc: Cleanup _edac_mc_free() code
Message-ID: <20190814163146.GC1841@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-10-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-10-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:13PM +0000, Robert Richter wrote:
> Remove needless and boilerplate variable declarations. No functional
> changes.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

This can go in now because unrelated cleanup.

Applied,
thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
