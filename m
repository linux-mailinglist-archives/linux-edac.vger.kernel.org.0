Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233CF732032
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFOStN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFOStL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 14:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA371715;
        Thu, 15 Jun 2023 11:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48ED6006F;
        Thu, 15 Jun 2023 18:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237F1C433C8;
        Thu, 15 Jun 2023 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686854949;
        bh=k1BrEmpYIXWtIaiqc1FiaqGCg4LfEpw0l7lGiSlOcmU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FNmDZ0Hksi+nESkzoqQsBgBMP2ThQ7UzlQwBpbSyFPjd7IQCkGSfRUSkgvN9MXxmW
         2zqZCaZIgKubGnRWSa6ZnE6MBG+SungmIwC3ClNxnWxDjgvoVB67F2cMcdtUlOt1QZ
         Df+yNViV+Nk0L+GGdk15xUGkePYoYN/G/Tul+RD6RC1yGYePyMu0A1uIxJt4Yp3JlG
         whlPIXptPZ52O//+tml7SIJ2ZuSGwg4Sug/mUBPFbHAx7rx1VI2WZsIqU074HytdRp
         pHJHH36ibsuA3Hca43TwOc83UoyBSqBvPMbpcCw7+gq2Cg/aDVcHlqvk7NQeFmP0Hr
         jZM5IXkwegfzg==
Message-ID: <b76a8803-57aa-fa6b-ac33-b9d85f3398f9@kernel.org>
Date:   Thu, 15 Jun 2023 13:49:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/1] EDAC/altera: Check previous DDR DBE during driver
 probe
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org,
        tony.luck@intel.com
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230615022534.4163918-1-niravkumar.l.rabara@intel.com>
 <20230615022534.4163918-2-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230615022534.4163918-2-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 6/14/23 21:25, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add DDR DBE check during driver probe to notify user if previous
> reboot cause by DDR DBE and print DBE error related information.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   drivers/edac/altera_edac.c                   | 29 ++++++++++++++++----
>   include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++
>   2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8b31cd54bdb6..04c0675adc8c 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2159,6 +2159,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   #ifdef CONFIG_64BIT
>   	{
>   		int dberror, err_addr;
> +		struct arm_smccc_res result;
>   
>   		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
>   		atomic_notifier_chain_register(&panic_notifier_list,
> @@ -2168,11 +2169,29 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   		regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST,
>   			    &dberror);
>   		if (dberror) {
> -			regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
> -				    &err_addr);
> -			edac_printk(KERN_ERR, EDAC_DEVICE,
> -				    "Previous Boot UE detected[0x%X] @ 0x%X\n",
> -				    dberror, err_addr);
> +			/* Bit-31 is set if previous DDR UE happened */
> +			if (dberror & (1 << 31)) {
> +				/* Read previous DDR UE info */
> +				arm_smccc_smc(INTEL_SIP_SMC_READ_SEU_ERR, 0,
> +					      0, 0, 0, 0, 0, 0, &result);
> +
> +				if (!result.a0) {
> +					edac_printk(KERN_ERR, EDAC_DEVICE,
> +						    "Previous DDR UE:Count=0x%X,Address=0x%X,ErrorData=0x%X\n"
> +						    , (unsigned int)result.a1
> +						    , (unsigned int)result.a2
> +						    , (unsigned int)result.a3);
> +				} else {
> +					edac_printk(KERN_ERR, EDAC_DEVICE,
> +						    "INTEL_SIP_SMC_SEU_ERR_STATUS failed\n");
> +				}
> +			} else {
> +				regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
> +					    &err_addr);
> +				edac_printk(KERN_ERR, EDAC_DEVICE,
> +					    "Previous Boot UE detected[0x%X] @ 0x%X\n",
> +					    dberror, err_addr);
> +			}
>   			/* Reset the sticky registers */
>   			regmap_write(edac->ecc_mgr_map,
>   				     S10_SYSMGR_UE_VAL_OFST, 0);
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index a718f853d457..48810c39f612 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -595,4 +595,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>   #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
>   
> +/**
> + * Request INTEL_SIP_SMC_READ_SEU_ERR
> + * Sync call to get Single Event Upset Error information
> + * SEU detects both corrected and uncorrected error
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_READ_SEU_ERR
> + * a1-7 not used
> + *
> + * Return status:
> + * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
> + *    INTEL_SIP_SMC_STATUS_ERROR
> + * a1 error count of response data
> + * a2 sector address of response data
> + * a3 error data
> + */
> +#define INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS 153
> +#define INTEL_SIP_SMC_READ_SEU_ERR \
> +		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS)
> +
>   #endif


Acked-by: Dinh Nguyen <dinguyen@kernel.org>
