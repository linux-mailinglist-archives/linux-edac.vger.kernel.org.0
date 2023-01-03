Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE265BFD3
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjACM0A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 07:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjACMZ6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 07:25:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50372100A;
        Tue,  3 Jan 2023 04:25:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 406F41516;
        Tue,  3 Jan 2023 04:26:37 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5549A3F587;
        Tue,  3 Jan 2023 04:25:54 -0800 (PST)
Date:   Tue, 3 Jan 2023 12:25:41 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: highbank: Fix memory leak in highbank_mc_probe
Message-ID: <20230103122541.5e5cf0dc@donnerap.cambridge.arm.com>
In-Reply-To: <20221229054825.1361993-1-linmq006@gmail.com>
References: <20221229054825.1361993-1-linmq006@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 29 Dec 2022 09:48:24 +0400
Miaoqian Lin <linmq006@gmail.com> wrote:

Hi,

> edac_mc_alloc() allocates memory. The memory are not released
> when devres_open_group() fails, which causes memory leak.
> Call edac_mc_free() in the error handling to fix this.

Yes, this looks correct.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> Fixes: a1b01edb2745 ("edac: add support for Calxeda highbank memory controller")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> altr_sdram_probe() performs similar operations,
> I take it as reference.
> ---
>  drivers/edac/highbank_mc_edac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
> index 61b76ec226af..19fba258ae10 100644
> --- a/drivers/edac/highbank_mc_edac.c
> +++ b/drivers/edac/highbank_mc_edac.c
> @@ -174,8 +174,10 @@ static int highbank_mc_probe(struct platform_device *pdev)
>  	drvdata = mci->pvt_info;
>  	platform_set_drvdata(pdev, mci);
>  
> -	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
> -		return -ENOMEM;
> +	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
> +		res = -ENOMEM;
> +		goto free;
> +	}
>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!r) {
> @@ -243,6 +245,7 @@ static int highbank_mc_probe(struct platform_device *pdev)
>  	edac_mc_del_mc(&pdev->dev);
>  err:
>  	devres_release_group(&pdev->dev, NULL);
> +free:
>  	edac_mc_free(mci);
>  	return res;
>  }

