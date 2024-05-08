Return-Path: <linux-edac+bounces-1016-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A0A8C02FD
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 19:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95AD1C219C5
	for <lists+linux-edac@lfdr.de>; Wed,  8 May 2024 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656D884D30;
	Wed,  8 May 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fvqjffhJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F61F93E;
	Wed,  8 May 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188861; cv=none; b=OnZunb7+4UVWJ5t7fli7vynzGcvVSBK/YgQ8EHxMzMGfjxhvel4e3YP+mC9QabEaxSY82rHD8du6gvX/+rmMJ2bSb4T1tMzAxv629ZGCwO96SHIbl2EANsfDG99g7n8oXw6ztKbN3gya5Lqjcj2zPi7rAGen0wiVd22RQDLXyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188861; c=relaxed/simple;
	bh=uGhFaz3ZEGmuUrjwQ7teA3UkMKaXftu/gXxtziwAVi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy9uQpKEjnr2Z6gcjzhEpyBDI14KXSU7MhhM4wutvwR0OUtnxomO51TqGIiY1fceJmw6pT/kjm2E7gyyH0rjkE5e7wLV/TpBXdoVTk8c5CX4rvO9+yPMW4YoaYplgS2EIXUC9CuBfOKgGWr5QJg0YcuWugodqoHDUJ5I37j/nWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fvqjffhJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68A7E40E01A3;
	Wed,  8 May 2024 17:20:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id USGIsJ4iRkpo; Wed,  8 May 2024 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715188851; bh=KEIKoBthxfF5ZooSMkPLx5xV71PW46AVMTRvvSA0KCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvqjffhJ4M+uThL815dccsH2pTfokSuPemLJ9K88wjkeno5kXDSYVYqvV4vy12x+F
	 5dIJfz7lIbyBlBWrgS89XaGlSDVfXC6ldrvl3TBbBZgaIdoCm/TZ3I4hgRL8TxvAqy
	 ajl2E5rAQ/N+b6CqMRFf5PZquChUhaiw/QSdyMtTmgNOAsz7jMlLSnxtLzAmYj7JyP
	 TNZzjdWKsnh8XogqkTdxWWqtYfi+g9aUQ7P3iRPOWKGyDwO9BR8zQACCZk+EvsGPyA
	 m8T3OCOV27ci94XB7yvQ0p8Zx24SYDJjA+SHytzrILc90FyNIJwLZzr6Fkrrhyi2mx
	 Q07aJsfhhUwnplmFknGo7npEpNCjbFYHy97piSZ/XZg478EaQXjFIoVOsSFdSnXGNP
	 3GZLOpO55/jgiSRB68kwCnFLeuo9BGkZc+5MEXoaWSnlvc/W0LOBI/u9fQG4cVygKS
	 k9f8v9wS2v3wOqZNsAMdFdV6YFlODYx08HDlpxas8Hmrc3TRYqaS7fI3/Clx9LoF9r
	 rBKjRKWOkuRpmIC89Q+KkIClvuBUjmLyvtQsDEw0Sef1E0oiKCPidJ8P8nW0SKGr+Q
	 6W9hKgYUYrM/BtLkDNa9+DHBQMHahxPJRxXVaG9kvoeqC53hRGPteWd/FTCjWP4kOc
	 oCMcn8MCGejWoT1ELCE0D8fU=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C5C040E02A6;
	Wed,  8 May 2024 17:20:09 +0000 (UTC)
Date: Wed, 8 May 2024 19:20:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
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
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
Message-ID: <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local>
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-2-shiju.jose@huawei.com>
 <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local>
 <63fdbe26b51f4b7c859bfb30287c8673@huawei.com>
 <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local>
 <e0ce36eb80054440ab877ccee4e606de@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0ce36eb80054440ab877ccee4e606de@huawei.com>

On Wed, May 08, 2024 at 04:59:18PM +0000, Shiju Jose wrote:
> >> I think it happens only when a dependent module as autoloaded based on
> >> a scrub device existing with exception of memory scrub control built
> >> in and who would build this in?
> >
> >You think or you know?
> We know as I had tested.

Does this thing register successfully on a machine which doesn't have
those devices?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

