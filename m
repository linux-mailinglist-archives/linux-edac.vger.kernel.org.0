Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D8706825
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEQMa4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEQMaz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 08:30:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510B171C;
        Wed, 17 May 2023 05:30:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so487159b3a.2;
        Wed, 17 May 2023 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684326654; x=1686918654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgEoimwM/+QRDs1JjtBHOrcpHPooX0wlKo5SY0pkI2c=;
        b=GBM6Dx/LkOFQdL+ZvmG8JcOzBZPcctXeVfY3Lzwj2vgwWMI8rej1tIbtXoQp8Cbnhd
         ZgXtWsfNWDO7aUfOIenSjY6kIiy455yMcZhFuUYqI124l6DFwemovMwgyYjzyURGWLwN
         g4Mzd1wK5z51TMwjXad2Ucuhxt4kpyx9q3Fz0Ad8TU+Iyn0cQk//HFSCxj3SfaVUwh1O
         bt0sCb6a7WK7F38f2i0m+BSTyoHmNJuBhgD4hvwRCHvN4BMPWhmJMfZ5tkv+PG1xY0YV
         WrOt9GfnmqsfuadsPFWjiw7VX7ionk4i+hs0r/ydSo7c8J6KmTuQBM9FG1U57I5/dHMl
         ttWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326654; x=1686918654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgEoimwM/+QRDs1JjtBHOrcpHPooX0wlKo5SY0pkI2c=;
        b=ePxo6aMQI7MuTFBUp/onwtoE4OeZKrA0mfxKlg5lbl+RD9WunSQH5LZT+U9F16DIX4
         b3DKXGo6sN1XVJUwgUMA9e0Rd6GjxOufFFjue2ShWf2IX9/gxOkLg2mL4PAmon4wWDVt
         uzK/YQzdGFI8xVWD7jf098f5+qyCHWkuUkceoAGzS7dqWfo6O7xcPSFp2gDvTmOlQWgI
         huA55LkSYng9Qh9I//Gx1o1xUZngq6VM3jWkGQkqI/gqMEWnxnNeJYw2OcpSyOCFGiKd
         flGm/nIj33HcKPrjgHdv0ronfovjeG5/BOobU5XNTdkDbOfEJ+MAZvZwM/93jWl3Ht78
         IGUQ==
X-Gm-Message-State: AC+VfDz53zwwQC7d5kvUkzYlWHxIrMS/RtxclEsEcm4djgGasb2XGpGL
        zHCZ6O7jyY6BA5RUhHU7FBA=
X-Google-Smtp-Source: ACHHUZ43afd6eVMigQVij11C03RJRNMdYwZrR1GD5NadMeNu9kn587ZFOSmr9JKyP0Yz/hkVCIwAeQ==
X-Received: by 2002:a17:902:ced1:b0:1ac:5def:d203 with SMTP id d17-20020a170902ced100b001ac5defd203mr46531082plg.35.1684326654241;
        Wed, 17 May 2023 05:30:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902788400b001a69d1bc32csm17424924pll.238.2023.05.17.05.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:30:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 17 May 2023 05:30:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, markgross@kernel.org,
        hdegoede@redhat.com, Shyam-sundar.S-k@amd.com,
        linux-edac@vger.kernel.org, clemens@ladisch.de, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, mario.limonciello@amd.com,
        babu.moger@amd.com
Subject: Re: [PATCH 5/6] hwmon: (k10temp) Define helper function to read CCD
 temp
Message-ID: <f61f548b-0007-404e-9c9d-d84a2a657983@roeck-us.net>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
 <20230516202430.4157216-6-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202430.4157216-6-yazen.ghannam@amd.com>
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

On Tue, May 16, 2023 at 03:24:29PM -0500, Yazen Ghannam wrote:
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
> ---
>  drivers/hwmon/k10temp.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 6ea1fa62b7c1..06af1fe38af7 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -150,6 +150,18 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>  		*regval = 0;
>  }
>  
> +static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
> +{
> +	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
> +	u32 tmp;
> +
> +	if (amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), &tmp))
> +		return -EINVAL;

As mentioned before, this is not appropriate. The error code
from amd_smn_read() should be returned.

> +
> +	*regval = tmp;

This seems pointless. Why not just pass regval as parameter
to amd_smn_read() ?

This function should be reduced to

	return amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), regval));

> +	return 0;
> +}
> +
>  static long get_raw_temp(struct k10temp_data *data)
>  {
>  	u32 regval;
> @@ -214,9 +226,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>  				*val = 0;
>  			break;
>  		case 2 ... 13:		/* Tccd{1-12} */
> -			if (amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
> -					 ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
> -					 &regval))
> +			if (read_ccd_temp_reg(data, channel - 2, &regval))
>  				return -EINVAL;

Now this is really wrong, no matter what. Why bother replacing the
error code in read_ccd_temp_reg() only to replace it again ?

>  
>  			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
> @@ -376,8 +386,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
>  	int i;
>  
>  	for (i = 0; i < limit; i++) {
> -		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
> -				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
> +		if (read_ccd_temp_reg(data, i, &regval))
>  			continue;
>  
>  		if (regval & ZEN_CCD_TEMP_VALID)
> -- 
> 2.34.1
> 
