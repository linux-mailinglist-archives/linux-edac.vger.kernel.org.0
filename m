Return-Path: <linux-edac+bounces-3337-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE3A59500
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 13:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454C53B1441
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84822A1CB;
	Mon, 10 Mar 2025 12:44:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CC2253E6;
	Mon, 10 Mar 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610665; cv=none; b=dBDjrdQTyO1t1+ZWQ5W3A4U7NoY082ZzNEeoF1BevlMBUzGcKsRG159qX20x2PKx+taZQYv4OKhs9NDIz9vhQ0nJJp4Oved0cVeP6/iPaUFyfqEnB+ETNmTVqqW96a7hWkv/LXAhM8T/9GZ/zPJB8eV/PJbK59iJfbsYBEbFSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610665; c=relaxed/simple;
	bh=uH+sZDT/+u9Xsuiowtq09BO7Ga7yEOnPdwZTgyvS4HQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAN/+i6ZEb5aNpx0LIPepTE1bvKNRIbyidltl/yrtIYCnHg6ceuz+Wht7P8nVFxxwgyUNeywwQgZtgHFVKd1xPsk1/njYBLrTYorxe6CCE4yNYPQzVpVQWuNotl8HsOEt/VVkPctbr+uP7a8Uqc3l2y13C4H9gQExA79jxscI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBGj534jzz67Ldy;
	Mon, 10 Mar 2025 20:41:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AC6691405E3;
	Mon, 10 Mar 2025 20:44:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Mar
 2025 13:44:17 +0100
Date: Mon, 10 Mar 2025 12:44:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>, "dferguson@amperecomputing.com"
	<dferguson@amperecomputing.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "leo.duran@amd.com"
	<leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250310124415.0000710a@huawei.com>
In-Reply-To: <a0b319b4f42c4286a120fbb88a88adeb@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
	<20250305180225.1226-3-shiju.jose@huawei.com>
	<20250306171925.00002721@huawei.com>
	<a0b319b4f42c4286a120fbb88a88adeb@huawei.com>
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

> >> +#define RAS2_PCC_CMD_COMPLETE	BIT(0)
> >> +#define RAS2_PCC_CMD_ERROR	BIT(2)
> >> +  
> >I think these bits are from table 14.11 and
> >generic to all PCC status registers? Should these
> >have more generic names rather than ras2 specific ones?  
> Yes.
> Instead will use PCC_STATUS_CMD_ COMPLETE and  PCC_STATUS_ ERROR
> from include/acpi/pcc.h. 
> 
> >  
> >> +/* RAS2 specific PCC commands */
> >> +#define RAS2_PCC_CMD_EXEC 0x01  
> >Are we mixing commands and field definitions both
> >with prefix RAS2_PCC_CMD_ ?  That is somewhat
> >confusing.  
> Will add Table 5.82: .. here in the comment and 
> Is rename to PCC_CMD_ EXEC_RAS2  better?

That seems OK to me.


For things you agree with feel free to just crop out that bit
of the email so it is easier to spot the remaining questions.

Thanks,

Jonathan


