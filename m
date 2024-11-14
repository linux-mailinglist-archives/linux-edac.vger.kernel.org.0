Return-Path: <linux-edac+bounces-2552-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE07C9C8BE3
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 14:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1941F22D28
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC85F9E6;
	Thu, 14 Nov 2024 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T5g2Oc5o"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F83FC7;
	Thu, 14 Nov 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591232; cv=none; b=jbxOBzMHjCqqFxk6YUSGwAp1U6JJ4DnMHDaVJH/e8lgTX7qoKktc+nAgm+dTwLC3/5Wlt9aylu6b5Mm56ssNYFQnDLsvzN8KmqQhvL9P9lSDAlWLgLrevOrWRuvmtEyOeO8eGAeks93Rwd9bljyiTWixu7J4OIT2hLfPGV7VEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591232; c=relaxed/simple;
	bh=2xiJu4tCdfug0kLfNZ2FHlvGQ+fuMB/tEE3osYDVWMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeryZMLwVP3URCfma4+TICDR+BOWz7uL6V2OzFnI+C+3qyqCFm2qFccr3eju2pIIMpEBRxw/BUZ0OWaAa0NA1c6XwoIamQdy5kfz29OdgGDbs95PdoNXT41sXmwJf7Dsc/BVEzoM/K4s4x4v3RnroDY+ldSrJVfdZbyLfTN/Xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T5g2Oc5o; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 58C6B40E0219;
	Thu, 14 Nov 2024 13:33:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 316gSpFbc922; Thu, 14 Nov 2024 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731591221; bh=GZYwjf6zGx9udTtaH3+hhtQ6x1jYJyXBlIbM0yeiO5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5g2Oc5o69eG3jsf6mBpCHztBXlMBpkivbs/iA7wr1T6ClhAWkJsmSRRjmrQuYZ0t
	 qLxNWWb+LKMqSf8OTEQ0PE7TKpejtVjlDHOv+EDfMPeiwMHeCA6wbhA9pLvyeCVjRp
	 aLtgiK9sAA47jt57Dn+YJ25TpjwHSU0w7lyQNEuzSKwnLDpySW8/NVLngNjNSzpEDm
	 6Y88BlzR3QbNs30cqoJzAoh93ciRZY6gcf2bCRQi/CMX7opH8bT9lBmWlKW7wXSMNj
	 8/c1EKHGTE5ZSR2czipKQmruxgoIdUwVwaeX2DYMRxJB2cCqPOp9mjR0TvQ1+kYA4i
	 kQYRmXbK4VBSddFVX3esmsEBTfmlt/bf4o5m8ihWNtxjvL7c41fUEj8TQrMQkYj2h5
	 Z419ubN4v1W/twM5eU31nd6wqlSh51cIrYcuB4cgYEpngFX19TShYzeNig9xTtFbvJ
	 49IRcATSuyUwk2Ks+hcs4kJ1Rhz0SzaR09uXtUJs0EAIi6d27TnhBl0VMF6paTn4jR
	 PhSve6VOw5mkIfOq7jxLF0qugh4+d/HMWIMoon8fR7m18XJATaxEFs34tuqA1u/lv9
	 PskfU5eXhWr3Juu9iohU55XdnVotErWAurcfV3CYSP058ooVVoxQgUQmdV0Wo8NeHf
	 wANn36QRtKuVGTc2m6QeMJ5c=
Received: from zn.tnic (p200300ea973a314f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:973a:314f:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B18940E0163;
	Thu, 14 Nov 2024 13:32:54 +0000 (UTC)
Date: Thu, 14 Nov 2024 14:32:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v15 11/15] EDAC: Add memory repair control feature
Message-ID: <20241114133249.GEZzX8ATNyc_Xw1L52@fat_crate.local>
References: <20241101091735.1465-1-shiju.jose@huawei.com>
 <20241101091735.1465-12-shiju.jose@huawei.com>
 <20241104061554.GOZyhmmo9melwI0c6q@fat_crate.local>
 <1ac30acc16ab42c98313c20c79988349@huawei.com>
 <20241111112819.GCZzHqUz1Sz-vcW09c@fat_crate.local>
 <7fd81b442ba3477787f5342e69adbb96@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fd81b442ba3477787f5342e69adbb96@huawei.com>

On Mon, Nov 11, 2024 at 04:54:48PM +0000, Shiju Jose wrote:
> Presently, 0 (soft memory repair) and 1 (hard memory repair),  depends on
> which mode/s a memory device is supported. 

What if the device supports more than one mode?

> However for CXL memory sparing feature, the persistent mode is configurable at runtime
> for a memory sparing instance, thus both soft and hard sparing are supported.
> Example given for CXL memory sparing feature in Documentation/edac/memory_repair.rst,
> root@localhost:~# cat /sys/bus/edac/devices/cxl_mem0/mem_repair1/persist_mode_avail
> 0,1

Ok, and how is the user supposed to know what those mean?

> Kernel sysfs doc mentioned about array of values as follows, though not seen much examples. 
> https://docs.kernel.org/filesystems/sysfs.html
> "Attributes should be ASCII text files, preferably with only one value per file. It is noted that
> it may not be efficient to contain only one value per file, so it is socially acceptable to express
> an array of values of the same type."

True story. Ok, so there's an exception to that rule.

> The values of these attributes are specific to device and portion of the memory to repair. 
> For example, In CXL repair features,
> CXL memory device identifies a failure on a memory component, device provides the corresponding
> values of the attributes (DPA, channel, rank, nibble mask, bank group, bank, row, column or sub-channel etc)
> in an event record to the host and to the userspace in the corresponding trace event.  
> Userspace shall use these values for the query resource availability and repair operations.

I don't think you're answering my question. Lemme try again:

I am on a machine with such an interface. I do

echo 0xdeadbeef > /sys/devices...
-EINVAL

echo 0xface > ...
-EINVAL

How do I know what the allowed ranges are?

> This will work for the CXL PPR feature where the result of the query operation for resources  availability
> return to the command, however for the CXL memory sparing features,  the result of the query resources 
> availability command returned later in a Memory Sparing Event Record from the device. 
> Userspace shall issue repair operation with the attributes values received on the Memory Sparing trace event.
> Thus for the CXL memory sparing feature, query for resources availability and repair operation 
> cannot be combined.

What happens if the resources availability changes between the query and the
start of the repair operation?

The cat catches fire?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

