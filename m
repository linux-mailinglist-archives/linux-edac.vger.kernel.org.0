Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC29D706831
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 14:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjEQMdE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 08:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjEQMdD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 08:33:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219910DA;
        Wed, 17 May 2023 05:33:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso560979a91.1;
        Wed, 17 May 2023 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684326782; x=1686918782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D3rDce72bLIoO6oLXhfpSEMdrIa1Yjrhw5vz5N95a8=;
        b=Ij/SkTnSNg1uVouGd8+mzwQ9Kd07RBue4VFoqhXQrnSVECRTHVcLGCdRNIhvPZcosX
         Pe0vi63jACRiH9ypKtby6g8iIs6C5+q0tmuhC8nO/yWzzRyTvZgAo1PjCeX52nEn3ZeF
         Xi/6Cro5Pep/fMoqYlDW1kGgkyUhuNd8Cwjs+lio4Ndgj5VRbtMtcTjM7SArWfKJjhS0
         3tg6EF9TBz3mHWRpljaEyhYArUicbxpzHhrH9I2k6h5oCS2J85QcwB3Yt6bduNZABFxs
         kNpNICDKrqxt/vz5dCwoXPPnxK5JaVRE2ccqCv21j9BMyTe388CLOp119PjJ5Gag6pt0
         yxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326782; x=1686918782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D3rDce72bLIoO6oLXhfpSEMdrIa1Yjrhw5vz5N95a8=;
        b=PXf3f7MRGWtGZK/2ovHXejBl4G4LtiwTMFSZ5OkZ3XfW9M2FjjsL9qNOcpgaFQJamG
         q74Hdsx2EKxJD0d0bsvTyexFT6IQJ0q1REcdWSN8UQz7hhMW97vYucIUjSNyMFeQOgPt
         /d9U9qxujoeN/E81Z8UX9TQKtZ0MnxGMZ5jagLpZEAtOTcXzwV3CvGKhIMuqh4OMFDA/
         m2L3Nce3j9S4lMpLZ78cCM1NYYrpTmBZ5V4+81qdHFOoDRwad5SPyQCMdgpIrngAMRf/
         XgNu4NceIYnHngzojaxp8PonYJDzJYnGX1EKvgcsxkLXaR+63n4/TxY4bVtpohczJChL
         jeAg==
X-Gm-Message-State: AC+VfDymlM9WdR+wiyPtRBgTFjffYVFJGf3bGsJ9qcnu8R93eMcjIAb8
        rDXg02VI0QNX+C2m0O3WtBw=
X-Google-Smtp-Source: ACHHUZ7xLJWFnp0aOOOLPyCBWRSErrcjlxEjfVKX6+gY6tQgxhV4ZDDSGp6vtV9P7HYnUmOyj+3uBg==
X-Received: by 2002:a17:90a:e518:b0:253:283e:be53 with SMTP id t24-20020a17090ae51800b00253283ebe53mr4596803pjy.42.1684326782125;
        Wed, 17 May 2023 05:33:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id np12-20020a17090b4c4c00b0025063e893c9sm1430863pjb.55.2023.05.17.05.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:33:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 May 2023 05:33:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org,
        hdegoede@redhat.com, Shyam-sundar.S-k@amd.com,
        linux-edac@vger.kernel.org, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, mario.limonciello@amd.com,
        babu.moger@amd.com
Subject: Re: [PATCH 6/6] hwmon: (k10temp) Reduce k10temp_get_ccd_support()
 parameters
Message-ID: <612fc1c9-f9e1-4d88-9f5c-bbcf006d6a2b@roeck-us.net>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
 <20230516202430.4157216-7-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202430.4157216-7-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 16, 2023 at 03:24:30PM -0500, Yazen Ghannam wrote:
> Currently, k10temp_get_ccd_support() takes as input "pdev" and "data".
> However, "pdev" is already included in "data". Furthermore, the "pdev"
> parameter is no longer used in k10temp_get_ccd_support(), since its use
> was moved into read_ccd_temp_reg().
> 
> Drop the "pdev" input parameter as it is no longer needed.
> 
> No functional change is intended.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/k10temp.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 06af1fe38af7..873dbe0f5806 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -379,8 +379,7 @@ static const struct hwmon_chip_info k10temp_chip_info = {
>  	.info = k10temp_info,
>  };
>  
> -static void k10temp_get_ccd_support(struct pci_dev *pdev,
> -				    struct k10temp_data *data, int limit)
> +static void k10temp_get_ccd_support(struct k10temp_data *data, int limit)
>  {
>  	u32 regval;
>  	int i;
> @@ -435,18 +434,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		case 0x11:	/* Zen APU */
>  		case 0x18:	/* Zen+ APU */
>  			data->ccd_offset = 0x154;
> -			k10temp_get_ccd_support(pdev, data, 4);
> +			k10temp_get_ccd_support(data, 4);
>  			break;
>  		case 0x31:	/* Zen2 Threadripper */
>  		case 0x60:	/* Renoir */
>  		case 0x68:	/* Lucienne */
>  		case 0x71:	/* Zen2 */
>  			data->ccd_offset = 0x154;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			k10temp_get_ccd_support(data, 8);
>  			break;
>  		case 0xa0 ... 0xaf:
>  			data->ccd_offset = 0x300;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			k10temp_get_ccd_support(data, 8);
>  			break;
>  		}
>  	} else if (boot_cpu_data.x86 == 0x19) {
> @@ -459,21 +458,21 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		case 0x21:		/* Zen3 Ryzen Desktop */
>  		case 0x50 ... 0x5f:	/* Green Sardine */
>  			data->ccd_offset = 0x154;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			k10temp_get_ccd_support(data, 8);
>  			break;
>  		case 0x40 ... 0x4f:	/* Yellow Carp */
>  			data->ccd_offset = 0x300;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			k10temp_get_ccd_support(data, 8);
>  			break;
>  		case 0x60 ... 0x6f:
>  		case 0x70 ... 0x7f:
>  			data->ccd_offset = 0x308;
> -			k10temp_get_ccd_support(pdev, data, 8);
> +			k10temp_get_ccd_support(data, 8);
>  			break;
>  		case 0x10 ... 0x1f:
>  		case 0xa0 ... 0xaf:
>  			data->ccd_offset = 0x300;
> -			k10temp_get_ccd_support(pdev, data, 12);
> +			k10temp_get_ccd_support(data, 12);
>  			break;
>  		}
>  	} else {
> -- 
> 2.34.1
> 
