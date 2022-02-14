Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2974B5130
	for <lists+linux-edac@lfdr.de>; Mon, 14 Feb 2022 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353916AbiBNNJT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 08:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiBNNJT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 08:09:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAD54B85D;
        Mon, 14 Feb 2022 05:09:11 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 870A01EC00F8;
        Mon, 14 Feb 2022 14:09:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644844145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bfa8NKJ66AaG5XA2+aWkSTSm4HHtiIWE39IjIhrlAVk=;
        b=faT7mfWHnTdzSgditcakDZLhYSRjoh05y52NKwdmwEVm7whVeT+q6RthAaWRG1Ft+Jj/vr
        i8mvLGORI4j0SpGaj1bCQXzUPk2la74+U0xcmzLC+C8AQsAoKaQeLgGA6Y81ShPf08Ucug
        m6fVT6ecoyOCTV8zINM8FeHybRk9XFg=
Date:   Mon, 14 Feb 2022 14:09:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 18/24] EDAC/amd64: Define function to insert CS ID
 into address
Message-ID: <YgpUc7J2/4+n2oMv@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-19-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-19-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:41:09PM +0000, Yazen Ghannam wrote:
> @@ -1326,20 +1331,7 @@ static int denormalize_addr(struct addr_ctx *ctx)
>  		return -EINVAL;
>  	}
>  
> -	if (num_intlv_bits > 0) {
> -		u64 temp_addr_i;
> -
> -		/*
> -		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
> -		 * where III is the ID for this CS, and XXXXXXYYYYY are the
> -		 * address bits from the post-interleaved address.
> -		 * "num_intlv_bits" has been calculated to tell us how many "I"
> -		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
> -		 * there are (where "I" starts).
> -		 */

That comment looks useful, why remove it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
