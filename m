Return-Path: <linux-edac+bounces-1727-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A077A95C818
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 10:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575681F215C5
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B91459EA;
	Fri, 23 Aug 2024 08:30:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464237144;
	Fri, 23 Aug 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401823; cv=none; b=Qrv2oegv2yboEAgzH7LMe7Gfp6ETtKja/fLKckvflLnWx0NMI+8nsXufN0ER6t3W7twuO80jqy0haNdohQaecKNdiwaFNURSZg80AIdwsNYdrzV9BEds76seNf3jAgr8S2HRzeW/U9Wx/yFpGOkeqRiZa+rZlQSvQ6hElQi7rUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401823; c=relaxed/simple;
	bh=SqHvwbAraygEAg356Y++FZVnXAHwaUKpCxpJXbMD2Ww=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uecBFQrSLIMjUG6Q3ItGlFkGUdzguoOiecT0tD2Acw0gWtV+RiePktaTCzO/PXACRY6LGBK/G5SMAzKh6WRzGebG1UW6wsfGL+RJdrZflcvUoYsI6gBRcTEV5glyaZbnOuheu1qLROC0RmEiKt3IqAM4GZ+LGm8h/V+sLPV8N1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqtTg6Jzjz6K8wt;
	Fri, 23 Aug 2024 16:27:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DC6F140B63;
	Fri, 23 Aug 2024 16:30:12 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 09:30:00 +0100
Date: Fri, 23 Aug 2024 09:29:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yang Ruibin <11162571@vivo.com>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Andy
 Whitcroft" <apw@canonical.com>, Joe Perches <joe@perches.com>, "Dwaipayan
 Ray" <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Ingo
 Molnar <mingo@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] drivers:block:Use IS_ERR() to check
 debugfs_create_dir() return value
Message-ID: <20240823092959.00000c90@Huawei.com>
In-Reply-To: <20240822132358.2416027-1-11162571@vivo.com>
References: <20240822132358.2416027-1-11162571@vivo.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 22 Aug 2024 21:23:58 +0800
Yang Ruibin <11162571@vivo.com> wrote:

Patch title needs an update as this isn't in block and that's not the
style used for this subsystem.

Otherwise fine.

> The debugfs_create_dir() function returns error pointers.It
> never returns NULL. So use IS_ERR() to check its return value.
> 
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/ras/cec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index e440b15fbabc..ebd4631b685b 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -489,7 +489,7 @@ static int __init create_debugfs_nodes(void)
>  	}
>  
>  	d = debugfs_create_dir("cec", dfs);
> -	if (!d) {
> +	if (IS_ERR(d)) {
>  		pr_warn("Error creating cec debugfs node!\n");
>  		return -1;
>  	}


