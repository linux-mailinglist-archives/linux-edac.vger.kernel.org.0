Return-Path: <linux-edac+bounces-2875-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D9A096A6
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B195166EE0
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1637211A3D;
	Fri, 10 Jan 2025 16:02:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DB20551F;
	Fri, 10 Jan 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524977; cv=none; b=sHSXuaUedJ+vyM2sc8ZBXNQPlhk7Hv4GaLOHGfmHW8+Nwn+AFU2AYAru8PZlC/pNuZipzN7jE4+LFhIXHhzlvPflrwo0BNMBre59TJi6AE+os9PdfOdwYqkts6RXNRPx6se4GxtzATP4PyQ4eRp5FSJOnSu6GGlYjDCG1tFgF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524977; c=relaxed/simple;
	bh=Mff6XEtYoZ7uEgqMqLq7mWUz2TQ4U76TjDKRAZLADPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8QypYVdhRlVq8UEsui6LotPJs/QiCXyg8OjnLdx3QkcNwzmaW0sxu1tjaQzT9Rxd+I+QdsrTTs2aS2HTZXhDiMcAkkFttbCKL5LtZdvYi/gmFIhjg0b+1AkSWyOBJIlfnp9TJj+1zj2nwOJCgDM9OyqfYJX8YnB7cvnvW/kChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV5x054fPz6D9d4;
	Sat, 11 Jan 2025 00:01:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CFD0140A35;
	Sat, 11 Jan 2025 00:02:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 17:02:45 +0100
Date: Fri, 10 Jan 2025 16:02:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 01/14] rasdaemon: Fix for parsing error when trace
 event's format file is larger than PAGE_SIZE
Message-ID: <20250110160244.00006635@huawei.com>
In-Reply-To: <20250110122641.1668-2-shiju.jose@huawei.com>
References: <20250110122641.1668-1-shiju.jose@huawei.com>
	<20250110122641.1668-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 10 Jan 2025 12:26:27 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> When a trace event's format file is larger than PAGE_SIZE (4096) then
> libtraceevent returns parsing failed when rasdaemon reads the fields.
> The reason found that tep_parse_event() call in the add_event_handler()
> internally fails in libtraceevent because of the incomplete format file
> data read. However libtraceevent did not return error in this stage,
> which is fixed in the following patch for libtraceevent.
> https://lore.kernel.org/all/20250109102338.6128644d@gandalf.local.home/
> 
> When rasdaemon reads a trace event format file,the maximum data size

space after that comma if spinning a v3.

> that can be read is limited to PAGE_SIZE by the seq_read() and
> seq_read_iter() functions in the kernel. This results in userspace
> receiving partial data if the format file is larger than PAGE_SIZE,
> requiring fix in the rasdaemon to read the complete data from the
> format file.
> 
> Add fix for reading trace event format files larger than PAGE_SIZE
> in add_event_handler().
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  ras-events.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/ras-events.c b/ras-events.c
> index 5d8118a..6692a31 100644
> --- a/ras-events.c
> +++ b/ras-events.c
> @@ -376,7 +376,7 @@ static int filter_ras_mc_event(struct ras_events *ras, char *group, char *event,
>  
>  static int get_pagesize(struct ras_events *ras, struct tep_handle *pevent)
>  {
> -	int fd, len, page_size = 4096;
> +	int fd, len, page_size = 8192;
>  	char buf[page_size];
>  
>  	fd = open_trace(ras, "events/header_page", O_RDONLY);
> @@ -827,7 +827,8 @@ static int add_event_handler(struct ras_events *ras, struct tep_handle *pevent,
>  			     unsigned int page_size, char *group, char *event,
>  			     tep_event_handler_func func, char *filter_str, int id)
>  {
> -	int fd, size, rc;
> +	int fd, rc;
> +	int size = 0;
>  	char *page, fname[MAX_PATH + 1];
>  	struct tep_event_filter *filter = NULL;
>  
> @@ -857,13 +858,17 @@ static int add_event_handler(struct ras_events *ras, struct tep_handle *pevent,
>  		return rc;
>  	}
>  
> -	size = read(fd, page, page_size);
> +	do {
> +		rc = read(fd, page + size, page_size);
> +		if (rc < 0) {
> +			log(TERM, LOG_ERR, "Can't get arch page size\n");
> +			free(page);
> +			close(fd);
> +			return size;
> +		}
> +		size += rc;
> +	} while (rc > 0);
>  	close(fd);
> -	if (size < 0) {
> -		log(TERM, LOG_ERR, "Can't get arch page size\n");
> -		free(page);
> -		return size;
> -	}
>  
>  	/* Registers the special event handlers */
>  	rc = tep_register_event_handler(pevent, -1, group, event, func, ras);


