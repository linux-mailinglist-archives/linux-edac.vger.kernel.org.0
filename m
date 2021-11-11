Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFD44D6B7
	for <lists+linux-edac@lfdr.de>; Thu, 11 Nov 2021 13:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKKMmd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Nov 2021 07:42:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50642 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhKKMmd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Nov 2021 07:42:33 -0500
Received: from zn.tnic (p200300ec2f0fc200bb2554a44f8eb9ed.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:c200:bb25:54a4:4f8e:b9ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CE1F1EC0532;
        Thu, 11 Nov 2021 13:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636634383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pudPfA/TcO8YJorHN3KVppXQPK26ggKvCxR2WK1znys=;
        b=HUAKOUVVLAv4WBJdGohH5WkjVM5Qn/W1tlHtUCSGDBLIWeDQxhlpLatWdx/MVM32l0PVHk
        oJtc7Gd0jggSqkOYvvseFtLX28VibICefe8q2w53+JQzo8ScpczOsdpYptevMIGQqmvFAR
        lSk4F0C6dbQelvsWrWupcU2nrNDWaFM=
Date:   Thu, 11 Nov 2021 13:39:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 4/5] EDAC/amd64: Move struct fam_type into amd64_pvt
 structure
Message-ID: <YY0PDMUjcbrfY9EB@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-5-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028130106.15701-5-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 28, 2021 at 06:31:05PM +0530, Naveen Krishna Chatradhi wrote:
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 881ff6322bc9..82d9f64aa150 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -389,6 +389,8 @@ struct amd64_pvt {
>  	enum mem_type dram_type;
>  
>  	struct amd64_umc *umc;	/* UMC registers */
> +
> +	struct amd64_family_type *fam_type;

With my suggestion to the previous patch to assign ops and per-family
members dynamically, you can just as well get rid of struct
amd64_family_type and put its members directly in the pvt structure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
