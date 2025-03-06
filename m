Return-Path: <linux-edac+bounces-3278-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D81A5403B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 03:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639AD16DF9A
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D218C91F;
	Thu,  6 Mar 2025 02:04:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F9029CE1;
	Thu,  6 Mar 2025 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226652; cv=none; b=iGsV0o/pzyNAIzarlci7fQ2d+FUfOf/+98ba8yf4zt7FtO9jE44OaUXPULnlFBFO5C8cyEyGvdGsAySFS3tzFboo5fCj1sGtEbL8pjD2xbVd8zz6kx1GaAu0a5lpbhwReqdw+7Y4O+2MGds9/JBsBBsyIeYwQdD78rmYxFQZx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226652; c=relaxed/simple;
	bh=rzbu8rtSAZpB33a90IoRrnVMFYxmkb1XMg20yDSrOPc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nudgYUkIyI7IDv0jfR4FQS8OwOApnS88avg0WEShyAj2z1BdrwYe07MFaGc9VN8H7hYIyIE9rKH+niTsbNYAc6+J5WptfNZXx4Gf+G6zpp6xMqTMnfA6mR5lj3Fy9cuDAMZDy3Y4ccueaguLVyXHfwZUQLPCCDcQcGNMEYap6W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z7Xj95yfRz6K5rg;
	Thu,  6 Mar 2025 10:01:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B5CC6140CB1;
	Thu,  6 Mar 2025 10:04:06 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Mar
 2025 03:03:56 +0100
Date: Thu, 6 Mar 2025 10:03:51 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "shiju.jose@huawei.com" <shiju.jose@huawei.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"leo.duran@amd.com" <leo.duran@amd.com>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, Somasundaram A
	<somasundaram.a@hpe.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "tanxiaofei@huawei.com"
	<tanxiaofei@huawei.com>, "prime.zeng@hisilicon.com"
	<prime.zeng@hisilicon.com>, "roberto.sassu@huawei.com"
	<roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
	<kangkang.shen@futurewei.com>, "wanghuiqiang@huawei.com"
	<wanghuiqiang@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 1/3] ACPI: ACPI 6.5: RAS2: Shorten RAS2 table
 structure and variable names
Message-ID: <20250306100351.00006035@huawei.com>
In-Reply-To: <SJ1PR11MB6083959730C8EBC504C05ACEFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
	<20250305180225.1226-2-shiju.jose@huawei.com>
	<SJ1PR11MB6083959730C8EBC504C05ACEFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Mar 2025 18:51:57 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> [+Rafael]

Now he gets two copies :)

> 
> > include/acpi/actbl2.h | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)  
> 
> This file is (somewhat) automatically generated from the ACPICA github repository.
> 
> https://github.com/acpica/acpica
> 
> I'm not sure how much divergence from the original is allowed.

Yup, this was basically fishing for Rafael to tell us what we can
get away with or not.

Thanks

Jonathan
> 
> -Tony
> 


