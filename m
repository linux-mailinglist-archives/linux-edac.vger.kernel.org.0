Return-Path: <linux-edac+bounces-5504-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D3C7C7D8
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 06:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D191E3A5DF6
	for <lists+linux-edac@lfdr.de>; Sat, 22 Nov 2025 05:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAD246762;
	Sat, 22 Nov 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DcFplpsW"
X-Original-To: linux-edac@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BF2110E;
	Sat, 22 Nov 2025 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763788695; cv=none; b=P+v3pr5W1/QCKNQPcaJw9y1mpkamAnovT8FqISehwcCKfWiD3TIM765Pd/DVdaceoqVgwYNsRvK0kCUjQuTrNC+fgLeZeG52mDIkWv61ZH/jC6JB1tkMdFnZ6k1VoRoBT2hdY0B5J3fXGqXWM0uSmBE6lMvTR+CZvwLS6tP23l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763788695; c=relaxed/simple;
	bh=B/+3ispz6TfowVUWhUIN8VdA2eD3nMP3L40xkya8IRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faLPZQR+jd96KoxAQukaodiXI9KFfbF3NWA2qMc0lq/gzgT1yuWuj5DAJClokGRC6U1mF7XU/RDZzENMpcRVUSGw0UU0l8YL78N1JO6ua1oBRqG9fJOK4IhfUxATvrcLaXow2gZHq6ubmEDfsgD3hbt8hRyXHEixnVN1y1Sb4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DcFplpsW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=c0gaRBfWvn8IGRhby2/UXuk4IKDiTlivJjHOE+H2YDs=; b=DcFplpsWT5k4pYl9D1693qDcog
	qmhSlaUvFfSwk41c70YaZXY854MFLgRL6pV7U9NIziMzUGyNYq8Bta8WXPS9BX/dn4MMbeV/t525S
	vZpX7WNOmG9QTlvAl+3djNu6JePghgOBig/SDgT4h74RITKZTZ00GJRth+gfiZLYoLQr+TrXlil0s
	cJuUDOT7S0sS+cylMa595K5U3mNKhcHsGhvF0EG35nZZLST5WYsio9GBYxpD5IocpFGmZIkl2i3s2
	wkhn+xfZZgC0D8+ihsr3c9g7pgSuNEqniLFsLWQ8IEl723qyupMikVdo9xngVFHNkDrfNA8t4w0zu
	/mWmLYzQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMg0d-00000009HED-01iW;
	Sat, 22 Nov 2025 05:18:07 +0000
Message-ID: <af7b6cdc-c0a7-4896-ba6b-6bb933898d37@infradead.org>
Date: Fri, 21 Nov 2025 21:18:05 -0800
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
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..7e7afd2b2ba7 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -46,4 +46,16 @@ config RAS_FMPM
>  	  Memory will be retired during boot time and run time depending on
>  	  platform-specific policies.
>  
> +config MEM_ACPI_RAS2
> +	tristate "Memory ACPI RAS2 driver"
> +	depends on ACPI_RAS2
> +	depends on EDAC
> +	depends on EDAC_SCRUB
> +	help
> +	  The driver binds to the auxiliary device added by the ACPI RAS2
> +	  feature table parser. The driver uses a PCC channel subspace to
> +	  communicating with the ACPI-compliant platform and provides

	  communicate with

> +	  control of the HW-based memory scrubber parameters to the user
> +	  through the EDAC scrub interface.

-- 
~Randy


