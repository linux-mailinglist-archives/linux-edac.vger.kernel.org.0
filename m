Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78843849
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbfFMPEy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 11:04:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732464AbfFMORT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 10:17:19 -0400
Received: from zn.tnic (p200300EC2F06D500349353021D4CE514.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d500:3493:5302:1d4c:e514])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B7251EC0235;
        Thu, 13 Jun 2019 16:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560435438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mm3XxwESAph1yISTiwQTaeINydDZWYAofTkk9QcLO78=;
        b=aGzm61LUpNyURNpdinzoqQoqVmbeK2F0sbWSlFVSKj84jBS6xboqS6Ry3YjSZiK6rkhKb6
        iC0AUwW1KvTejSf1iJmh1dxFKQcd7q2yo5Bq2/ZHkrY8mR578CdNQR4n+xOjU5iXZR96fM
        +2mQ1cWqyNXs/G32ppq9G/YjwkSt76s=
Date:   Thu, 13 Jun 2019 16:17:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Message-ID: <20190613141715.GD11598@zn.tnic>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190531234501.32826-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 31, 2019 at 11:45:12PM +0000, Ghannam, Yazen wrote:
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 9fa2f205f05c..dd60cf5a3d96 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -943,91 +943,101 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>  		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
>  		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
>  	} else if (pvt->fam >= 0x17) {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> +		int umc;
> +
> +		for_each_umc(umc) {
> +			pvt->csels[umc].b_cnt = 4;
> +			pvt->csels[umc].m_cnt = 2;
> +		}
> +

What is the purpose of the previous commit if you're changing it here in
the next one?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
