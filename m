Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E29F732530
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjFPCVk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 22:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjFPCVk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 22:21:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079DD2683;
        Thu, 15 Jun 2023 19:21:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-544c0d768b9so239702a12.0;
        Thu, 15 Jun 2023 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686882098; x=1689474098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+4N7B70/Rv7BZa0SRzL9Af0Cexudd4LOxkULscQwulc=;
        b=ih7VP9eLFtU45PXs4IJnZ9z9j4G6J5rlbveKnJheJbRja1IdfK1B0UMLuINP703fZf
         ArFswEtxYRVWp5D++oNTqwSc9xSUWp581amaALmzoZRHcokQAh8mS52AxSGRJIZ/kzzh
         ANU5TnuEyP09iuPjmy1pDypXlPySbifM3i5SNy+X4+Rc39z1m934QQ3bvNfdUoLyhZWb
         gc7YBW2nxdDcSDi/JooaiFt2LVdUeAQAtgwAfvMhEHnWjrq4CrNBmWtlQFB3283Kvbjx
         kTMvBN99G+6v9rSSx2kvuKO670h6DLszdz9pEAEdyZlPeMwgRDLM15Gb54zQDuhN3afA
         +Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686882098; x=1689474098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4N7B70/Rv7BZa0SRzL9Af0Cexudd4LOxkULscQwulc=;
        b=TxP5YB+X2c8YbA2bCuLMZPqrqECd5vPVtek2HCVfiOWTARlwUaMRySsFvE47vGCTXq
         0SXaGamd7PcVbYAtKMRS6mfc6RdM8f6xgUiMyssqtM2/SCVlNpMYTp679j4ylTFDdgw9
         8iXVR1LV0fq3nF6A9vd1+ec2JW2HxVtko50TvqTcIu5EfVwRVBst8M+tKpCE/GWq2rhw
         IUF23gG0R7fAluwaIBBFlzPClSSHePR0ojZVNvIt5AlTq4/tMQbelJMTVL40Z97fl6df
         wmAvZkFDrM7SXjixXIfWJdWGYFyWqIYg+YxdB9+FwIHSK/hqNiyBEUapThqSK2Ofx9zG
         6jrg==
X-Gm-Message-State: AC+VfDwX6+XJJXQpMWBzsR3LGZcMKHGiz+ip0uvkuGiMBJCs2cyHJU8o
        X65zn4pM0/znUu+WcTfWB3c=
X-Google-Smtp-Source: ACHHUZ7v4dc+4lIw84np7JkL1X+Nb2OA35xK70EZgiClGOKBg6ohZoxnfl8hdOF3Pl7ho0vy9SyKyw==
X-Received: by 2002:a05:6a20:9192:b0:10f:be0:4dce with SMTP id v18-20020a056a20919200b0010f0be04dcemr1522678pzd.8.1686882098320;
        Thu, 15 Jun 2023 19:21:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r9-20020a62e409000000b00666a83bd544sm1371070pfh.23.2023.06.15.19.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 19:21:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a144a969-fa29-bc05-3daf-c6346dae644c@roeck-us.net>
Date:   Thu, 15 Jun 2023 19:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/6] hwmon: (k10temp) Check return value of
 amd_smn_read()
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        markgross@kernel.org, hdegoede@redhat.com,
        Shyam-sundar.S-k@amd.com, linux-edac@vger.kernel.org,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        mario.limonciello@amd.com, babu.moger@amd.com
References: <20230615160328.419610-1-yazen.ghannam@amd.com>
 <20230615160328.419610-4-yazen.ghannam@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230615160328.419610-4-yazen.ghannam@amd.com>
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
> Check the return value of amd_smn_read() before saving a value. This
> ensures invalid values aren't saved or used.
> 
> There are three cases here with slightly different behavior.
> 
> 1) read_tempreg_nb_zen():
> 	This is a function pointer which does not include a return code.
> 	In this case, set the register value to 0 on failure. This
> 	enforces Read-as-Zero behavior.
> 
> 2) k10temp_read_temp():
> 	This function does have return codes, so return the error code
> 	from the failed register read. Continued operation is not
> 	necessary, since there is no valid data from the register.
> 	Furthermore, if the register value was set to 0, then the
> 	following operation would underflow.
> 
> 3) k10temp_get_ccd_support():
> 	This function reads the same register from multiple CCD
> 	instances in a loop. And a bitmask is formed if a specific bit
> 	is set in each register instance. The loop should continue on a
> 	failed register read, skipping the bit check.
> 
> Furthermore, the __must_check attribute will be added to amd_smn_read().
> Therefore, this change is required to avoid compile-time warnings.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Link:
> https://lore.kernel.org/r/20230516202430.4157216-4-yazen.ghannam@amd.com
> 
> v1->v2:
> * Address comments from Guenter.
> 
>   drivers/hwmon/k10temp.c | 36 +++++++++++++++++++++++++++---------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 7b177b9fbb09..70f7b77e6ece 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -145,8 +145,9 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>   
>   static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>   {
> -	amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
> +	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
> +			 ZEN_REPORTED_TEMP_CTRL_BASE, regval))
> +		*regval = 0;
>   }
>   
>   static long get_raw_temp(struct k10temp_data *data)
> @@ -197,6 +198,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   			     long *val)
>   {
>   	struct k10temp_data *data = dev_get_drvdata(dev);
> +	int ret = -EOPNOTSUPP;
>   	u32 regval;
>   
>   	switch (attr) {
> @@ -213,13 +215,17 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   				*val = 0;
>   			break;
>   		case 2 ... 13:		/* Tccd{1-12} */
> -			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> -						  &regval);
> +			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> +					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> +					   &regval);
> +
> +			if (ret)
> +				return ret;
> +
>   			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>   			break;
>   		default:
> -			return -EOPNOTSUPP;
> +			return ret;
>   		}
>   		break;
>   	case hwmon_temp_max:
> @@ -235,7 +241,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>   			- ((regval >> 24) & 0xf)) * 500 + 52000;
>   		break;
>   	default:
> -		return -EOPNOTSUPP;
> +		return ret;
>   	}
>   	return 0;
>   }
> @@ -373,8 +379,20 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>   	int i;
>   
>   	for (i = 0; i < limit; i++) {
> -		amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
> +		/*
> +		 * Ignore inaccessible CCDs.
> +		 *
> +		 * Some systems will return a register value of 0, and the TEMP_VALID
> +		 * bit check below will naturally fail.
> +		 *
> +		 * Other systems will return a PCI_ERROR_RESPONSE (0xFFFFFFFF) for
> +		 * the register value. And this will incorrectly pass the TEMP_VALID
> +		 * bit check.
> +		 */
> +		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
> +				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
> +			continue;
> +
>   		if (regval & ZEN_CCD_TEMP_VALID)
>   			data->show_temp |= BIT(TCCD_BIT(i));
>   	}

