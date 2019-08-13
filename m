Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE48B203
	for <lists+linux-edac@lfdr.de>; Tue, 13 Aug 2019 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfHMIJK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Aug 2019 04:09:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49706 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfHMIJJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Aug 2019 04:09:09 -0400
Received: from zn.tnic (p200300EC2F0D240075AA4C13F769B7E7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:75aa:4c13:f769:b7e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 83D2F1EC0716;
        Tue, 13 Aug 2019 10:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565683748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TvZfKXBWT9Z9g902906G7WIPUY9iKv6XjXyYLjYmEBc=;
        b=Hjlrm8LHktrNd92h9p56qukqrVGVOUmod6fAuuDp//GAFXYEeqeorH2Al/euKE4Sc5h8W3
        uTOpVGdpGveXaAhq7RIaWFMlcBV0IuuXRGE2t3d/4RQzxs4DnzmJH0JYMp/bVpM8Y3jnFv
        Tuz6B1EcaIpFK9fI8EnNCZajiGikD14=
Date:   Tue, 13 Aug 2019 10:09:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] EDAC, ghes: Remove pvt->detail_location string
Message-ID: <20190813080958.GC16770@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-4-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-4-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:08:59PM +0000, Robert Richter wrote:
> The detail_location[] string in struct ghes_edac_pvt is complete

s/complete/completely/

> useless and data is just copied around. Put everything into
> e->other_detail from the beginning.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
