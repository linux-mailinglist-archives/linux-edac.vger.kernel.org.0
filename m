Return-Path: <linux-edac+bounces-2589-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA629D4FB3
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5A41F22C3F
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0151DDC09;
	Thu, 21 Nov 2024 15:30:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B61DC734;
	Thu, 21 Nov 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203002; cv=none; b=Pz1CykM5Q5j+Ce+TtzxMlEZ2WvqH2Meu/Vi+j09DGHQirub6abkynWnjxR6BK7/YWvLyIZxdeO1utOJE67u6Z8SJ4SsCXyeGhBBNwr9U6fMySvQdDlTVQmcumFcxbikw7PxHKgfmdvSvlGqaPy9ctsN5CzaAInoDyQtna2t6zcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203002; c=relaxed/simple;
	bh=p4wnKBqJt3VMigYlnM1GT80CcM5T433I54GB7JdLdKI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBwfdKdIjGSYlWeFg3E+HbQYBoudYn/mQ/pJbatZfNBn6cuuYbWJhuIX4ZCko6DRS1s9hJY6NQSegRcfe/t2/+EvXfTled4i65am5c8QYKVvobomnI0j/0OMobK4baaxLd414HiTlwL9hvfoXm7UYw6fMN9AxOg/3FGqRc29Kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvMYN6wqmz6J9ln;
	Thu, 21 Nov 2024 23:27:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A55A140A79;
	Thu, 21 Nov 2024 23:29:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:29:56 +0100
Date: Thu, 21 Nov 2024 15:29:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 07/13] rasdaemon: cxl: Update CXL DRAM event to CXL spec
 rev 3.1
Message-ID: <20241121152955.000010db@huawei.com>
In-Reply-To: <20241120095923.1891-8-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-8-shiju.jose@huawei.com>
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

On Wed, 20 Nov 2024 09:59:17 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
> with following new fields and new types for Memory Event Type, Transaction
> Type and Validity Flags fields.
> 1. Component Identifier
> 2. Sub-channel
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Memory Error Count at Event
> 5. Memory Event Sub-Type
> 
> Update the parsing, logging and recording of DRAM event for the above
> spec rev 3.1 changes.
> 
> Example rasdaemon log for CXL DRAM event,
> 
> cxl_dram 2024-11-20 00:18:53 +0000 memdev:mem0 host:0000:0f:00.0 serial:0x3 \
> log type:Informational hdr_uuid:601dcbb3-9c06-4eab-b8af-4e9bfb5c9624 \
> hdr_handle:0x1 hdr_related_handle:0x0 hdr_timestamp:1970-01-01 00:00:58 +0000 \
> hdr_length:128 hdr_maint_op_class:1 hdr_maint_op_sub_class:3 dpa:0x18680 \
> dpa_flags:descriptor:'UNCORRECTABLE EVENT' 'THRESHOLD EVENT' \
> memory_event_type:Data Path Error memory_event_sub_type:Media Link CRC Error \
> transaction_type:Internal Media Scrub hpa:0xffffffffffffffff region: \
> region_uuid:00000000-0000-0000-0000-000000000000 channel:3 rank:17 \
> nibble_mask:3866802 bank_group:7 bank:11 row:2 column:77
> correction_mask:21 00 00 00 00 00 00 00 2c 00 00 00 00 00 00 00 37 00 00 \
> 00 00 00 00 00 42 00 00 00 00 00 00 00 comp_id:01 74 c5 08 9a 1a 0b fc d2 \
> 7e 2f 31 9b 3c 81 4d comp_id_pldm_valid_flags:'PLDM Entity ID' \
> PLDM Entity ID:74 c5 08 9a 1a 0b \
> Advanced Programmable CME threshold Event Flags:'Corrected Memory Errors \
> in Multiple Media Components' 'Exceeded Programmable Threshold' \
> CVME Count:0x94
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Also LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

