Return-Path: <linux-edac+bounces-1024-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256CF8C124B
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4246282DDE
	for <lists+linux-edac@lfdr.de>; Thu,  9 May 2024 15:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD416F295;
	Thu,  9 May 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JRWBagkz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9516F26D;
	Thu,  9 May 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270008; cv=none; b=alI9heszSN2DVB15jgrV+XUnx3ZeEG5ptk8M5HvHBNH1WNlkW9FpL/qk5CEIFpc9D88qvr9IY7V5ReHtGlxQ5bcS/U089/SdrZEVcQxnxVNdATWfbvFSqiLEMzyxKSgxC3lsXa/ZtPCmJT9XPhqhgag+zsfzPy9r9iujK48ll40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270008; c=relaxed/simple;
	bh=ca0mhH4z2TzOV3LkiJrw68Zm27sFUEtVVsbmYGap+N8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NDziVNIzfJYUEnHm17vOGaavVKMgnmpqZvGoefRJwiHVB+Ubv8FizE0CI+1yjGbhvS3E+2NfHG83nArFC8rCBCOFB5xAyiifF26CcIzB5XsNwhkKjOiBFnKh3wQduVHnVQ4Fq6l15wy9HfjBfzrwRB2tbtZNzhRM+Ty9Ah+DqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JRWBagkz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 992CD40E0192;
	Thu,  9 May 2024 15:53:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EDO03DZRtCCm; Thu,  9 May 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715269989; bh=9AlP4HXWvzcAtGm0OD798EDYT+YezFL+BRjA+PL3QQo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JRWBagkz83LCvujhKF9Dp/sAwPGFUDlcxCW8ueYmVlDISZiCQ2X2M0PfMdp1vpSzT
	 hXOELsGS2Jdc9HW+J8NcVyrlqh3cZcuPjPFThfBijyaMfcb9Rw1hQwR0AQGjRxUjLX
	 fILr0KPoCthzrNeIdaPdjiJFUYmmie1Rrj+8gQ4ifvVTt0RB6pZjjhWfojaOVSkQuG
	 P7vIjTyIN9JhsfK0LeTMLwjBS9gx4vsKA/LDal5pwK7iW8jlJebMYd7DgGAWTxMwBf
	 Gz+pwTkMhH3V3asQs/nxG0I5GCSGOAc9kT3Lbh0OK011A4blYYD2ystN14in3iE29w
	 TGIdct2oEfPCp4BBlS9TvKjmxDnqe3ggQYVbP4uQMdnRmvC+kclbI+Iyu/k/7+p0tt
	 ZrhBx8tndOJGT9rvv68gueiR+SaFem4D5EqPfhfcb4LzqcCpMM2begGcaBl/ksA12C
	 zs/3eFim5Ark75pZJFlla9L8OnFXA1ZOrWeCS8C5EoJpkwixBJx2xCBjSkO2d4Lzf4
	 rE+qcu4ug3NStDthC51Ze51661C4KXb/ESlAaVKcZTJrzmpQgb2fhOOl02mnkZGgeM
	 IvlYEMsnFT6qgHUV/Hx/o9IvVfiZsLqswDTqgxnwES5Xp1A079PWJ1Wf+bmDgE71i8
	 h03y6BPsWt9FlKZx1JzGzsVw=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3033:20b:71c3:4495:c4f9:c73d:fb52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B623D40E0249;
	Thu,  9 May 2024 15:52:22 +0000 (UTC)
Date: Thu, 09 May 2024 17:52:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Shiju Jose <shiju.jose@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
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
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
 "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH v8 01/10] ras: scrub: Add scrub subsystem
User-Agent: K-9 Mail for Android
In-Reply-To: <20240509101939.0000263a@Huawei.com>
References: <20240419164720.1765-1-shiju.jose@huawei.com> <20240419164720.1765-2-shiju.jose@huawei.com> <20240425101542.GAZiotThrq7bOE9Ieb@fat_crate.local> <63fdbe26b51f4b7c859bfb30287c8673@huawei.com> <20240506103014.GHZjixNhhFkgkMhDg_@fat_crate.local> <e0ce36eb80054440ab877ccee4e606de@huawei.com> <20240508172002.GGZju0QvNfjB7Xm6qL@fat_crate.local> <4ceb38897d854cc095fca1220d49a4d2@huawei.com> <20240508192546.GHZjvRuvtu0XSJbkmz@fat_crate.local> <20240509101939.0000263a@Huawei.com>
Message-ID: <D9511DC1-1566-473A-A426-111BB1F7F9F0@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 9, 2024 11:19:39 AM GMT+02:00, Jonathan Cameron <Jonathan=2ECameron@=
Huawei=2Ecom> wrote:
>Many subsystem core drivers will probe and create subsystem specific
>sysfs directories on on systems that don't have any hardware needing
>drivers from that subsystem (if someone manually inserts them rather
>than relying on automatic module dependency handling=2E)
>I don't see why this class driver should be different and have to jump
>through hoops to satisfy this requirement=2E

You mean it should load because "Look ma, the others do it this way"=2E Do=
es it make any sense? Of course not=2E

Are you arguing for the nonsensical "it should load" case because it is si=
mply easier this way? How hard is that "jump through hoops" thing anyway?

You mean it should load so that when booting an allmodconfig kernel there =
are not enough modules which are loading so lemme load one more=2E And then=
 I need to go and rmmod them all before I need to do localmodconfig and bui=
ld a tailored kernel for the machine=2E

Or is there some other reason to load silly modules, use up resources for =
no good reason whatsoever and bloat the machine?

You mean, f*ck it, right? Who cares=2E=2E=2E

Geez=2E


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

