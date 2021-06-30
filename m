Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BA3B87C5
	for <lists+linux-edac@lfdr.de>; Wed, 30 Jun 2021 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhF3RgN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Jun 2021 13:36:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3RgN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Jun 2021 13:36:13 -0400
Received: from zn.tnic (p200300ec2f12c300d32a22941298d01c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:c300:d32a:2294:1298:d01c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A6701EC046E;
        Wed, 30 Jun 2021 19:33:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1625074423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w9TPmtT989Bxa/BMOi3EyRqngWlUdV8lm8j+1Polio4=;
        b=CayhQfR68oLp4Y61HzHpO1OgsicFzsWsE1YRpgwB6mhTxz1ULt47BxMtqyfhcSDcUiGr4s
        vqwHRaLUr60Ac9qTat7TEuu74EestJJ8W59Adabn0vD5WwjhqSI1GckQmGKfImmvGH0RB1
        xayVo5KSc16AKKlXf2efHLjNQ17mTU0=
Date:   Wed, 30 Jun 2021 19:33:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 09/31] EDAC/amd64: Define function to find
 interleaving mode
Message-ID: <YNyq95hXKcbM4+Kk@zn.tnic>
References: <20210623192002.3671647-1-yazen.ghannam@amd.com>
 <20210623192002.3671647-10-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623192002.3671647-10-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 23, 2021 at 07:19:40PM +0000, Yazen Ghannam wrote:
> @@ -1088,10 +1096,12 @@ struct addr_ctx {
>  	u16 nid;
>  	u8 inst_id;
>  	u8 map_num;
> +	bool hash_enabled;

For such single bits info you can use bitfields, like struct mca_config
does it, for example.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
