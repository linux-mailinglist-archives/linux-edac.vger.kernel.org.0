Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC47A6958
	for <lists+linux-edac@lfdr.de>; Tue, 19 Sep 2023 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjISREZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Sep 2023 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISREY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Sep 2023 13:04:24 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C972AC6;
        Tue, 19 Sep 2023 10:04:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F1C0940E01A3;
        Tue, 19 Sep 2023 17:04:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8f2kTUen3yuZ; Tue, 19 Sep 2023 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695143055; bh=TWv82/E/BzG4ZGu/xS9Td8QEmZ5DKUE9zxfZM73OmPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlKyZenxwhY1+GfWX9y+2NQOiSinQYn10oRFHhppE12jTP5L8VJbA36tTuHD773Va
         USmhB3e7Qq7umteBBV+98nJ0CBOcOUokC2obw/3G7yW/yLSLV86BVQQZae41lCLdVk
         2PF5ZVbXUVRy0188ZJ58Zn1mkM8SFY25PL9Y5YUPHib7v4I0nRDP1HEyDL9RECvPI0
         ARLYmZ6lPfbQNCM7i0zXOMbXTrJLlWqTtGkmmOwY//MK3wIp9EwND/caQchGU8+yWq
         JkLR++I3wVN+urlP/RmxmB4FlWVL6yyF/F+80t7o6GSMceaMRjmnLGtIpUtp+QRsiQ
         ZQuyPqEbRgW2c3fobGT3i86AxOZZlIvZMr8hyIqEPT0UuEy/dGfaUaq3F+03vDhdvX
         azzCmYUlLhKUXrdgJdkDAExFX+8LXvuYQJXYrQmDioBroTKephXoxYwHiLRLyt9iXc
         j4VYMfV6yiYBm9WRf+2mkfjfMmH9rjvIdwsxzI1ohXsDHO6cHkxpCom0eUp7aKILOd
         PYNwi06x3gCbrHG0YOuopsU3H59oJlpJp0YR/gQkBYLTWMf6oWfvUwwD/sKgU80j95
         yLcY+D7cFz5a20LxDFYYflM9fweq6eUJOCoS+DMkkaTFOQ2x9b6tv1i9KAdsUCSGT9
         0sOmiHxZYP5ahyEdBp6q8bMk=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB90240E00F4;
        Tue, 19 Sep 2023 17:04:01 +0000 (UTC)
Date:   Tue, 19 Sep 2023 19:03:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     linux-edac@vger.kernel.org, git@amd.com,
        devicetree@vger.kernel.org, sai.krishna.potthuri@amd.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v8 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
Message-ID: <20230919165927.GEZQnTb9gr5X13sJuD@fat_crate.local>
References: <20230804121924.18615-1-shubhrajyoti.datta@amd.com>
 <20230804121924.18615-3-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804121924.18615-3-shubhrajyoti.datta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 04, 2023 at 05:49:24PM +0530, Shubhrajyoti Datta wrote:
> +config EDAC_VERSAL
> +	tristate "Xilinx Versal DDR Memory Controller"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  Support for error detection and correction on the Xilinx Versal DDR
> +	  memory controller.
> +
> +	  Report both single bit errors (CE) and double bit errors (UE).
> +	  Support injecting both correctable and uncorrectable errors for debug
> +	  purpose using sysfs entries.

          Report both single bit errors (CE) and double bit errors (UE).
          Support injecting both correctable and uncorrectable errors
          for debugging purposes.


> +/**
> + * struct ecc_error_info - ECC error log information.
> + * @burstpos:		Burst position.
> + * @lrank:		Logical Rank number.
> + * @rank:		Rank number.
> + * @group:		Group number.
> + * @bank:		Bank number.
> + * @col:		Column number.
> + * @row:		Row number.
> + * @rowhi:		Row number higher bits.
> + * @i:			ECC error info.
> + */
> +union ecc_error_info {
> +	struct {
> +		u64 burstpos:3;
> +		u64 lrank:3;
> +		u64 rank:2;
> +		u64 group:2;
> +		u64 bank:2;
> +		u64 col:10;
> +		u64 row:10;
> +		u32 rowhi;
> +	};
> +	u64 i;
> +};

I missed this the last time but, if this is supposed to be a union of
sizeof(u64), why aren't you doing this:

union ecc_error_info {
        struct {
                u32 burstpos:3;
                u32 lrank:3;
                u32 rank:2;
                u32 group:2;
                u32 bank:2;
                u32 col:10;
                u32 row:10;
                u32 rowhi;
        };
        u64 i;
} __packed;

i.e., the struct should have two u32's - the first one is the bitfield
and the second one is rowhi and the "overloaded" one is the u64 i.

And also it should be packed even though this shouldn't be needed in
this case but still.

Ditto for the other unions.

> +
> +union edac_info {
> +	struct {
> +		u32 row0:6;
> +		u32 row1:6;
> +		u32 row2:6;
> +		u32 row3:6;
> +		u32 row4:6;
> +		u32 reserved:2;
> +	};
> +	struct {
> +		u32 col1:6;
> +		u32 col2:6;
> +		u32 col3:6;
> +		u32 col4:6;
> +		u32 col5:6;
> +		u32 reservedcol:2;
> +	};
> +	u32 i;
> +};

...

> +	/* Unlock the PCSR registers */
> +	writel(PCSR_UNLOCK_VAL, ddrmc_base + XDDR_PCSR_OFFSET);
> +
> +	writel(0, ddrmc_base + ECCR0_CERR_STAT_OFFSET);
> +	writel(0, ddrmc_base + ECCR1_CERR_STAT_OFFSET);
> +	writel(0, ddrmc_base + ECCR0_UERR_STAT_OFFSET);
> +	writel(0, ddrmc_base + ECCR1_UERR_STAT_OFFSET);
> +
> +	/* Lock the PCSR registers */
> +	writel(1, ddrmc_base + XDDR_PCSR_OFFSET);

I still don't know what this locking and unlocking is all about and why
it is needed...

Btw, you must always make sure your stuff builds:

drivers/edac/versal_edac.c: In function 'mc_remove':
drivers/edac/versal_edac.c:1035:9: error: implicit declaration of function 'disable_intr'; did you mean 'disable_irq'? [-Werror=implicit-function-declaration]
 1035 |         disable_intr(priv);
      |         ^~~~~~~~~~~~
      |         disable_irq


Otherwise it looks to me like you haven't tested it and if that is the
case, I'll simply ignore it.

So make sure you build-test and test your stuff before submitting.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
