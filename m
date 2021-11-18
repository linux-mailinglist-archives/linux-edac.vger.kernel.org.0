Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FDD4565CE
	for <lists+linux-edac@lfdr.de>; Thu, 18 Nov 2021 23:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhKRWrA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 18 Nov 2021 17:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232469AbhKRWq6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 18 Nov 2021 17:46:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9F97600D4;
        Thu, 18 Nov 2021 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637275437;
        bh=N9jTIFliNnDCqYanHCgoS9+gfA6v3yNGg/McyII/kPs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LAWLApl0V0aUK4UdGPZtWzjV87bJ994Bz/Bp+N5n/sxm9Xjzi1pyKn4vQMs70LZWT
         9QevPtT/DcJiBjeGgvNyLxBYcKJVudgntS3V+qyBtPjcdPc26hqNNPh0KL3bSJ5Cw1
         tIgQ9fjjFgRlPG5+m7cJK4svRNS+Zu6aji+Wuaxk5/eyDTV6m8p63iDYRlYdjm7eb4
         8ms4xctUUfe0cZu7cJY1tGKm3RXaH9CVrz8vIp/yTOvswnICaQNU1Vs93AjkqGvXsM
         R80ZfgJn3Bszg/tHNoF7BkYi6Pt531JMMiGcw43aKVHWREagwhm8Imh4bQAbF13yu+
         /PGynoCpgMpTQ==
Subject: Re: [PATCHv4 1/4] EDAC/synopsys: use the quirk for version instead of
 ddr version
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
References: <20211012190709.1504152-1-dinguyen@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <778158cf-fbe9-0a65-7982-5372592e5ad2@kernel.org>
Date:   Thu, 18 Nov 2021 16:43:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012190709.1504152-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

can you please take this series through your tree?

Thanks,
Dinh

On 10/12/21 2:07 PM, Dinh Nguyen wrote:
> Version 2.40a supports DDR_ECC_INTR_SUPPORT for a quirk, so use that
> quirk to determine a call to setup_address_map().
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4: add Reviewed-by
> v3: new patch
> ---
>   drivers/edac/synopsys_edac.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7e7146b22c16..bf237fccb444 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -1352,8 +1352,7 @@ static int mc_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	if (of_device_is_compatible(pdev->dev.of_node,
> -				    "xlnx,zynqmp-ddrc-2.40a"))
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
>   		setup_address_map(priv);
>   #endif
>   
> 
