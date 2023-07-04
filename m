Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D535774704B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGDMCe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDMCd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 08:02:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C6E62
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 05:02:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so8921365e9.1
        for <linux-edac@vger.kernel.org>; Tue, 04 Jul 2023 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688472150; x=1691064150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLID9thVRTcNOhmdZHYQrnNEldoT1MhW+qCBkwjbsHA=;
        b=CEwcyjeYu25ELyZ3mrrzjT8HQToV0g5LQJIrkH5T7eKLULX6x0dX6kPWfzfaYEEvDL
         whWSfVZfQfVDdnth1lQjdvXFdlCppv6SPoZLcYrUB0BvQTJjVwHSJHtLXpo8H/t1c5Wy
         NtYWrGN/UobMK8MncGufzSlxuw9end12oY2XsLv+meJSPJWc2r2ndp4QzwQZACYQjjAv
         4Ujxjz8DvtT+0/0wv62s4G0/qV5WZqbOI8AROFULuYnqBf9XqDUTu+il0sbBSwKZArw+
         FjNi1pGxldLdagVs6jTXDKC1A4GB+eJRN5VG86U8nnYvCR+zlx+gVtGv8kT62G7X2IA3
         Udog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688472150; x=1691064150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLID9thVRTcNOhmdZHYQrnNEldoT1MhW+qCBkwjbsHA=;
        b=a5fI8INUDvHLcFAeXyMVmla9C0X3kKAuDl2CpcirYcw8+6XI7EQrUxhJHiNXuqF/Zn
         eTxR5KPZsIxPEYeij2R1hpCqSz1DGMHNF+Jfzq9rDqSPiUKzcPrXXXTuY7Bql9TIamW5
         H6kB3tTU6nxATNSZTEkCRINH3A0CH8JNayX0P3A8bHu1kpdcTWkDVwyz6iz+h7/i4rjf
         lhpXVwYEGlNVqz3VcfF0r+6SCC9CGVKYXTjq9zpErJ+2QLMDiTPlFp3J09OKERXOWDW5
         NCBvSTxhwURdXV4ZnL/dOJL5AJ8mVA1lLrqtNfXXQOGOACaT5i8t01LvufSRxsxzFW3e
         Qubg==
X-Gm-Message-State: AC+VfDwJsk+udhrvVpJC10Y4vh4cHhPFpkGzapeVssemfuWaDOFdrwwD
        xuRwi6fsuICjsR/dVddxkOxasRZI5X2XFDjzlhw=
X-Google-Smtp-Source: ACHHUZ5+ca8vnoeLiN22K5tC/ngSiQQ+/QK1OHIlSd3FxLb3aEa9sJpNhS1GWgSWjDZMlmvEefAMNg==
X-Received: by 2002:a7b:c8d1:0:b0:3fa:9554:fb23 with SMTP id f17-20020a7bc8d1000000b003fa9554fb23mr10457058wml.21.1688472149644;
        Tue, 04 Jul 2023 05:02:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c024500b003fbb00599e4sm18012161wmj.2.2023.07.04.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 05:02:27 -0700 (PDT)
Date:   Tue, 4 Jul 2023 15:02:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] EDAC/i10nm: shift exponent is negative
Message-ID: <a0bf3b4c-a528-4507-9bd4-95a0a9eb927d@moroto.mountain>
References: <20230703162509.77828-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703162509.77828-1-koba.ko@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Here is a better commit message.  You can just copy and paste it.
------------------------------------------
[PATCH v3] EDAC/i10nm: Prevent negative shifts in skx_get_dimm_info().

UBSAN generated the following warning during a timeout:

    UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
    shift exponent -66 is negative

That most likely means that rows, cols, and ranks were all set to
-EINVAL.  Address this in two ways.

1) Change the debug output in skx_get_dimm_attr() to KERN_ERR so that
   users will know where exactly the error is.
2) Add a check for errors in skx_get_dimm_info().

Fixes: 88a242c98740 ("EDAC, skx_common: Separate common code out from skx_edac")
Signed-off-by:
-----------------------------------------------

> @@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
>  	ranks = numrank(mtr);
>  	rows = numrow(mtr);
>  	cols = imc->hbm_mc ? 6 : numcol(mtr);
> +	if (ranks == -EINVAL || rows == -EINVAL || cols == -EINVAL)
> +		return 0;

Change this to:

	if (rangks < 0 || rows < 0 || cols < 0)
		return 0;

It's bad form to check for a specific error code unless there is a need.

regards,
dan carpenter

