Return-Path: <linux-edac+bounces-2588-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2799D4FAF
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBFBB214E2
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF91D7E4E;
	Thu, 21 Nov 2024 15:27:31 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEC1D79BE;
	Thu, 21 Nov 2024 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202851; cv=none; b=sNklB4fXD+9g3oAVTv19XOTWO+taQRV0SSD5kUoPLxiWD+yGQLDYNsMKiW1i0WCQaqDhPuflcdJBXVCg16bEMg3GSTDftPwGOHqcdcQWRvqwqbKwvHQc+jol4qgqGd9DYfFdyx787f1xupTttSUoPuHGe1a8ZkpFmV6J696OKcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202851; c=relaxed/simple;
	bh=lWmz3RHURceLQQy1kUYqJTKZtC598garbXLXaNLqxqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO4ZwJ/6xk0qJ5yxBMRHD8x4xGsZc4z00OE3mXNCf280mD12OH5kIti6474D/LOrZIOq5knNWM+2qeRHv0eloq1GENlWwMVQqkjF+ReaK7SzhGNmeJqYHn81FRSzuVWzmfeK048AB9AKxYqfT2+9Rcyyy7sgXu5KMKL9Zxf5Aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvMT40NCdz6J747;
	Thu, 21 Nov 2024 23:23:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DA59F140A86;
	Thu, 21 Nov 2024 23:27:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:27:26 +0100
Date: Thu, 21 Nov 2024 15:27:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 06/13] rasdaemon: cxl: Update CXL general media event to
 CXL spec rev 3.1
Message-ID: <20241121152724.0000281e@huawei.com>
In-Reply-To: <20241120095923.1891-7-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-7-shiju.jose@huawei.com>
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

On Wed, 20 Nov 2024 09:59:16 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
> Record has updated with following new fields and new types for Memory
> Event Type and Transaction Type fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 
> The format of component identifier has changed (CXL spec 3.1 section
> 8.2.9.2.1 Table 8-44).
> 
> Update the parsing, logging and recording of general media event for
> the above spec changes.
> 
> Example rasdaemon log for CXL general media event,
> 
> cxl_general_media 2024-11-20 00:00:49 +0000 memdev:mem1 host:0000:0f:00.0 \
> serial:0x3 log type:Fatal hdr_uuid:fbcd0a77-c260-417f-85a9-088b1621eba6 \
> hdr_handle:0x1 hdr_related_handle:0x0 hdr_timestamp:1970-01-01 00:00:49 +0000 \
> hdr_length:128 hdr_maint_op_class:2 hdr_maint_op_sub_class:4 dpa:0x30d40 \
> dpa_flags:descriptor:'UNCORRECTABLE EVENT' 'THRESHOLD EVENT' 'POISON LIST OVERFLOW' \
> memory_event_type:TE State Violation memory_event_sub_type:Media Link Command \
> Training Error transaction_type:Host Inject Poison hpa:0xffffffffffffffff \
> region: region_uuid:00000000-0000-0000-0000-000000000000 channel:3 rank:33 \
> device:5 comp_id:03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags:'PLDM Entity ID' 'Resource ID' \
> PLDM Entity ID:74 c5 08 9a 1a 0b Resource ID:fc d2 7e 2f \
> Advanced Programmable CME threshold Event Flags:'Corrected Memory Errors in \
> Multiple Media Components' 'Exceeded Programmable Threshold' \
> Corrected Memory Error Count:0x78
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

