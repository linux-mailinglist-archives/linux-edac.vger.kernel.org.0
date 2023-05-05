Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2773B6F82DF
	for <lists+linux-edac@lfdr.de>; Fri,  5 May 2023 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEEMZ4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 5 May 2023 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEEMZz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 5 May 2023 08:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6757C1AEFA;
        Fri,  5 May 2023 05:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC85863DC9;
        Fri,  5 May 2023 12:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76DC433D2;
        Fri,  5 May 2023 12:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683289553;
        bh=PCb1VWZ2OJyBbD3H9w56ZNJoJky13otK2RlGn8Op0Xw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BXMlEUwRP8gfpynsRGWGe+MH/DrBrlLHE1IsBkJbuebrwAo3Hhd0vbFQEW8Wpqibu
         8iSurJEp/1bXtwPYQHRFykFS8DY94M7ewRj3EUzO7lPJ8muI6DHeQeJk5eOt5sKgvv
         qDn94A6y9JmiowHg+SVR+fg2rbS9xg+CPF8ICTz5rCJ/60paryRPeK+mlOtKRnnzOG
         OdTYcEfNWJD+G/Ce0mVx8gru1E6EQjtVyBUxaC/GxklQTIs9VJlyTahu6l0cgS0Szu
         5/j0FXza1gR2422GsWw8RFrmQz28wNp3sS4Rd1byEstE7i+WklP/LoNfMQAvcY8Mz4
         mQv8EK8CVKFBg==
Message-ID: <9d3f4dc3-300e-314e-040b-d360ed092366@kernel.org>
Date:   Fri, 5 May 2023 07:25:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] EDAC/altera: Check previous DDR DBE during driver
 probe
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org,
        tony.luck@intel.com
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
 <20230503101821.3342935-3-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230503101821.3342935-3-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 5/3/23 05:18, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add DDR DBE check during driver probe to notify user if previous
> reboot cause by DDR DBE and print DBE error related information.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   drivers/edac/altera_edac.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8b31cd54bdb6..398a49a3eb89 100644
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
> @@ -2168,11 +2169,28 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
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
> +					0, 0, 0, 0, 0, 0, &result);

Please run checkpatch --strict to align these.

> +
> +				if (!(int)result.a0) {

Why the typecast to int?

> +					edac_printk(KERN_ERR, EDAC_DEVICE,
> +					"Previous DDR UE:Count=0x%X,Address=0x%X,ErrorData=0x%X\n"
> +					, (unsigned int)result.a1, (unsigned int)result.a2
> +					, (unsigned int)result.a3);
> +				} else {
> +					edac_printk(KERN_ERR, EDAC_DEVICE,
> +						"INTEL_SIP_SMC_SEU_ERR_STATUS failed\n");
> +				}
> +			} else {
> +				regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
> +						&err_addr);
> +				edac_printk(KERN_ERR, EDAC_DEVICE,
> +						"Previous Boot UE detected[0x%X] @ 0x%X\n",
> +						dberror, err_addr);
> +			}
>   			/* Reset the sticky registers */
>   			regmap_write(edac->ecc_mgr_map,
>   				     S10_SYSMGR_UE_VAL_OFST, 0);
> @@ -2180,6 +2198,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>   				     S10_SYSMGR_UE_ADDR_OFST, 0);
>   		}
>   	}
> +

Stray newline.

>   #else
>   	edac->db_irq = platform_get_irq(pdev, 1);
>   	if (edac->db_irq < 0)
