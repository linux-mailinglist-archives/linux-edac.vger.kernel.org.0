Return-Path: <linux-edac+bounces-2590-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE99D4FBF
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A821F23005
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38E14B97E;
	Thu, 21 Nov 2024 15:32:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4728687;
	Thu, 21 Nov 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203138; cv=none; b=aCSppTUYMEv/K7ZvdwnTf70/8rpD1594prkamSpuMF+Mjhc1p4gy9npk+uo9Gmo+hzbVxaiMNrvfAQxWnIpnPdu2iQYadhnLAeKw9DWWdou5KfIODeS6zUryqgmWNl7211wewRt24LfZcerP+U4C0keeIP/x1aMJIPNyhIKSagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203138; c=relaxed/simple;
	bh=u98Ig5GK1GiSd9JC7NRJZORtM/ei9pAx0frHHdDaecE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwGe9v/qzSC1wigUoL3E5u7rn9s584TbcjUvQGMtb+KEcL27htRJK9S4yKzjriHiOEIwR9/sUN33oLVx3+aXidp+o1v+XSJw/NU563GL1/7EqCtoqcrg13E3A3dF1YGtLYPJEzvYZwDA/eVqHTEnurzhCSigGG/7qLP8PfEBBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvMc016M8z6J9qF;
	Thu, 21 Nov 2024 23:29:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 58EC5140AB8;
	Thu, 21 Nov 2024 23:32:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:32:11 +0100
Date: Thu, 21 Nov 2024 15:32:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 08/13] rasdaemon: cxl: Update memory module event to CXL
 spec rev 3.1
Message-ID: <20241121153210.00007162@huawei.com>
In-Reply-To: <20241120095923.1891-9-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-9-shiju.jose@huawei.com>
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

On Wed, 20 Nov 2024 09:59:18 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
> has updated with following new fields and new info for Device Event Type
> and Device Health Information fields.
> 1. Validity Flags
> 2. Component Identifier
> 3. Device Event Sub-Type
> 
> Update the parsing, logging and recording of memory module event for the
> above spec rev 3.1 changes.
> 
> Example rasdaemon log for CXL memory module event,
> 
> cxl_memory_module 2024-11-20 00:22:33 +0000 memdev:mem0 host:0000:0f:00.0 \
> serial:0x3 log type:Fatal hdr_uuid:fe927475-dd59-4339-a586-79bab113b774 \
> hdr_handle:0x1 hdr_related_handle:0x0 hdr_timestamp:1970-01-01 00:04:38 \
> +0000 hdr_length:128 hdr_maint_op_class:0 hdr_maint_op_sub_class:1 \
> event_type:Temperature Change event_sub_type:Unsupported Config Data \
> health_status:'MAINTENANCE_NEEDED' 'REPLACEMENT_NEEDED' media_status:All \
> Data Loss in Event of Power Loss as_life_used:Unknown as_dev_temp:Normal \
> as_cor_vol_err_cnt:Normal as_cor_per_err_cnt:Normal life_used:8 \
> device_temp:3 dirty_shutdown_cnt:33 cor_vol_err_cnt:25 cor_per_err_cnt:45 \
> comp_id:02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags:'Resource ID' Resource ID:fc d2 7e 2f
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

