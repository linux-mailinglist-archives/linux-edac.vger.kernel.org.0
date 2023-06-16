Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EFC732536
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbjFPCWK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 22:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFPCWI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 22:22:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49926296A;
        Thu, 15 Jun 2023 19:22:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25e8b2931f2so250827a91.2;
        Thu, 15 Jun 2023 19:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686882126; x=1689474126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5eZgw2S76QQ9i+Vu82FM8gCv7COjZdfQOZElNWsSHa0=;
        b=DptmAA0dT/mFpOM144GNm5EXHhgGvC8YnD7ALkbKGVyTW60TZXh8ctQ4SmMfJjcFDL
         yOzbnAfFRthjH8bW+yUA6D1tPCvpBgFsY7ehGK6z8JsxGo0y1121KBPhpyd3evlZ7o5a
         TBxAzJrc9YEJb2FggvKk+a24da7KDo+3/9vwoHbU5uVUH6pFE1OMu+IjN3GP2V7QtjaW
         9AQfTpgbBoqnvbxso6kFSz7JlnqqgUI1HQCG5xGGBzBE4cKnYlTXhLvDn6NCP+J1Jawn
         Xs5SkHhXxyPdmauGcUM3/1QpOPP8uDrfAT38HUb5THkIkY5jMLGYXDfJc6yBc/RDma9v
         LoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686882126; x=1689474126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eZgw2S76QQ9i+Vu82FM8gCv7COjZdfQOZElNWsSHa0=;
        b=bz3bcHA8Rotp0OAdKuQgpot5dBCXinioL6jvd/D4nBkvh+3HHWtHCFFqHRL0jmUJZg
         W4iKRFG7qO5jdmSDla9Tscu7RDprDD2DHAz+QEhEoa58LIJCciIXWWWX/Rn8XL1Xf5dB
         NLNGanjFvU02bi2hLvi/jZ7HvNUEjntpMUfmafeskSnY6cnLLgDO6JVx2IYa908ILCfi
         RdoJ8Xz7u9F6ZPnuseelunZUQ/QlTEbtr1dFLuHGqmK3KviQBl+P+4afFmD1IZpsGHUm
         W+wgQ52emXTIs1rQve/3J6kJtg5M7iUxTd9f4fO92es9i01RbeEI4l1vA1cP6B7H63Kh
         C5ag==
X-Gm-Message-State: AC+VfDwZa6JVOYYxJc1YFc5c+KwxycBm6qZEANO3+WBcuRInHjfkCC2N
        5Bn5FamlqaCbYQ3mn+CPCtA=
X-Google-Smtp-Source: ACHHUZ6tvqASSvnu0Sg/ZYy4sno9YLhlwDv5wGPsKX0UtNv/c8p0FitqDeAgEfxSWu3+1693oKvjcg==
X-Received: by 2002:a17:90a:1d48:b0:25b:ba0c:ab7c with SMTP id u8-20020a17090a1d4800b0025bba0cab7cmr572128pju.27.1686882125636;
        Thu, 15 Jun 2023 19:22:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e30-20020a17090a6fa100b002567501040csm280501pjk.42.2023.06.15.19.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 19:22:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fa773f17-250f-d753-b15a-953efbe972ee@roeck-us.net>
Date:   Thu, 15 Jun 2023 19:22:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] hwmon: (k10temp) Define helper function to read
 CCD temp
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        markgross@kernel.org, hdegoede@redhat.com,
        Shyam-sundar.S-k@amd.com, linux-edac@vger.kernel.org,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        mario.limonciello@amd.com, babu.moger@amd.com
References: <20230615160328.419610-1-yazen.ghannam@amd.com>
 <20230615160328.419610-6-yazen.ghannam@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230615160328.419610-6-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 6/15/23 09:03, Yazen Ghannam wrote:
> The CCD temperature register is read in two places. These reads are done
> using an AMD SMN access, and a number of parameters are needed for the
> operation.
> 
> Move the SMN access and parameter gathering into a helper function in
> order to simply the code flow. This also has a benefit of centralizing
> the hardware register access in a single place in case fixes or special
> decoding is required.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Link:
> https://lore.kernel.org/r/20230516202430.4157216-6-yazen.ghannam@amd.com
> 
> v1->v2:
> * Address comments from Guenter.
> 
>   drivers/hwmon/k10temp.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 70f7b77e6ece..dfbba8b72f43 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -150,6 +150,13 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>   		*regval = 0;
>   }
>   
> +static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
> +{
> +	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
> +
> +	return amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), regval);
> +}
> +
>   static long get_raw_temp(struct k10temp_data *data)
>   {
>   	u32 regval;
> @@ -215,9 +222,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   				*val = 0;
>   			break;
>   		case 2 ... 13:		/* Tccd{1-12} */
> -			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> -					   &regval);
> +			ret = read_ccd_temp_reg(data, channel - 2, &regval);
>   
>   			if (ret)
>   				return ret;
> @@ -389,8 +394,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>   		 * the register value. And this will incorrectly pass the TEMP_VALID
>   		 * bit check.
>   		 */
> -		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
> +		if (read_ccd_temp_reg(data, i, &regval))
>   			continue;
>   
>   		if (regval & ZEN_CCD_TEMP_VALID)

