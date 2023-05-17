Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F0706803
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjEQMZK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjEQMZJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 08:25:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F84193;
        Wed, 17 May 2023 05:25:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53202149ae2so471241a12.3;
        Wed, 17 May 2023 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684326308; x=1686918308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEGoGpyrR60B8AjfNbHQnj78PfieDYrQkkUy4eueo0Q=;
        b=kML+gvuAXtKqecLJrYpLLONtf5q3VxVj0mH3+jLLtkrkQE8d0WMDK3AeuWKiwiVBp6
         CaxruwpHKGXvSNpTOiZ4WdaHHyG+gizh3lTsL7qFJ8fRgdCLVMZlxDGXLjjydp9T9iZf
         v0wHNvQEkKfdpantj/99n9AktsRB8s+2WZlSolJJNo6MVJF8C1yg3HvCYMdZ4JCQn0sa
         gwK+NvVHhiE20LuxQxyJqhYUXWpE1qCz5M/K4+4785N0wj2CkXV8SsjdN2TQFYq/toJG
         /L9R5GU9GnqA82WbP/Zrx1wlDqJIti20Mc+hbYt9s5BdBP/0VKLOYUBfIF/2b4rEnllD
         n4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326308; x=1686918308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEGoGpyrR60B8AjfNbHQnj78PfieDYrQkkUy4eueo0Q=;
        b=S2GNJJcyzKFiYF0ukg3mSW9NWiSUCEDQasmcCahv8uf4JbCV+y10hJWJpAm4XjC8DA
         AfwSAha9ewiT9HPj553DtYoPaemQ95fCW8tUfvugLerh2Bh8Tf4vXqMUrnbY745Oi+wE
         fBpHxkxToxcEHKedLQWv+wn7ZmQRy5cBcA0AfYM6tFh6wPa5boLmruEvdM92T/SKUN8K
         32b7iW0IMjoDWHME2FSUFb1PtbdpLGpPa7Rt1fmA8rShzFsZOoXoCARfD8LPJJyZONk3
         e3WLkYyy0INiz5W+BCclcGhalfSiforUDp3KKQ8mTg5t8SIN+MBMh2pmjahTX5N/q4I2
         81+w==
X-Gm-Message-State: AC+VfDxHSBNMWvxd+MyfUZuVrZ+0/Uh9EDRrQlfm/EbyPQtYwnhy18v3
        0zkqHDgLgXKdGf4IuvvEX6ccHOw5I2A=
X-Google-Smtp-Source: ACHHUZ7tqN6XkclPOdB4GxCwvfImnp1nRD4DeA0mvf0+zmf9LZjB55uWWQyMz3U1XE9oy2JrH/3jiA==
X-Received: by 2002:a05:6a20:8416:b0:ec:d7cf:bcf7 with SMTP id c22-20020a056a20841600b000ecd7cfbcf7mr51311098pzd.17.1684326307884;
        Wed, 17 May 2023 05:25:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c25-20020a631c59000000b005143448896csm15283973pgm.58.2023.05.17.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:25:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 May 2023 05:25:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org,
        hdegoede@redhat.com, Shyam-sundar.S-k@amd.com,
        linux-edac@vger.kernel.org, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, mario.limonciello@amd.com,
        babu.moger@amd.com
Subject: Re: [PATCH 3/6] hwmon: (k10temp) Check return value of amd_smn_read()
Message-ID: <f3cce515-845c-480e-a096-8e24e0079454@roeck-us.net>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
 <20230516202430.4157216-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202430.4157216-4-yazen.ghannam@amd.com>
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

On Tue, May 16, 2023 at 03:24:27PM -0500, Yazen Ghannam wrote:
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
> 	This function does have return codes, so return -EINVAL on a
> 	failed register read. Continued operation is not necessary,
> 	since there is no valid data from the register. Furthermore, if
> 	the register value was set to 0, then the following operation
> 	would underflow.
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
> ---
>  drivers/hwmon/k10temp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 7b177b9fbb09..6ea1fa62b7c1 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -145,8 +145,9 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>  
>  static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>  {
> -	amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
> +	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
> +			 ZEN_REPORTED_TEMP_CTRL_BASE, regval))
> +		*regval = 0;
>  }
>  
>  static long get_raw_temp(struct k10temp_data *data)
> @@ -213,9 +214,11 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  				*val = 0;
>  			break;
>  		case 2 ... 13:		/* Tccd{1-12} */
> -			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> -						  &regval);
> +			if (amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> +					 ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> +					 &regval))
> +				return -EINVAL;
> +

-EINVAL: Invalid Argument, supposed to be used for bad user input.
I don't see how that would apply here. amd_smn_read() returns
a valid error code. This error core should be returned to the caller,
or there needs to be an explanation why this is not appropriate.

>  			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
>  			break;
>  		default:
> @@ -373,8 +376,10 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>  	int i;
>  
>  	for (i = 0; i < limit; i++) {
> -		amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
> +		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
> +				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
> +			continue;
> +
The reason for ignoring the error should be explained here.

>  		if (regval & ZEN_CCD_TEMP_VALID)
>  			data->show_temp |= BIT(TCCD_BIT(i));
>  	}
> -- 
> 2.34.1
> 
