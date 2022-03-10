Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066394D4BFA
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 16:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbiCJOVn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 09:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiCJOUa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 09:20:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AAE5FBC;
        Thu, 10 Mar 2022 06:19:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D26BB825A7;
        Thu, 10 Mar 2022 14:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C07FC340E8;
        Thu, 10 Mar 2022 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646921966;
        bh=x54tX+WKuRg2TSvnQQqf6l2VpZTFE8lhw3ZR3z0WJ2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ee3TXcpv5ErDmwlnyjdM1OmjTD/eCcgnpinuVmL9ClQr82doa/r8DwtMUJCa1gfWj
         Z4/XbUDbDP5d1cWN1Ob80gAddAJ5nMfThGnYURtL/Sf/vBghV6pPWs8a3R6G2xhTeR
         ejpwpghmYBoSH/IDq2nozt090C/xo6q2Yj6OYhy50IPzGLhK8mkz8KMy3v+N1TqeEs
         KqhEePEvOu/nqlJSDjImSIPYRHar3NQuJmf4N+W7HmtXPHdZI/kUWvsPFm9VppEjKs
         deSh+comtVv0aITzT3cMEZBNkqr2T6BRRwi7r16aoSxGXO9Fo0vVXAA6L4CLXL6JP2
         qHjcu8wAH8i7w==
Message-ID: <e442e6b1-2612-d8fb-793a-5e6f11851f21@kernel.org>
Date:   Thu, 10 Mar 2022 08:19:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] EDAC: altera: Add SDRAM ECC check for U-Boot
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220305014118.4794-1-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220305014118.4794-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/4/22 19:41, niravkumar.l.rabara@intel.com wrote:
> From: Rabara Niravkumar L <niravkumar.l.rabara@intel.com>
> 
> A bug in legacy U-Boot causes a crash during SDRAM boot if ECC
> is not enabled in the bitstream but enabled in the Linux config.
> 
> Memory mapped read of the ECC Enabled bit was only enabled
> if U-Boot determined ECC was enabled in the bitstream.
> 
> The Linux driver checks the ECC enable bit using a memory map
> read. In the ECC disabled bitstream case, U-Boot didn't
> enable ECC register memory map reads and since they are not
> allowed this results in a crash.
> 
> This patch always reads the ECC Enable register through a
> SMC call which is always allowed and it works with legacy
> and current U-Boot.
> 
> Signed-off-by: Rabara Niravkumar L <niravkumar.l.rabara@intel.com>
> ---
>   drivers/edac/altera_edac.c | 40 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 5dd29789f97d..e7e8e624a436 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1083,8 +1083,46 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
>   
>   #ifdef CONFIG_EDAC_ALTERA_SDRAM
>   
> +/*
> + * A legacy U-Boot bug only enabled memory mapped access to the ECC Enable
> + * register if ECC is enabled. Linux checks the ECC Enable register to
> + * determine ECC status.
> + * Use an SMC call (which always works) to determine ECC enablement.
> + */
> +static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
> +{
> +	const struct edac_device_prv_data *prv = device->data;
> +	unsigned long sdram_ecc_addr;
> +	struct arm_smccc_res result;
> +	struct device_node *np;
> +	phys_addr_t sdram_addr;
> +	u32 read_reg;
> +	int ret;
> +
> +	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
> +	if (!np)
> +		goto sdram_err;
> +
> +	sdram_addr = of_translate_address(np, of_get_address(np, 0,
> +							     NULL, NULL));
> +	of_node_put(np);
> +	sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
> +	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
> +		      0, 0, 0, 0, 0, 0, &result);
> +	read_reg = (unsigned int)result.a1;
> +	ret = (int)result.a0;
> +	if (!ret && (read_reg & prv->ecc_enable_mask))
> +		return 0;
> +
> +sdram_err:
> +	edac_printk(KERN_ERR, EDAC_DEVICE,
> +		    "%s: No ECC present or ECC disabled.\n",
> +		    device->edac_dev_name);
> +	return -ENODEV;
> +}
> +
>   static const struct edac_device_prv_data s10_sdramecc_data = {
> -	.setup = altr_check_ecc_deps,
> +	.setup = altr_s10_sdram_check_ecc_deps,
>   	.ce_clear_mask = ALTR_S10_ECC_SERRPENA,
>   	.ue_clear_mask = ALTR_S10_ECC_DERRPENA,
>   	.ecc_enable_mask = ALTR_S10_ECC_EN,

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
