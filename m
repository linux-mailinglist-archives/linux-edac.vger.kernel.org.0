Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885BD74A319
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGFRbS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 13:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFRbR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 13:31:17 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C01BE9;
        Thu,  6 Jul 2023 10:31:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579ef51428eso13506587b3.2;
        Thu, 06 Jul 2023 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688664675; x=1691256675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EeHnP6FEAY8beKK8Mr7sdNGsHC/F9D6slb2TyVEj6KU=;
        b=UATOUeGmcDIJ+udtUwBgvpCk84qoI4x/no+wV28rIdROiBMdWeQEEP5eB2Mfs/GYlq
         82ihjmssfYifaUVs0YkTkR4jx68kfnbpYI6WL1eQ9wNmpfKW+ZcxWCO71E94eMIhhxwc
         CvgnLcm9exlnNLR/TK429jdoW9YJ5nW1yc/L3tUL5spZ5QwaRzBfouOUCIbzO25UU0IQ
         sUj38NRjxnfKu/i5COHVqaBGKl+cSx3PnE8cheGRU4Vlvb35hW+ajUQGX5rVG6hpOedF
         qTgGg/sifkjrSApnlFnci81qmp3tGuCUzUu3PrT5Yl4DHs1IuLEto7rAxUaWFA2chkwC
         GIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688664675; x=1691256675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeHnP6FEAY8beKK8Mr7sdNGsHC/F9D6slb2TyVEj6KU=;
        b=L5EMd0JCZy+tfA8hQLXxLkRDRtkWQIGvL5uA/jxRvfwb2tCyNyvKERzozvpQ6MWceZ
         rZe1RpvP6gs2Av/YWLTiF+X9gzN4cPSvmx7spXz2uHzMGuPZYBufJ+rn32rm9iTYcndx
         GEBSKazoAreaS5k/eW1uE7+yKhciPdVishDha2eYjUNX3KIXE0kobuzJ+NVxzyOAykVO
         ZwAPhhiJ7HBInll6OCOPx27cPgW1MSUC+aBEAvWZD0RYwvvRiIGovK/HBt55scL6Av2x
         1pXUn4krs5S/0LuCFRyKbapPrMRXXYRZGcVv61nllBfsn4yHIiQIUeyqkKI+NpluNnSi
         NSLQ==
X-Gm-Message-State: ABy/qLZ3vkID/d0VjzwB64DyaVaLh3wTNMMKN88fLeG8m2EKwj31kXUJ
        RzxddKqplLWvyjToN7JB9Go=
X-Google-Smtp-Source: APBJJlHwifPgA07q0UBg/oW6/o71vD9UhyXXj/PQpvvW2wwyWd/wGIFZmKnON5LVyBEG8hC0l7BsoA==
X-Received: by 2002:a0d:ef07:0:b0:577:616e:2d72 with SMTP id y7-20020a0def07000000b00577616e2d72mr4508493ywe.5.1688664675515;
        Thu, 06 Jul 2023 10:31:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o207-20020a0dccd8000000b00568c1c919d2sm481870ywd.29.2023.07.06.10.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 10:31:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <364e0970-e047-59e6-7b75-c5b43b32270a@roeck-us.net>
Date:   Thu, 6 Jul 2023 10:31:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/3] hwmon: (k10temp) Add thermal support for AMD
 Family 1Ah-based models
Content-Language: en-US
To:     Avadhut Naik <avadhut.naik@amd.com>, bp@alien8.de, x86@kernel.org,
        linux-hwmon@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        yazen.ghannam@amd.com, avadnaik@amd.com
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
 <20230706171323.3722900-3-avadhut.naik@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230706171323.3722900-3-avadhut.naik@amd.com>
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

On 7/6/23 10:13, Avadhut Naik wrote:
> From: Avadhut Naik <Avadhut.Naik@amd.com>
> 
> Add thermal info support for AMD Family 1Ah-based models. Support is
> provided on a per-socket granularity.
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/k10temp.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 7b177b9fbb09..c61837fbc315 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -65,7 +65,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>   #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
>   #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
>   
> -/* Common for Zen CPU families (Family 17h and 18h and 19h) */
> +/* Common for Zen CPU families (Family 17h and 18h and 19h and 1Ah) */
>   #define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
>   
>   #define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
> @@ -462,6 +462,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   			k10temp_get_ccd_support(pdev, data, 12);
>   			break;
>   		}
> +	} else if (boot_cpu_data.x86 == 0x1a) {
> +		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
> +		data->read_tempreg = read_tempreg_nb_zen;
> +		data->is_zen = true;
>   	} else {
>   		data->read_htcreg = read_htcreg_pci;
>   		data->read_tempreg = read_tempreg_pci;
> @@ -508,6 +512,8 @@ static const struct pci_device_id k10temp_id_table[] = {
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
>   	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
>   	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>   	{}
>   };

