Return-Path: <linux-edac+bounces-1723-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB495B11A
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C721FB22CCF
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF815F41F;
	Thu, 22 Aug 2024 09:05:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575681CF8B;
	Thu, 22 Aug 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317515; cv=none; b=D13B10KwuUQPmHcEcnsX3oSepK9vtFgLxFDI4fTr/m3C3QQgFXJxNHIb99S+Hyj1H39OnwTno0b9XSm1S6yiA1uKnxSOlGEpOzcc7HUrawbv/TcmgrLw6eSL0pS7ZnVSWdTmeI6FIZERYjJ9VKi8aDF/gGoxc2PmgjfWFru5I7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317515; c=relaxed/simple;
	bh=ke62uAz2fqqy3srJ38BfYBli7FNy6/2rFr2aRNu+HW0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSs8X38Z/sOyDhsU5ZTNenDXasi0udZPhrZFbletbalU+S9gUtKjawImDPW14vIacUy6xi3uQbJB9xneGuMyPIjFzzJaBRBV9kCR5ZOuA0gct2qL4zaX3yPQEYqlxmWaI9sb16FoSaBbR1It9LXvPeEmodD0zbqpJr51quwJisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqHJb4LRpz6K9bj;
	Thu, 22 Aug 2024 17:02:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D6B7C140A46;
	Thu, 22 Aug 2024 17:05:08 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 Aug
 2024 10:05:08 +0100
Date: Thu, 22 Aug 2024 10:05:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yang Ruibin <11162571@vivo.com>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<opensource.kernel@vivo.com>
Subject: Re: [PATCH v1] drivers:ras:Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <20240822100507.00000566@Huawei.com>
In-Reply-To: <20240821071719.8277-1-11162571@vivo.com>
References: <20240821071719.8277-1-11162571@vivo.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 03:17:18 -0400
Yang Ruibin <11162571@vivo.com> wrote:

> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
Ideally needs a fixes tag. 

Otherwise (given I looked into a similar one last night
with the same pattern).
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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


