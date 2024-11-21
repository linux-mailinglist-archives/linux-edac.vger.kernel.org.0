Return-Path: <linux-edac+bounces-2592-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAF9D4FC9
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F2E1F232BF
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2024 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9EC7083A;
	Thu, 21 Nov 2024 15:35:17 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F741A8F;
	Thu, 21 Nov 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203316; cv=none; b=Ov7u0Opqn6QPUzC47RtAqpyZaUe/FUd/X9gxGQ4hISTDPWp7Pkmakyvj1stGU56+ZdT84fxaXeUjwviWN47MrxcLVLY0PGPLZxoftZBBLioOGXxp92jUS9ZmUwt41adX/DEre+xAi3YUWAufoO+n7C0AHMaNMK6knkKF2XFl1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203316; c=relaxed/simple;
	bh=dr4gMYzCQL9QSHr9YhpsHmstt51l0b4t12o8fMipbP0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkGuxVaygYE2A3FMpBYQuQZMdidtT2ayTL3+XSnh1apKfVmVUwjvdVZcJFJSGgq7ileVrK7BTAWQgSy7/YJ968Gipm6isz65X0Wj5fRPsJrNnRH06IJFxVgmgsszqFrSwbhALb+3G5a8Sa55i4Py9GK8VVb0h0fUGkCJrRb8i9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvMf25Zvcz6K5n8;
	Thu, 21 Nov 2024 23:31:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A881F140133;
	Thu, 21 Nov 2024 23:35:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 16:35:13 +0100
Date: Thu, 21 Nov 2024 15:35:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 10/13] rasdaemon: ras-mc-ctl: Update logging of common
 event data to align with CXL spec rev 3.1
Message-ID: <20241121153511.00005c02@huawei.com>
In-Reply-To: <20241120095923.1891-11-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
	<20241120095923.1891-11-shiju.jose@huawei.com>
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

On Wed, 20 Nov 2024 09:59:20 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> The Common Event Record format in the CXL spec 3.1, section 8.2.9.2.1,
> Table 8-42, has been updated to include Maintenance Operation Subclass
> information.
> 
> This update modifies ras-mc-ctl to log CXL common event data in the RAS
> SQLite database tables, reflecting the specification changes introduced
> in revision 3.1.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Matches what I'd expect to see assuming original code was fine!

Thanks,

Jonathan

