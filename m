Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9504B4FF2
	for <lists+linux-edac@lfdr.de>; Mon, 14 Feb 2022 13:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiBNMU4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 07:20:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352993AbiBNMUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 07:20:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5CE49274;
        Mon, 14 Feb 2022 04:20:44 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9BFDF1EC04AD;
        Mon, 14 Feb 2022 13:20:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644841238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=awmOYe0q2eigKq4ItO9KPxIRltMibHr3LJFHTIRlYXU=;
        b=gZLjxhvBJTVORBJtqIUTiIK4na7LGN3pMvm2SlZSnisTU43XeCmXW7yJq2Vl0+2CYlEeaq
        wdNAEfJZWzxiGMzG4IQYdaQlKJV4HnGKEqyIRhsHbQDuRpPqtGFDS+hWG8kSz/YKB5UmTV
        ABGVWy7ScWOhtYNEX7DSJLpbXorgR7A=
Date:   Mon, 14 Feb 2022 13:20:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 12/24] EDAC/amd64: Define function to get number of
 interleaved channels
Message-ID: <YgpJHNfS6cs1aEjE@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-13-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-13-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:41:03PM +0000, Yazen Ghannam wrote:
> Move number of interleaved channel calculation to a separate helper
> function. Drop unused cases.

... or by looking at that change, I think you want to have each separate
step in the address massaging be a separate function. Which, if so,
makes sense but you have to say it...

...

> +static void get_intlv_num_chan(struct addr_ctx *ctx)
> +{
> +	/* Save the log2(# of channels). */
> +	switch (ctx->intlv_mode) {
> +	case NONE:
> +		ctx->intlv_num_chan = 0;
> +		break;
> +	case NOHASH_2CH:
> +	case DF2_HASH_2CH:
> +		ctx->intlv_num_chan = 1;
> +		break;
> +	default:
> +		/* Valid interleaving modes where checked earlier. */

"were"

> +		break;
> +	}
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
