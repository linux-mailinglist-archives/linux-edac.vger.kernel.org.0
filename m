Return-Path: <linux-edac+bounces-5506-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF980C7C7ED
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 06:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60B954E207C
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 05:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA6E296BBB;
	Sat, 22 Nov 2025 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O71ZRjK7"
X-Original-To: linux-edac@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BB8248C;
	Sat, 22 Nov 2025 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763788980; cv=none; b=oGYRpN3VGf7daKvoRp2owicnX107DdJ/8u02q4KJU/BwIacN1OCc555QZGddXWDF/dAy2IzSz3ZuGFyXwT7LYcRMS9FACad/f5C4oO/e1rYALOMDPNDH9o/ZoM8VI6VWQOof8hlLOQTtyWKSnsx9LPCZi2uWr92bBfs6JnZ46BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763788980; c=relaxed/simple;
	bh=wEjAxsAYg0fns4hbL6oC/+qy5aQXSgsbyAJeWxJjerc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quivEXi+vdMbnuMF5oXDwN7b46FX5/BW0yAiHIiEwp412aJmnnHysRMrz7PyDsIijibO+8tdiph4YumpYTtxv4mizEwO424cliSf+WUAcEP+DTWG3ZKh2DusTuWsWqROJzqptkTpmWYf1tsJ6wd3+Urbv4hVPV00RP+HsH9BTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O71ZRjK7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ctiiXJqj43yt6JFDqmOGbkwRPsJgQSrgpqu+YQaEadw=; b=O71ZRjK77TRPcnC4NwHOF25PzM
	QXIKzNKT5MHAYI9TGOp2dd9ftqObQfTYmmqaeudsDv+ftQNBr8lEf5215q5bHLh36kZ5KlHu+nUpY
	oePTHC1A2TdwX92YkkNo79STpXJMmcxsDEUjETKuimRzLMtlv7Uet6XddETu2X2EslVlHPIOi8Y54
	2ZRy/7DQWXkdKjJ2U4Ct3dDAUgN3pXND3NerPs+rDUUbb7Bj26zzf/zFxuzOOpRNbDd3WlaMGMmq8
	h2UmE7ShTS8n/kkhvaLanI1hDi1wclKfrX7hDWjxcyofgAyAqLtUDPn0m70i7WUDS5mfoIGRRfQKe
	XJUYTC0g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMg5G-00000009HOl-42QK;
	Sat, 22 Nov 2025 05:22:55 +0000
Message-ID: <26083ba9-1979-4d14-8465-3f54f2f96d23@infradead.org>
Date: Fri, 21 Nov 2025 21:22:53 -0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/2] ras: mem: Add ACPI RAS2 memory driver
To: shiju.jose@huawei.com, rafael@kernel.org, bp@alien8.de,
 akpm@linux-foundation.org, rppt@kernel.org, dferguson@amperecomputing.com,
 linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org
Cc: jonathan.cameron@huawei.com, linuxarm@huawei.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20251121182825.237-1-shiju.jose@huawei.com>
 <20251121182825.237-3-shiju.jose@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251121182825.237-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/25 10:28 AM, shiju.jose@huawei.com wrote:
> diff --git a/Documentation/edac/scrub.rst b/Documentation/edac/scrub.rst
> index 2cfa74fa1ffd..737a10da224f 100644
> --- a/Documentation/edac/scrub.rst
> +++ b/Documentation/edac/scrub.rst
> @@ -340,3 +340,61 @@ controller or platform when unexpectedly high error rates are detected.
>  
>  Sysfs files for scrubbing are documented in
>  `Documentation/ABI/testing/sysfs-edac-ecs`
> +
> +3. ACPI RAS2 Hardware-based Memory Scrubbing
> +
> +3.1. On demand scrubbing for a specific memory region.
> +
> +3.1.1. Query the status of demand scrubbing
> +
> +# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_demand
> +
> +0
> +
> +3.1.2. Query what is device default/current scrub cycle setting.
> +
> +Applicable to both demand and background scrubbing.
> +
> +# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
> +
> +36000
> +

What units (above)?

> +3.1.3. Query the range of device supported scrub cycle for a memory region.
> +
> +# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/min_cycle_duration
> +
> +3600
> +
> +# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/max_cycle_duration
> +
> +86400
> +

ditto.

> +3.1.4. Program scrubbing for the memory region in RAS2 device to repeat every
> +43200 seconds (half a day).
> +
> +# echo 43200 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
> +
> +3.1.5. Start 'demand scrubbing'.
> +
> +When a demand scrub is started, any background scrub currently in progress
> +will be stopped and then automatically restarted once the demand scrub has
> +completed.

Will it restart where it left off or at the beginning?

> +
> +# echo 1 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_demand
> +
> +3.2. Background scrubbing the entire memory
> +
> +3.2.1. Query the status of background scrubbing.
> +
> +# cat /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background
> +
> +0
> +
> +3.2.2. Program background scrubbing for RAS2 device to repeat in every 21600
> +seconds (quarter of a day).
> +
> +# echo 21600 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/current_cycle_duration
> +
> +3.2.3. Start 'background scrubbing'.
> +
> +# echo 1 > /sys/bus/edac/devices/acpi_ras_mem0/scrub0/enable_background

-- 
~Randy


