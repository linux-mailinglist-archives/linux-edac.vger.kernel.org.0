Return-Path: <linux-edac+bounces-2584-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4D89D4F84
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D241C284BFD
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85DE1DBB13;
	Thu, 21 Nov 2024 15:13:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CEB1DBB03;
	Thu, 21 Nov 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201986; cv=none; b=Dpoyrv2/2ff+lTmjsujJTaK+pmXhadHQoZmU3puSloK/ta32JPSluxC+shQ/xEMATwjBpBTQ77Bmh4uoRSwt59Ywwj3+MVdwAFcwrJH3QnMQ/c54lEJ/o4G55JS5tCwiMN112QDGlRyb2in4Hh+9zvwxQaJYht1vnlPJ1ciQ+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201986; c=relaxed/simple;
	bh=N2t4wscRqsJghTzzXbgX0aBSC6h2KhOlngyKbJivo/s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTOwJ1gAu6GSY2hjz40gc8MJtnfPAb6HjGTlqS8pr2SbG08vYF2q7q7zPf509vWtwSHJtgbfoXC3COP/PMxgi1EIrRXZ7Fiu4IqKeow9CmwR3PMDrjd1ev7ONukLlYsArSR2CA8/QjQF4Nhh0w/CBlBnFvzEmKguHRiZ0ECJAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvM9r5YM5z6J9qF;
	Thu, 21 Nov 2024 23:10:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E78CD140A79;
	Thu, 21 Nov 2024 23:13:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:13:00 +0100
Date: Thu, 21 Nov 2024 15:12:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 02/13] rasdaemon: cxl: Fix mismatch in region field's
 name with kernel DRAM trace event
Message-ID: <20241121151259.00006803@huawei.com>
In-Reply-To: <20241120095923.1891-3-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Nov 2024 09:59:12 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Fix mismatch in 'region' field's name with kernel DRAM trace event.
> 
> Fixes: ea224ad58b37 ("rasdaemon: CXL: Extract, log and record region info from cxl_general_media and cxl_dram events")
> 
No line break here (though this is rasdaemon so maybe kernel rules don't apply?)
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  ras-cxl-handler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
> index 8733b2b..7d4fc9f 100644
> --- a/ras-cxl-handler.c
> +++ b/ras-cxl-handler.c
> @@ -966,7 +966,7 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
>  	if (trace_seq_printf(s, "hpa:0x%llx ", (unsigned long long)ev.hpa) <= 0)
>  		return -1;
>  
> -	ev.region = tep_get_field_raw(s, event, "region", record, &len, 1);
> +	ev.region = tep_get_field_raw(s, event, "region_name", record, &len, 1);
>  	if (!ev.region)
>  		return -1;
>  	if (trace_seq_printf(s, "region:%s ", ev.region) <= 0)


