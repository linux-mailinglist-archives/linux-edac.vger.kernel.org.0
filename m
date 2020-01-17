Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA61400F7
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 01:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgAQAbc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 19:31:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43015 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgAQAbc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Jan 2020 19:31:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so9084310pli.10
        for <linux-edac@vger.kernel.org>; Thu, 16 Jan 2020 16:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=M9PfMDqq4mrgdJjoCxlePmryw2dwKhdtVpwo2rQpPHI=;
        b=PdZtFhwcbZoGTyRB0YT1AXckQK03oRubwCEsjPBt6hG1EbNxYH0Fjv9cfZuk8BKwLr
         Nfun0qpKSn16G4otglGI+BJlfh1NXbJLnUz19wnEiuyifT2ZaGyJeQdcvzWBZB99x0iT
         nUmD1tc7SEfkKKIGJXLVJXhYzFHw02R8UDDoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M9PfMDqq4mrgdJjoCxlePmryw2dwKhdtVpwo2rQpPHI=;
        b=hnyQ1EeBrJXJvOfsAtdGTm6LhYoCPgEY+92+J+UFbkKdOJjVz/G6JqbrZnvo45e8OF
         gKbesCuSf5p23sN0j0umJfWuqF0JVKdps1E0spPNU07HV6KYQkmIPNsFzS2NTcT3wtFF
         /O2QAUf8EsGgmn4SfXykaslc9kaP63jFuXwPbS5BBlJm6VqNVG0C3hBg8Nj+dqn/6Bi+
         LRj4pERxCTvYNE3pqte4hrx7uvssvDdLRJUAYDHlHTciTpSrx7yKEI7jxe6xgDTJO1Pq
         d9nnXkSLmhkJldVbM7487zlJ+QTVk8zvgif6YZ1ADG86kKUF9g0RwVAjjgnuXkEboGx6
         Onuw==
X-Gm-Message-State: APjAAAXCmkCxyKzjqnFJ4HyfLHfN+Ru7+Wd3mDtOi+6BDTTbhVYesJfR
        570vyB6rL79ykDOseuzy4PFbWd8p+kYLDw==
X-Google-Smtp-Source: APXvYqykX9ESNeqte195/89wDGbzWuoGsUmrWe5z97ksNmWfJhf/Ojx/maDjljtSLn2zv692HKkdeA==
X-Received: by 2002:a17:90a:17e3:: with SMTP id q90mr2334122pja.139.1579221092047;
        Thu, 16 Jan 2020 16:31:32 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id r20sm25529366pgu.89.2020.01.16.16.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 16:31:31 -0800 (PST)
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
To:     Shiping Ji <shiping.linux@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Yuqing Shen <yuqing.shen@broadcom.com>,
        ray.jui@broadcom.com, wangglei@gmail.com
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <aa80b8a5-5297-91c6-6410-99e43b53bd20@broadcom.com>
Date:   Thu, 16 Jan 2020 16:31:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shiping,

Here is another small change to cleanup.

On 2020-01-15 6:32 a.m., Shiping Ji wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.
>
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
>
> ---
>       Changes in v9:
>           - Removed interrupt-config and replaced with an interrupt map where names and masks are predefined
>           - Only one ISR function is defined, mask is retrieved from the interrupt map
>           - "dram_ecc_errc" and "dram_ecc_errd" are implemented
>
> ---
> +static void dmc520_get_dram_ecc_error_info(struct dmc520_edac *edac,
> +					   bool is_ce,
> +					   struct ecc_error_info *info)
> +{
> +	u32 reg_offset_low, reg_offset_high;
> +	u32 reg_val_low, reg_val_high;
> +	bool valid;
> +
> +	reg_offset_low = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00 :
> +				 REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00;
> +	reg_offset_high = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32 :
> +				  REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32;
> +
> +	reg_val_low = dmc520_read_reg(edac, reg_offset_low);
> +	reg_val_high = dmc520_read_reg(edac, reg_offset_high);
> +
> +	valid = (FIELD_GET(REG_FIELD_ERR_INFO_LOW_VALID, reg_val_low) != 0) &&
> +		(FIELD_GET(REG_FIELD_ERR_INFO_HIGH_VALID, reg_val_high) != 0);
> +
> +	if (valid) {
> +		info->col =
> +			FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL, reg_val_low);
> +		info->row =
> +			FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW, reg_val_low);
> +		info->rank =
> +			FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK, reg_val_low);
> +		info->bank =
> +			FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK, reg_val_high);
> +	} else {
> +		memset(info, 0, sizeof(struct ecc_error_info));
This should be sizeof(*info), not sizeof(struct ecc_error_info)
for better programming to allow info to change type in the future
without the code changing.
> +	}
> +}
> +
>

