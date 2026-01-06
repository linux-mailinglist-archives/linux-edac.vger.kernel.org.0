Return-Path: <linux-edac+bounces-5598-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89930CF9409
	for <lists+linux-edac@lfdr.de>; Tue, 06 Jan 2026 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53EF3300E633
	for <lists+linux-edac@lfdr.de>; Tue,  6 Jan 2026 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A6250BEC;
	Tue,  6 Jan 2026 15:57:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEB1F92E;
	Tue,  6 Jan 2026 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715046; cv=none; b=kPskyllThPz5SV/77VU0MOKm7KyvWsRssN8BNQKN1gNmyAaFkAzRNFhCpR8Rrc2AZV81b3sFxVv56HYdOrn+m58EAsTY68AGM7zm4mtnZDSLlRhB/6+1HI0OMTs0Ss7YoFFQi0uxRzfYK+0/VUl+jfIxfBYPNLa7coz9LQsSl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715046; c=relaxed/simple;
	bh=sczc55+fbSx80qG3XvqhfTOzzhPRkPUZqp0rkYALOws=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTxr6ROfhjFr3gYv+ER013mAFuolp5alvhaEi164wTQX2mgmSZepqtVbmECQw364nwkUW5TKFAi0chbRZpFAmx3MkJU7Py4BL13glINIb+j/6EePu3Jx/AqHibtvTgQ3b+Aa9C5T7xSie7K+7ZWpfq6U+xgpHQz9yc+g++Uresk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlwlz41BlzJ46wT;
	Tue,  6 Jan 2026 23:57:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5766A4056F;
	Tue,  6 Jan 2026 23:57:21 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 15:57:20 +0000
Date: Tue, 6 Jan 2026 15:57:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Ankit Agrawal
	<ankita@nvidia.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao
	<leitao@debian.org>, Hanjun Guo <guohanjun@huawei.com>, Jason Tian
	<jason@os.amperecomputing.com>, Len Brown <lenb@kernel.org>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck
	<tony.luck@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, pengdonglin
	<pengdonglin@xiaomi.com>
Subject: Re: [PATCH v4 1/4] apei/ghes: ARM processor Error: don't go past
 allocated memory
Message-ID: <20260106155716.00002a41@huawei.com>
In-Reply-To: <d93b8fb237ac1bb1d8cef4f4f48660dc1b32b673.1767693532.git.mchehab+huawei@kernel.org>
References: <cover.1767693532.git.mchehab+huawei@kernel.org>
	<d93b8fb237ac1bb1d8cef4f4f48660dc1b32b673.1767693532.git.mchehab+huawei@kernel.org>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  6 Jan 2026 11:01:35 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> If the BIOS generates a very small ARM Processor Error, or
> an incomplete one, the current logic will fail to deferrence
> 
> 	err->section_length
> and
> 	ctx_info->size
> 
> Add checks to avoid that. With such changes, such GHESv2
> records won't cause OOPSes like this:
> 
> [    1.492129] Internal error: Oops: 0000000096000005 [#1]  SMP
> [    1.495449] Modules linked in:
> [    1.495820] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.18.0-rc1-00017-gabadcc3553dd-dirty #18 PREEMPT
> [    1.496125] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> [    1.496433] Workqueue: kacpi_notify acpi_os_execute_deferred
> [    1.496967] pstate: 814000c5 (Nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    1.497199] pc : log_arm_hw_error+0x5c/0x200
> [    1.497380] lr : ghes_handle_arm_hw_error+0x94/0x220
> 
> 0xffff8000811c5324 is in log_arm_hw_error (../drivers/ras/ras.c:75).
> 70		err_info = (struct cper_arm_err_info *)(err + 1);
> 71		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
> 72		ctx_err = (u8 *)ctx_info;
> 73
> 74		for (n = 0; n < err->context_info_num; n++) {
> 75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
> 76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
> 77			ctx_len += sz;
> 78		}
> 79
> 
> and similar ones while trying to access section_length on an
> error dump with too small size.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Hi Mauro,

Resolved the stuff I pointed out in previous, so LGTM.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

