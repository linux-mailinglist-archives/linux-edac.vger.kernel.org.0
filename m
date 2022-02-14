Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073E84B509E
	for <lists+linux-edac@lfdr.de>; Mon, 14 Feb 2022 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiBNMvJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 07:51:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiBNMvH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 07:51:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95B4BFCD;
        Mon, 14 Feb 2022 04:50:59 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2F331EC04AD;
        Mon, 14 Feb 2022 13:50:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644843053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rPrWFBc38mGJFtLb2gbD5L01P7KXnY8iPoadiCq+HkU=;
        b=EVcj3F8oOVaWD2sYUJEfdns4GuIPqxsKFpuiRIVuBy6UKUdd2FF98dscuyrJ0ywPRl348W
        mLWEc/9pHa9uGWHDF0axKLex/OAm3F4wa+g+pzsQ2CoM6xMhFyx9hSlQ3sPWmiH2MNNA4G
        6DSalWaPfa0zoJqxgXvzBj1h8e5u1qw=
Date:   Mon, 14 Feb 2022 13:50:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 16/24] EDAC/amd64: Define function to make space for
 CS ID
Message-ID: <YgpQLnTd4TyiehS/@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-17-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-17-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:41:07PM +0000, Yazen Ghannam wrote:
> +static void expand_bits(u8 start_bit, u8 num_bits, u64 *value)
> +{
> +	u64 temp1, temp2;
> +
> +	if (start_bit == 0) {

As always

	if (!<variable, etc>)

for 0/NULL tests.

> +		*value <<= num_bits;
> +		return;
> +	}
> +
> +	temp1 = *value & GENMASK_ULL(start_bit - 1, 0);
> +	temp2 = (*value & GENMASK_ULL(63, start_bit)) << num_bits;
> +	*value = temp1 | temp2;
> +}
> +
> +static void make_space_for_cs_id_simple(struct addr_ctx *ctx)
> +{
> +	u8 num_intlv_bits = ctx->intlv_num_chan;
> +
> +	num_intlv_bits += ctx->intlv_num_dies;
> +	num_intlv_bits += ctx->intlv_num_sockets;
> +	expand_bits(ctx->intlv_addr_bit, num_intlv_bits, &ctx->ret_addr);
> +}

void functions but they return values through their pointer arguments?
I'm sure you can design those better.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
