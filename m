Return-Path: <linux-edac+bounces-2919-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA9A122A4
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 12:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5415F1888348
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87424168D;
	Wed, 15 Jan 2025 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxAa/fZn"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A5211278;
	Wed, 15 Jan 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940934; cv=none; b=tSa4ZV0m+Au4EJUn86LZGvlY+702Sbe/AGRxTf4DVqkwdeFciCySsV+oM1GzUXA+cN7jFW0Fj5Dxwji3SUx19OH2T+gffVQE80BxwV/U4IWql3hLmv3rnN+v8nhCt/fNLv1DyNdxxiwchVJ3F6kqZFjFlAMclH31ED37bMvGHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940934; c=relaxed/simple;
	bh=0GsDX1/RuLPGLESvD1Mlrazvy4i984P60lfK4cHzDVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqqaF4BtiOQ/0kQWyyp2QLOfUWUEa6VLGkWIR/a7tcSpHOZPjlO+ANra/frdMpbUqtQMlAfC+pwp6DbSNnlfAICA24DzcrR/nvmjaP/tihGLjrfNJUbKPDZAjzvsQZzOLt7OH+QRgUFvxbQpvptftygneRKmEAQzJHVfXk3Y/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxAa/fZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10462C4CEDF;
	Wed, 15 Jan 2025 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736940933;
	bh=0GsDX1/RuLPGLESvD1Mlrazvy4i984P60lfK4cHzDVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cxAa/fZnkgoBmd79zeqbHUiOpU1wthso51T9zsiTKQiFBqoKsRbJYsdABlUu/Bd3p
	 jIxohZx4PK2YGuyhwce0xSOx9X//1PxTJcveTF2eu0ytA5NAc7bxGL8s148vSbQGjj
	 NsZuz1fl+wYnOSWG6gUk2Zxmeq6qIToOyYFTT5gU9mjDxBrB0Rkl1ESH3GFiM3Rfj9
	 uKtXFCDudeOcuuQBRiIj5Cfe41gK1YCfmNta/ghWmP+jSxMNJLEb6bEtBWlWN3wf5K
	 zrSi9LOJVAyckZf0044niFYEuDsmmjiVd5piqOuvOT6C16dsMCfilmghHV/baPomb5
	 RibA1bHNoqtwg==
Date: Wed, 15 Jan 2025 12:35:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Borislav Petkov
 <bp@alien8.de>, Shiju Jose <shiju.jose@huawei.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tony.luck@intel.com"
 <tony.luck@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org"
 <mchehab@kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
 <alison.schofield@intel.com>, "vishal.l.verma@intel.com"
 <vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
 <Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
 <rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "naoya.horiguchi@nec.com"
 <naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
 <somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
 <duenwen@google.com>, "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, tanxiaofei
 <tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, "kangkang.shen@futurewei.com"
 <kangkang.shen@futurewei.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v18 04/19] EDAC: Add memory repair control feature
Message-ID: <20250115123522.2c73fa2b@foz.lan>
In-Reply-To: <6786bc792c66a_20f3294ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250109123222.GBZ3_B1g3Esgu1-MPi@fat_crate.local>
	<20250109142433.00004ea7@huawei.com>
	<20250109151854.GCZ3_o3rf6S24qUbtB@fat_crate.local>
	<20250109160159.00002add@huawei.com>
	<20250109161902.GDZ3_29rH-sQMV4n0N@fat_crate.local>
	<20250109183448.000059ec@huawei.com>
	<6780610bc33e9_9b92294cd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20250110110106.00006cd5@huawei.com>
	<6781a3dfa53d6_2aff429471@dwillia2-xfh.jf.intel.com.notmuch>
	<20250113114026.0000548e@huawei.com>
	<6786bc792c66a_20f3294ce@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 14 Jan 2025 11:35:21 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> > There is no way to tell that the topology hasn't changed.
> > For the reasons above, I don't think we care. Instead of trying to stop
> > userspace reparing the wrong memory, make sure it is safe for it to do that.
> > (The kernel is rarely in the business of preventing the slightly stupid)  
> 
> If the policy is "error records with SPA from the current boot can be
> trusted" and "userspace requests outside of current boot error records
> must only be submitted to known offline" then I think we are aligned.

Surely userspace cannot infere if past errors on SPA are for the same DPA
block, but it may still decide between soft/hard PPR based on different
criteria adopted by the machine admins - or use instead memory sparing.

So, yeah sanity checks at Kernel level to identify "trust" level based
on having DPA data or not makes sense, but the final decision about
the action should be taken on userspace.

Thanks,
Mauro

