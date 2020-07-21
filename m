Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963A2227EA7
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jul 2020 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgGULVM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Jul 2020 07:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgGULVM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 Jul 2020 07:21:12 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4C620702;
        Tue, 21 Jul 2020 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595330471;
        bh=43A2Fa1NSchM7PcpcO2t4W9RovtMUbAiiDJVqUOWnjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ie2GEgKg8b/LyeeeRILXZcjptzcEVw+niPx+O81UFzlvv9+sWPaTm0P5N4uu3Z8Ym
         SDA9wQEoqMNDDYBc7F5O8PjMMN6yC/LlFEU1bne3Zp64676zHzWrEekDz1kLNgaOEa
         ynqcsEufsLT4C6LV4C7Ukn02Yt1/nWSeADYM+geI=
Date:   Tue, 21 Jul 2020 13:21:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: Re: [PATCH RESEND 1/2] rasdaemon: add support of l3tag and l3data
 in hip08 OEM format2
Message-ID: <20200721132108.3d837c62@coco.lan>
In-Reply-To: <1590566553-51565-2-git-send-email-tanxiaofei@huawei.com>
References: <1590566553-51565-1-git-send-email-tanxiaofei@huawei.com>
        <1590566553-51565-2-git-send-email-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 27 May 2020 16:02:32 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

> The two modules, l3tag and l3data were originally reported through "ARM
> processor error section". But it is not suitable. Because l3tag or l3data
> doesn't belong to any single CPU core. So we change it to use OEM format2.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Patches applied, thanks!

> ---
>  non-standard-hisi_hip08.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
> index 4cfa107..8bf10c1 100644
> --- a/non-standard-hisi_hip08.c
> +++ b/non-standard-hisi_hip08.c
> @@ -52,6 +52,8 @@
>  #define HISI_OEM_MODULE_ID_PA	2
>  #define HISI_OEM_MODULE_ID_HLLC	3
>  #define HISI_OEM_MODULE_ID_DDRC	4
> +#define HISI_OEM_MODULE_ID_L3T	5
> +#define HISI_OEM_MODULE_ID_L3D	6
>  
>  #define HISI_OEM_TYPE2_VALID_ERR_FR	BIT(6)
>  #define HISI_OEM_TYPE2_VALID_ERR_CTRL	BIT(7)
> @@ -374,6 +376,36 @@ static const char *ddrc_submodule_name[] = {
>  	"TA_DDRC3",
>  };
>  
> +static const char *l3tag_submodule_name[] = {
> +	"TB_PARTITION0",
> +	"TB_PARTITION1",
> +	"TB_PARTITION2",
> +	"TB_PARTITION3",
> +	"TB_PARTITION4",
> +	"TB_PARTITION5",
> +	"TB_PARTITION6",
> +	"TB_PARTITION7",
> +	"TA_PARTITION0",
> +	"TA_PARTITION1",
> +	"TA_PARTITION2",
> +	"TA_PARTITION3",
> +	"TA_PARTITION4",
> +	"TA_PARTITION5",
> +	"TA_PARTITION6",
> +	"TA_PARTITION7",
> +};
> +
> +static const char *l3data_submodule_name[] = {
> +	"TB_BANK0",
> +	"TB_BANK1",
> +	"TB_BANK2",
> +	"TB_BANK3",
> +	"TA_BANK0",
> +	"TA_BANK1",
> +	"TA_BANK2",
> +	"TA_BANK3",
> +};
> +
>  static const struct hisi_module_info hisi_oem_type2_module[] = {
>  	{
>  		.id = HISI_OEM_MODULE_ID_SMMU,
> @@ -404,6 +436,18 @@ static const struct hisi_module_info hisi_oem_type2_module[] = {
>  		.sub_num = ARRAY_SIZE(ddrc_submodule_name),
>  	},
>  	{
> +		.id = HISI_OEM_MODULE_ID_L3T,
> +		.name = "L3TAG",
> +		.sub = l3tag_submodule_name,
> +		.sub_num = ARRAY_SIZE(l3tag_submodule_name),
> +	},
> +	{
> +		.id = HISI_OEM_MODULE_ID_L3D,
> +		.name = "L3DATA",
> +		.sub = l3data_submodule_name,
> +		.sub_num = ARRAY_SIZE(l3data_submodule_name),
> +	},
> +	{
>  	}
>  };
>  



Thanks,
Mauro
