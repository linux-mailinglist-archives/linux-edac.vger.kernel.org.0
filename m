Return-Path: <linux-edac+bounces-1028-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186108C18C4
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30762839BD
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C61292CC;
	Thu,  9 May 2024 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fBXhR9tG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16C12838F;
	Thu,  9 May 2024 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291569; cv=none; b=uqlT/+jC7sPGIH+XUF+BryMNt3i2/GqCgSO29swIAeaKjCpZ/+rwOSOn3eSc3+HCcmmdzwN+8L2a+RvSIlKloA490poOkOVB5+TfJj/bi8iMnVa/Dox2Qv6yMm23wOy4FijDL/uvmZN+4Q6qLfFkYQooUuWb/kn0iQ742UqO9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291569; c=relaxed/simple;
	bh=3bwfLA39L9ZeBcaoofJ14Sx9si3+pwfwvAVG305iFhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovHEHPpRYrCbSHxMHGLzM5DPVhxDeikvjkADgeN4Dr22pv+f9Ce/3qx2QJUnVVa4A7x6zUhlVgcuPG3c0jF1Mv9hTSfYB8gwQr/Dgwj4Ijz/xhw3SH8Zi8XTzY+VeySftmaoOlDll6UzhxB7YEh9w14SbTh7CZer4IfblyZsHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fBXhR9tG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0289840E0192;
	Thu,  9 May 2024 21:52:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TOba2Rxo919j; Thu,  9 May 2024 21:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715291560; bh=tpDh3EbGnG3/bwl8KzPdGOE+DAN1ew75iViGriFZC/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBXhR9tGWcdOWe23rNttop//56eTyyDpeXNpJ4lSMVVQPLYUrBtpTfBVn7gGo/QWj
	 zyvH325uv/DDZMSFrXD4Q9RP3gX6kAwFV8tRfZxNbGLyxJ7WgJ4aYKD6mXWj+e6Qnv
	 I6i4UVZXvLmVN1pExwumnJMdf9SiZJHWCmrQ+2xVJzNBt88vHm2m3B3S+sAXQ6pbmv
	 5DSIrQWewjUb1nPUw1XgVc3FdErhFXT/hy3OFVKhZfdVU0oGIPs+e7p2IMgELyIz2I
	 IIlxNcPJfuehKsogqTd5cLKphDvHoWpUsdScQtfqZZejGokQaiFQ88LR4xERD9bnZw
	 qVLHWhNf3pz69YzJoMYo1dJBubzrzSdII69o1QJLbA/Y/1zgD5PK9OWZqfrlPG2lVZ
	 tabluFfN+2Bm/BvKRVyrCmCEyk03K/SRxsP71Co0U81msPhvVQv1KOR3WDvat7iz4K
	 8b08YGKo3HQQpH6gYWyqAFfudXshulv3DBQWFZna12k20MoR3lKsIDjlaNa9KzQb+U
	 +ieZ5wwKXM2+GWcl3sAXbdapZSHeOFARb5t9AvptZu6nY9n8Zu96CXgktCMGwPxxXZ
	 srf+BGCDDp/r6NqBQfaQh+g8XANaQw7sfMuLHaaERkbx59uPzCgafGKrZVuRz2nfVd
	 eQ5btGVipzvCBQ3nTI/JzKKU=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5EB940E0249;
	Thu,  9 May 2024 21:51:53 +0000 (UTC)
Date: Thu, 9 May 2024 23:51:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240509215147.GBZj1Fc06Ieg8EQfnR@fat_crate.local>
References: <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
 <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
 <4ceb38897d854cc095fca1220d49a4d2@huawei.com>
 <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local>
 <20240509101939.0000263a@Huawei.com>
 <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
 <20240509200306.GAZj0r-h5Tnc0ecIOz@fat_crate.local>
 <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <663d3e58a0f73_1c0a1929487@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, May 09, 2024 at 02:21:28PM -0700, Dan Williams wrote:
> Recall that there are 461 usages of module_pci_driver() in the kernel.
> Every one of those arranges for just registering a PCI driver when the
> module is loaded regardless of whether any devices that driver cares
> about are present.

Sorry, I read your text a bunch of times but I still have no clue what
you're trying to tell me.

All *I* am saying is since this is a new subsystem and the methods for
detecting the scrub functionality are two - either an ACPI table or
a GET_SUPPORTED_FEATURES command, then the init function of the
subsystem:

+static int __init memory_scrub_control_init(void)
+{
+       return class_register(&scrub_class);
+}
+subsys_initcall(memory_scrub_control_init);

can check for those two things before initializing.

If there is no scrubbing functionality, then it can return an error and
not load.

The same as when we don't load x86 drivers on the wrong vendor and so
on.

If the check is easy, why not do it?

Make more sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

