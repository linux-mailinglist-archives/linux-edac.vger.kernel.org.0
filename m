Return-Path: <linux-edac+bounces-2594-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F429D4FDE
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD62B28411A
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC815539F;
	Thu, 21 Nov 2024 15:37:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBCC7083A;
	Thu, 21 Nov 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203463; cv=none; b=QYFf/V/0+YQHdm4FpJQXV7+wMGca7q8lb/5KUquE0hlrBSpeoAZvXR+2EJxUcwUDROuHmxLhsduUSOagDKCjQE7KNy93VPM96teVaXfXfC8IWp8Ch7D1a7DeBQDVspOLl7rWctLKEEuVq83AVVGyLd0t3JHSVe1BK4UJneX+h6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203463; c=relaxed/simple;
	bh=eicvo9euS+DzftFX3mM2ap5BIEmG2s8iaUPseCX0ULU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PErVSPCe3fCYigRAZUMGynM5XXNUb2Tu69wLcuXZbCcfJZbikJ1Gf/c/6GJtBTQfo+G3jjkCW9nKyLV/REqNAEB0RaIlYpQ9JQg5qP42WlrXx6M9+KEjyqLFcGzPtWVs1mrUdqvsYzwBOdvYmz4IuzWLCLvgEvtNkQzMgwqIGso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvMmV5mC6z6LD4b;
	Thu, 21 Nov 2024 23:37:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2C87140A86;
	Thu, 21 Nov 2024 23:37:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:37:38 +0100
Date: Thu, 21 Nov 2024 15:37:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 12/13] rasdaemon: ras-mc-ctl: Update logging of CXL DRAM
 event data to align with CXL spec rev 3.1
Message-ID: <20241121153736.000001af@huawei.com>
In-Reply-To: <20241120095923.1891-13-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-13-shiju.jose@huawei.com>
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

On Wed, 20 Nov 2024 09:59:22 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
> with following new fields and new types for Memory Event Type, Transaction
> Type and Validity Flags fields.
> 1. Component Identifier
> 2. Sub-channel
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Volatile Memory Error Count at Event
> 5. Memory Event Sub-Type
> 
> This update modifies ras-mc-ctl to parse and log CXL DRAM event data
> stored in the RAS SQLite database table, reflecting the specification
> changes introduced in revision 3.1.
> 
> Example output,
> 
> ./util/ras-mc-ctl --errors
> ...
> CXL DRAM events:
> 1 2024-11-20 00:18:53 +0000 error: memdev=mem0, host=0000:0f:00.0, serial=0x3, \
> log=Informational, hdr_uuid=00000000-0000-0000-0000-000000000000, \
> hdr_flags=0x1, , hdr_handle=0x1, hdr_related_handle=0x0, \
> hdr_timestamp=1970-01-01 00:00:58 +0000, hdr_length=128, hdr_maint_op_class=1, \
> hdr_maint_op_sub_class=3, dpa=0x18680, dpa_flags: , \
> descriptor_flags: 'UNCORRECTABLE EVENT' , 'THRESHOLD EVENT' , \
> memory event type: Data Path Error, memory event sub type: Media Link CRC Error, \
> transaction_type: Internal Media Scrub, channel=3, sub_channel=0, rank=17, \
> nibble_mask=3866802, bank_group=7, bank=11, row=2, column=77, \
> correction_mask:21 00 00 00 00 00 00 00 2c 00 00 00 00 00 00 00 37 00 00 \
> 00 00 00 00 00 42 00 00 00 00 00 00 00 hpa=0xffffffffffffffff, \
> region_uuid=00000000-0000-0000-0000-000000000000, \
> component_id:01 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> pldm_entity_id:74 c5 08 9a 1a 0b pldm_resource_id:00 00 00 00 \
> cme_threshold_ev_flags: 'Corrected Memory Errors in Multiple Media Components' , \
> 'Exceeded Programmable Threshold' , cvme_count=0x94, 
> ...
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Changes as expected...

