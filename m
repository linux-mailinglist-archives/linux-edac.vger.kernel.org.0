Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928CF74E73
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2019 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbfGYMrA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jul 2019 08:47:00 -0400
Received: from foss.arm.com ([217.140.110.172]:56622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388497AbfGYMrA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 25 Jul 2019 08:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17377152D;
        Thu, 25 Jul 2019 05:47:00 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A80E3F71F;
        Thu, 25 Jul 2019 05:46:59 -0700 (PDT)
Subject: Re: [PATCHv2] EDAC, altera: Move Stratix10 SDRAM ECC to peripheral
To:     thor.thayer@linux.intel.com
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1562956123-23640-1-git-send-email-thor.thayer@linux.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <eb7a1e75-2de9-cb60-bf8f-77cd1e71255f@arm.com>
Date:   Thu, 25 Jul 2019 13:46:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562956123-23640-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Thor,

On 12/07/2019 19:28, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> ARM32 SoCFPGAs had separate IRQs for SDRAM. ARM64 SoCFPGAs
> send all DBEs to SError so filtering by source is necessary.
> 
> The Stratix10 SDRAM ECC is a better match with the generic
> Altera peripheral ECC framework because the linked list can
> be searched to find the ECC block offset and printout
> the DBE Address.


> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index c2e693e34d43..09a80b53acea 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c

> @@ -2231,13 +2275,15 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>  		    of_device_is_compatible(child, "altr,socfpga-dma-ecc") ||
>  		    of_device_is_compatible(child, "altr,socfpga-usb-ecc") ||
>  		    of_device_is_compatible(child, "altr,socfpga-qspi-ecc") ||
> +#ifdef CONFIG_EDAC_ALTERA_SDRAM
> +		    of_device_is_compatible(child, "altr,sdram-edac-s10") ||
> +#endif
>  		    of_device_is_compatible(child, "altr,socfpga-sdmmc-ecc"))

I'm just curious: This list looks suspiciously like the altr_edac_a10_device_of_match[]
list. Is there a reason it can't use of_match_device() here?

>  
>  			altr_edac_a10_device_add(edac, child);
>  
>  #ifdef CONFIG_EDAC_ALTERA_SDRAM
> -		else if ((of_device_is_compatible(child, "altr,sdram-edac-a10")) ||
> -			 (of_device_is_compatible(child, "altr,sdram-edac-s10")))
> +		else if (of_device_is_compatible(child, "altr,sdram-edac-a10"))
>  			of_platform_populate(pdev->dev.of_node,
>  					     altr_sdram_ctrl_of_match,
>  					     NULL, &pdev->dev);


Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
