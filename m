Return-Path: <linux-edac+bounces-3283-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD3A5428B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 07:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3CB3AE698
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 06:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1D1A00FE;
	Thu,  6 Mar 2025 06:06:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE336D;
	Thu,  6 Mar 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741241171; cv=none; b=BLLH29zDNAZURltm1MkQbYkuRHxl15xvanIFHX8xxTv5gZMQpeBIz5szaC8JpvtxTnMGjJyAh2GUK0Y7YLdeio0FQDmV1jbrws7o7Rr8s41FV5el5QfhrXQozUltDEivyKd1OuD9p2x6q7EhxNXDlkjYQUMkr2SZUoJ3wbLGhkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741241171; c=relaxed/simple;
	bh=0QBriMyrr0S+pdFueoHFAgKI7U8TnsRyaMmjpWja/LY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ul/g4cuPg0SxT81dtZVIVBC6fqUSLoqt2Hhta+SK55E+I0MhHzxv6zRY/kAzjTOwV2yi2ewZzoYOBvYHBL/RzjSrT8kCub6yYBC/+BU0nLqjM2QxA5Lp+WRECSGuo+5Q1RISD73Ou0BdmZ5nZBMW01Zp0JqbdWWmxvrRr8HIuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7f4N3mY6z6K61Y;
	Thu,  6 Mar 2025 14:03:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D0AF5140CB1;
	Thu,  6 Mar 2025 14:06:05 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Mar
 2025 07:05:55 +0100
Date: Thu, 6 Mar 2025 14:05:50 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <mchehab@kernel.org>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <david@redhat.com>, <Vilas.Sridharan@amd.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/3] ACPI: ACPI 6.5: RAS2: Shorten RAS2 table
 structure and variable names
Message-ID: <20250306140550.00001016@huawei.com>
In-Reply-To: <20250305180225.1226-2-shiju.jose@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
	<20250305180225.1226-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 18:02:22 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Shorten RAS2 table structure and variable names.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

Generally looks reasonable to me, but I'm not sure what your
decision process was for which to shorten and which to leave alone.
Perhaps it is worth mentioning that in the patch description?

> ---
>  include/acpi/actbl2.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2e917a8f8bca..5cfc65ba6e9e 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -2802,20 +2802,20 @@ struct acpi_ras2_pcc_desc {
>  
>  /* RAS2 Platform Communication Channel Shared Memory Region */
>  
> -struct acpi_ras2_shared_memory {
> +struct acpi_ras2_shmem {
>  	u32 signature;
> -	u16 command;
> +	u16 cmd;
>  	u16 status;
>  	u16 version;
>  	u8 features[16];
> -	u8 set_capabilities[16];
> -	u16 num_parameter_blocks;
> -	u32 set_capabilities_status;
> +	u8 set_caps[16];
> +	u16 num_param_blks;
> +	u32 set_caps_status;

I assume focus was on fields that were leading to long line lengths? 
If it was just generally shortening things to common form
sig, sts, ver, feats etc would also seem reasonable to me
(all subject to Tony's question on whether we can touch this at all.)

>  };
>  
>  /* RAS2 Parameter Block Structure for PATROL_SCRUB */
>  
> -struct acpi_ras2_parameter_block {
> +struct acpi_ras2_param_blk {
>  	u16 type;
>  	u16 version;
>  	u16 length;
> @@ -2823,11 +2823,11 @@ struct acpi_ras2_parameter_block {
>  
>  /* RAS2 Parameter Block Structure for PATROL_SCRUB */
>  
> -struct acpi_ras2_patrol_scrub_parameter {
> -	struct acpi_ras2_parameter_block header;
> -	u16 patrol_scrub_command;
> -	u64 requested_address_range[2];
> -	u64 actual_address_range[2];
> +struct acpi_ras2_patrol_scrub_param {
> +	struct acpi_ras2_param_blk header;
> +	u16 cmd;
> +	u64 req_addr_range[2];
> +	u64 actl_addr_range[2];
>  	u32 flags;
>  	u32 scrub_params_out;
>  	u32 scrub_params_in;
> @@ -2839,12 +2839,12 @@ struct acpi_ras2_patrol_scrub_parameter {
>  
>  /* RAS2 Parameter Block Structure for LA2PA_TRANSLATION */
>  
> -struct acpi_ras2_la2pa_translation_parameter {
> -	struct acpi_ras2_parameter_block header;
> -	u16 addr_translation_command;
> +struct acpi_ras2_la2pa_transln_param {
> +	struct acpi_ras2_param_blk header;
> +	u16 cmd;
>  	u64 sub_inst_id;
> -	u64 logical_address;
> -	u64 physical_address;
> +	u64 logical_addr;
> +	u64 phy_addr;
>  	u32 status;
>  };
>  
> @@ -2863,7 +2863,7 @@ enum acpi_ras2_features {
>  
>  /* RAS2 Patrol Scrub Commands */
>  
> -enum acpi_ras2_patrol_scrub_commands {
> +enum acpi_ras2_patrol_scrub_cmds {
>  	ACPI_RAS2_GET_PATROL_PARAMETERS = 1,
>  	ACPI_RAS2_START_PATROL_SCRUBBER = 2,
>  	ACPI_RAS2_STOP_PATROL_SCRUBBER = 3
> @@ -2871,13 +2871,13 @@ enum acpi_ras2_patrol_scrub_commands {
>  
>  /* RAS2 LA2PA Translation Commands */
>  
> -enum acpi_ras2_la2_pa_translation_commands {
> +enum acpi_ras2_la2_pa_transln_cmds {
>  	ACPI_RAS2_GET_LA2PA_TRANSLATION = 1,
>  };
>  
>  /* RAS2 LA2PA Translation Status values */
>  
> -enum acpi_ras2_la2_pa_translation_status {
> +enum acpi_ras2_la2_pa_transln_status {

Do we touch this in the main code?  If not I'd be tempted
to leave decision to shorten this or not to whowever
writes code that uses it.

>  	ACPI_RAS2_LA2PA_TRANSLATION_SUCCESS = 0,
>  	ACPI_RAS2_LA2PA_TRANSLATION_FAIL = 1,
>  };


