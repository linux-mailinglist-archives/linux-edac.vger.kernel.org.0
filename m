Return-Path: <linux-edac+bounces-1439-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D873A91E20F
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 16:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1631C217A3
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jul 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACE1607B4;
	Mon,  1 Jul 2024 14:14:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79679126F1E;
	Mon,  1 Jul 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843265; cv=none; b=tsXVaBIKLTf5K7Th3UY4Jr4Wx4/pS5F6mFVMWDsGjRNIUa//qIBQ6Rsz5y/vCyx5lAA+88RnwSPUUSlHT4sCO/2DkmQzZJGoVPAnBcs80eM9LYhxhh7bJwPoY9i5B6yWScZSvZko7R1J+MyLVPHmKMEa0gnfz1uh533pFpyK4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843265; c=relaxed/simple;
	bh=4YN6nhv2AMl64KE8DHomQphtJ6Ze682NF2vFEypA9PM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB1P3RrL4slud309W+RgEKOkI+6WcR2p6kfEC115HktiW0cmEznv+yzFQQGRsjXEDK0f1kER7Oi30Bheib41DvZAKDm3SwaxbrB49q/3gQE9jaIB/kjpW9oc/lIV/QozEIhUxJude7gX+uo5sssUmXRnx8yPQgVEq2Ug8oE7QJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCSfh63sBz6K9Td;
	Mon,  1 Jul 2024 22:12:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AC2B0140B33;
	Mon,  1 Jul 2024 22:14:18 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 15:14:18 +0100
Date: Mon, 1 Jul 2024 15:14:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Daniel Ferguson
	<danielf@os.amperecomputing.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, "James
 Morse" <james.morse@arm.com>, Len Brown <lenb@kernel.org>, Shengwei Luo
	<luoshengwei@huawei.com>, Shuai Xue <xueshuai@linux.alibaba.com>, Tony Luck
	<tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] RAS: ACPI: APEI: add conditional compilation to
 ARM error report functions
Message-ID: <20240701151417.00002d64@Huawei.com>
In-Reply-To: <f520f2529bb27d452a2dee762b6968939df42f45.1719484498.git.mchehab+huawei@kernel.org>
References: <cover.1719484498.git.mchehab+huawei@kernel.org>
	<f520f2529bb27d452a2dee762b6968939df42f45.1719484498.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 27 Jun 2024 12:36:07 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> From: Daniel Ferguson <danielf@os.amperecomputing.com>
> 
> This prevents the unnecessary inclusion of ARM specific RAS error
> handling routines in non-ARM platforms.
> 
> [mchehab: avoid unneeded ifdefs and fix coding style issues]
> Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

With my grumpy hat on this is 2 types of change, so ideally split into
1) ifdef stuff
2) white space / linebreaks tidying up.

Content is fine,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/apei/ghes.c | 13 ++++++-------
>  drivers/ras/ras.c        |  2 ++
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 623cc0cb4a65..2589a3536d91 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -529,11 +529,12 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>  }
>  
>  static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
> -				       int sev, bool sync)
> +				     int sev, bool sync)
>  {
> +	bool queued = false;
> +#if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
>  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  	int flags = sync ? MF_ACTION_REQUIRED : 0;
> -	bool queued = false;
>  	int sec_sev, i;
>  	char *p;
>  
> @@ -570,7 +571,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>  				    error_type);
>  		p += err_info->length;
>  	}
> -
> +#endif
>  	return queued;
>  }
>  
> @@ -773,11 +774,9 @@ static bool ghes_do_proc(struct ghes *ghes,
>  
>  			arch_apei_report_mem_error(sev, mem_err);
>  			queued = ghes_handle_memory_failure(gdata, sev, sync);
> -		}
> -		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> +		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>  			ghes_handle_aer(gdata);
> -		}
> -		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> +		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>  			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
>  		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>  			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index a6e4792a1b2e..5d94ab79c8c3 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -54,7 +54,9 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  
>  void log_arm_hw_error(struct cper_sec_proc_arm *err)
>  {
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>  	trace_arm_event(err);
> +#endif
>  }
>  
>  static int __init ras_init(void)


