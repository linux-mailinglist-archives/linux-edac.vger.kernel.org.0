Return-Path: <linux-edac+bounces-3292-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A0A55C9C
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 02:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE853B7571
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3BF40C03;
	Fri,  7 Mar 2025 01:05:16 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984F013EFE3;
	Fri,  7 Mar 2025 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309516; cv=none; b=B80J2vG6KSqFmTC6Vdx4Bd/B1jaqWdlAZXVHlrDQuM1xFcyUtmOmN7uT5EMeYE1unR2qupsHrdTpNAwYD2a2HRMEZv9ZKVcxSjIVdFffF1ZZvKiRjsafZnUuEt9ly/kiTGtp+KO/aDJFpODu5w8etuyNkacecDX09+Ja6eUhQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309516; c=relaxed/simple;
	bh=iT4L85opwyMetiHe/dw31SlIVrfCG0FPmLno1+AEmsc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGfmon53bxOfZSSaVJQa1N+C0d8sLHCiMNX4bilGsMcLtZCpZMRVCmrq8svTg9zL6dQFL7ze++rzW4W3Gmc6iyQTKUeNr5RY1LzlpIn/3hrNuvqAYi6fXhM5JxwZy2LVyDqXO37d8+pWDgO1n6QCCqkSoKDdgs7NCv8IH2yIo8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z87Kw5p2Zz6J7Yk;
	Fri,  7 Mar 2025 09:02:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E9E51403A2;
	Fri,  7 Mar 2025 09:05:12 +0800 (CST)
Received: from localhost (10.48.43.65) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Mar
 2025 02:05:00 +0100
Date: Fri, 7 Mar 2025 09:04:55 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <david@redhat.com>,
	<Vilas.Sridharan@amd.com>, <linux-edac@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<leo.duran@amd.com>, <Yazen.Ghannam@amd.com>, <rientjes@google.com>,
	<jiaqiyan@google.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <jthoughton@google.com>,
	<somasundaram.a@hpe.com>, <erdemaktas@google.com>, <pgonda@google.com>,
	<duenwen@google.com>, <gthelen@google.com>, <wschwartz@amperecomputing.com>,
	<dferguson@amperecomputing.com>, <wbs@os.amperecomputing.com>,
	<nifan.cxl@gmail.com>, <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 7/8] cxl/memfeature: Add CXL memory device soft PPR
 control feature
Message-ID: <20250307090455.00001767@huawei.com>
In-Reply-To: <20250227223816.2036-8-shiju.jose@huawei.com>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
	<20250227223816.2036-8-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 22:38:14 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Post Package Repair (PPR) maintenance operations may be supported by CXL
> devices that implement CXL.mem protocol. A PPR maintenance operation
> requests the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support PPR features
> may implement PPR Maintenance operations. DRAM components may support two
> types of PPR, hard PPR (hPPR), for a permanent row repair, and Soft PPR
> (sPPR), for a temporary row repair. Soft PPR is much faster than hPPR,
> but the repair is lost with a power cycle.
> 
> During the execution of a PPR Maintenance operation, a CXL memory device:
> - May or may not retain data
> - May or may not be able to process CXL.mem requests correctly, including
> the ones that target the DPA involved in the repair.
> These CXL Memory Device capabilities are specified by Restriction Flags
> in the sPPR Feature and hPPR Feature.
> 
> Soft PPR maintenance operation may be executed at runtime, if data is
> retained and CXL.mem requests are correctly processed. For CXL devices with
> DRAM components, hPPR maintenance operation may be executed only at boot
> because typically data may not be retained with hPPR maintenance operation.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a PPR maintenance operation by using
> an Event Record, where the Maintenance Needed flag is set. The Event Record
> specifies the DPA that should be repaired. A CXL device may not keep track
> of the requests that have already been sent and the information on which
> DPA should be repaired may be lost upon power cycle.
> The userspace tool requests for maintenance operation if the number of
> corrected error reported on a CXL.mem media exceeds error threshold.
> 
> CXL spec 3.2 section 8.2.10.7.1.2 describes the device's sPPR (soft PPR)
> maintenance operation and section 8.2.10.7.1.3 describes the device's
> hPPR (hard PPR) maintenance operation feature.
> 
> CXL spec 3.2 section 8.2.10.7.2.1 describes the sPPR feature discovery and
> configuration.
> 
> CXL spec 3.2 section 8.2.10.7.2.2 describes the hPPR feature discovery and
> configuration.
> 
> Add support for controlling CXL memory device soft PPR (sPPR) feature.
> Register with EDAC driver, which gets the memory repair attr descriptors
> from the EDAC memory repair driver and exposes sysfs repair control
> attributes for PRR to the userspace. For example CXL PPR control for the
> CXL mem0 device is exposed in /sys/bus/edac/devices/cxl_mem0/mem_repairX/
> 
> Add checks to ensure the memory to be repaired is offline and originates
> from a CXL DRAM or CXL gen_media error record reported in the current boot,
> before requesting a PPR operation on the device.
> 
> Tested with QEMU patch for CXL PPR feature.
> https://lore.kernel.org/all/20240730045722.71482-1-dave@stgolabs.net/
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



