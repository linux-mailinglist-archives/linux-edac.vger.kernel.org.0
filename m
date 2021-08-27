Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9C3F981C
	for <lists+linux-edac@lfdr.de>; Fri, 27 Aug 2021 12:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbhH0KYq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Aug 2021 06:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244724AbhH0KYq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Aug 2021 06:24:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA261C061757;
        Fri, 27 Aug 2021 03:23:57 -0700 (PDT)
Received: from zn.tnic (p200300ec2f111700905bee0280016357.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:905b:ee02:8001:6357])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B1081EC0453;
        Fri, 27 Aug 2021 12:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630059832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ERetRLR05o0HloXkki1sLii2QLYDsQTiY2jD6cD50b8=;
        b=LlnsrL3U8HzSLDx2vhPyXWNMqqsTyKukwd8PDDanRJEcFWFnwO1PBVaocanZE2sYKFVLve
        6LmVHMFUF1i44adflROL5UHtIxqc6Qu08+8CXOgpdjQSOk5R3dVg6H7etFyFCCr/tSMbW4
        dir3dfwyZwjwakVsbyoM4VOOrCpmhkQ=
Date:   Fri, 27 Aug 2021 12:24:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Yazen.Ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 2/3] EDAC/mce_amd: Extract node id from MCA_IPID
Message-ID: <YSi9Xbm6K/VuMv/Z@zn.tnic>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-3-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823185437.94417-3-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 24, 2021 at 12:24:36AM +0530, Naveen Krishna Chatradhi wrote:
> On SMCA banks of the NONCPU nodes, the node id information is
> available in MCA_IPID[47:44](InstanceIdHi).
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Changes since v2:
> 1. Modified subject and commit message
> 2. Added Reviewed by Yazen Ghannam
> 
>  drivers/edac/mce_amd.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 27d56920b469..1398032ba25a 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -1072,8 +1072,23 @@ static void decode_smca_error(struct mce *m)
>  	if (xec < smca_mce_descs[bank_type].num_descs)
>  		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
>  
> -	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
> -		decode_dram_ecc(topology_die_id(m->extcpu), m);
> +	if (xec == 0 && decode_dram_ecc) {
> +		int node_id = 0;
> +
> +		if (bank_type == SMCA_UMC) {
> +			node_id = topology_die_id(m->extcpu);
> +		} else if (bank_type == SMCA_UMC_V2) {
> +			/*
> +			 * SMCA_UMC_V2 is used on the noncpu nodes, extract

Above "NONCPU", here "noncpu", I don't like that "noncpu" nomenclature.
I wonder if we can do without it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
