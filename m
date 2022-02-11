Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3264B2D79
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352822AbiBKTX0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 14:23:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiBKTXY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 14:23:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9ECEE
        for <linux-edac@vger.kernel.org>; Fri, 11 Feb 2022 11:23:22 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81A991EC03E3;
        Fri, 11 Feb 2022 20:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644607391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oR/oiP2+65T59bcpRG/IiQefT+dXNy/7dsGfjaAi0GI=;
        b=GKGFboMf/wBRjfxFpYTqOyZBtfEICQqIy5As/LsZiwBlHRi5cAtkoMW5NKWyzYsWwRP1M1
        ne0XxG0fO3brwcM7hTuIRJTbvxgt+IPPqu20qmTDSZvDtFt/GG0HZ+qBTBzjG7om+nlV4J
        W1qCH6lDn6Q/mPiOLq4Wl/1c/H4UgH0=
Date:   Fri, 11 Feb 2022 20:23:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 02/24] EDAC/amd64: Define functions for DramOffset
Message-ID: <Yga3oWKqg7TK6lWZ@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-3-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:40:53PM +0000, Yazen Ghannam wrote:
> @@ -1099,22 +1140,13 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
>  	ctx.nid = nid;
>  	ctx.inst_id = umc;
>  
> -	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
> -	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
> +	if (remove_dram_offset(&ctx)) {
> +		pr_debug("Failed to remove DRAM offset");

You don't need that pr_debug - remove_dram_offset() already has one for
the single error case.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
