Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0376370DD0F
	for <lists+linux-edac@lfdr.de>; Tue, 23 May 2023 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjEWMy4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 May 2023 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjEWMyw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 May 2023 08:54:52 -0400
X-Greylist: delayed 1805 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 05:54:50 PDT
Received: from bosmailout03.eigbox.net (bosmailout03.eigbox.net [66.96.187.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F0C118
        for <linux-edac@vger.kernel.org>; Tue, 23 May 2023 05:54:49 -0700 (PDT)
Received: from bosmailscan01.eigbox.net ([10.20.15.1])
        by bosmailout03.eigbox.net with esmtp (Exim)
        id 1q1R3J-0006uD-7O; Tue, 23 May 2023 08:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=anniebear.net; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:Message-ID:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=adHSZYLF1OQRtMEH4XxOr8eL2i1ZMqljhXv2Kh+46aM=; b=ABYqWEpkPQbnM515RlFnjL7mPy
        MfjU48N8nUTstwiR36FXig82Ga8q2tozoxB2Fa1uigcgjP/xboVSkwS0rNFAuwPaPoU5dOmNHs4Qn
        em11ktOZwIw8kwq3q6W2wceNljK+/byImueS9Tsw3VNH/ok9YfVxiFkTliSopYUVsGZUMEJipDeWR
        mYBCdmIMVnaAkevhW4pvf0LqI3oBTDqBcIip8RQ8qdC9pKj8jzVHJsYN+Hgs8rrfzwhWMUqxWPQNn
        BkPNWwO7pW64HFbvMMBaQUK5WM+Xp7LDMJKh/aXvS1UxOkrWz0iLH8znjQpnenBx6+zRGsDA3TcoD
        3yXiRYJg==;
Received: from [10.115.3.32] (helo=bosimpout12)
        by bosmailscan01.eigbox.net with esmtp (Exim)
        id 1q1R3I-0001pi-S2; Tue, 23 May 2023 08:23:44 -0400
Received: from boswebmail11.eigbox.net ([10.20.16.11])
        by bosimpout12 with 
        id 0CPh2A00D0EKGQi01CPkGK; Tue, 23 May 2023 08:23:44 -0400
X-Authority-Analysis: v=2.3 cv=d4VuNSrE c=1 sm=1 tr=0
 a=arGavn6Z5cgUkMHml6gAfw==:117 a=8nJEP1OIZ-IA:10 a=P0xRbXHiH_UA:10
 a=QyXUC8HyAAAA:8 a=mrD3klddzif1__fuzFkA:9 a=wPNLvfGTeEIA:10
Received: from [127.0.0.1] (helo=emailmg.ipower.com)
        by boswebmail11.eigbox.net with esmtp (Exim)
        id 1q1R3B-0001GH-Gt; Tue, 23 May 2023 08:23:37 -0400
Received: from 192.168.151.0
        (SquirrelMail authenticated user dinh.linux@anniebear.net)
        by emailmg.ipower.com with HTTP;
        Tue, 23 May 2023 07:23:37 -0500
Message-ID: <0a7b6e4775ea8ae3c41cd49c6cd19f90.squirrel@emailmg.ipower.com>
In-Reply-To: <20230511041221.135527-3-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
    <20230511041221.135527-1-niravkumar.l.rabara@intel.com>
    <20230511041221.135527-3-niravkumar.l.rabara@intel.com>
Date:   Tue, 23 May 2023 07:23:37 -0500
Subject: Re: [PATCH v3 2/2] EDAC/altera: Check previous DDR DBE during 
 driver probe
From:   dinh.linux@anniebear.net
To:     niravkumar.l.rabara@intel.com
Cc:     niravkumar.l.rabara@intel.com, bp@alien8.de, dinguyen@kernel.org,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org,
        tony.luck@intel.com
User-Agent: SquirrelMail/1.4.19
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-EN-AuthUser: dinh.linux@anniebear.net
Sender:  dinh.linux@anniebear.net
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> Add DDR DBE check during driver probe to notify user if previous
> reboot cause by DDR DBE and print DBE error related information.
>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  drivers/edac/altera_edac.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8b31cd54bdb6..04c0675adc8c 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2159,6 +2159,7 @@ static int altr_edac_a10_probe(struct
> platform_device *pdev)
>  #ifdef CONFIG_64BIT
>  	{
>  		int dberror, err_addr;
> +		struct arm_smccc_res result;
>
>  		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
>  		atomic_notifier_chain_register(&panic_notifier_list,
> @@ -2168,11 +2169,29 @@ static int altr_edac_a10_probe(struct
> platform_device *pdev)
>  		regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST,
>  			    &dberror);
>  		if (dberror) {
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
>  			/* Reset the sticky registers */
>  			regmap_write(edac->ecc_mgr_map,
>  				     S10_SYSMGR_UE_VAL_OFST, 0);
> --
> 2.25.1
>
>

I think it would make sense if you combined the 1st patch. This patch
cannot survive on its own without the defines.

Dinh


